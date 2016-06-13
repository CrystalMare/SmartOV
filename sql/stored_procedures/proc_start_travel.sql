USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_START_TRAVEL', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_START_TRAVEL
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_START_TRAVEL -- EXAMPLE NAME
    @kaartid   UNIQUEIDENTIFIER, -- EXAMPLE PARAMETERS
    @stationid UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  DECLARE @accountid UNIQUEIDENTIFIER = (SELECT ACCOUNTID
                                         FROM dbo.KAART
                                         WHERE KAARTID = @kaartid)

  IF @accountid IS NULL
    RAISERROR (56192, 16, 1)

  IF
  (SELECT SALDO
   FROM dbo.ACCOUNT
   WHERE ACCOUNTID = @accountid) < 20
    RAISERROR (56190, 16, 1)

  IF NOT EXISTS(SELECT 1
                FROM dbo.KAART
                WHERE KAARTID = @kaartid)
    RAISERROR (56191, 16, 1)

  IF NOT EXISTS(SELECT 1
                FROM dbo.REIS
                WHERE KAARTID = @kaartid AND EINDPUNT IS NULL)
    BEGIN
      INSERT INTO dbo.REIS (REISID, ACCOUNTID, BEGINPUNT, KAARTID)
      VALUES (
        NEWID(),
        @accountid,
        @stationid,
        @kaartid
      )
    END

  ELSE
    BEGIN

      DECLARE @reisid UNIQUEIDENTIFIER = (SELECT REISID
                                          FROM dbo.REIS
                                          WHERE KAARTID = @kaartid
                                                AND
                                                EINDPUNT IS NULL)

      DECLARE @korting MONEY = (SELECT TOP 1 KORTING
                                FROM dbo.PRODUCT_OP_KAART
                                  JOIN dbo.REISPRODUCT ON PRODUCT_OP_KAART.REISPRODUCTID = REISPRODUCT.REISPRODUCTID
                                  JOIN dbo.KORTINGSREISPRODUCT
                                    ON REISPRODUCT.REISPRODUCTID = KORTINGSREISPRODUCT.REISPRODUCTID
                                WHERE KAARTID = @kaartid
                                ORDER BY KORTING);




      DECLARE @costs MONEY = (20 * (1 - @korting / 100))

      UPDATE dbo.REIS
      SET EINDPUNT = @stationid,
        PRIJS      = @costs
      WHERE REISID = @reisid
    END

  IF @TranCounter = 0
    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    IF @TranCounter = 0
      ROLLBACK TRANSACTION;
    ELSE
      IF XACT_STATE() <> -1
        ROLLBACK TRANSACTION ProcedureSave;

    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE();
    SELECT @ErrorSeverity = ERROR_SEVERITY();
    SELECT @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH


