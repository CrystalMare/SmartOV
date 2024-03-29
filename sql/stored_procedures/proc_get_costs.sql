USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_GET_COSTS', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_GET_COSTS
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_COSTS -- EXAMPLE NAME
    @accountid UNIQUEIDENTIFIER, -- EXAMPLE PARAMETERS
    @van       DATE,
    @tot       DATE
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS(SELECT 1
                FROM dbo.ACCOUNT
                WHERE ACCOUNTID = @accountid)
    RAISERROR (56110, 16, 1)

  DECLARE @money MONEY = (SELECT SUM(PRIJS) AS totalekosten
                          FROM dbo.REIS
                          WHERE ACCOUNTID = @accountid
                                AND
                                REIS.UITCHECKDATUM < @tot
                                AND
                                REIS.UITCHECKDATUM > @van)

  IF @money IS NULL
      SET @money = 0;

  SELECT @money AS totalekosten;

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
