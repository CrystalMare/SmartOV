USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_CREATE_KORTINGSREISPRODUCT', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_CREATE_KORTINGSREISPRODUCT
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_CREATE_KORTINGSREISPRODUCT -- EXAMPLE NAME
    @geldigheid int,
    @naam VARCHAR(255),
    @korting int
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF @korting < 1 OR @korting > 100
      RAISERROR (56250, 16, 1);

  IF @geldigheid < 1
      RAISERROR (56251, 16, 1);

  DECLARE @reisproductid UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.REISPRODUCT(REISPRODUCTID, NAAM, GELDIGHEID)
  VALUES (
    @reisproductid,
    @naam,
    @geldigheid
  )

  INSERT INTO dbo.KORTINGSREISPRODUCT (REISPRODUCTID, KORTING)
  VALUES (
    @reisproductid,
    @korting
  )

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
