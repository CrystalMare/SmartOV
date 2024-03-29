-- PROC_GET_SALDO

IF OBJECT_ID('PROC_GET_SALDO', 'P') IS NOT NULL
  DROP PROCEDURE PROC_GET_SALDO
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_SALDO
    @AccountID UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  DECLARE @Saldo MONEY;

  SELECT @Saldo = SALDO
  FROM dbo.ACCOUNT
  WHERE ACCOUNTID = @AccountID;

  IF @Saldo IS NULL
    RAISERROR(56001, 16, 1);

  IF NOT EXISTS(SELECT 1 FROM dbo.ACCOUNT WHERE ACCOUNTID = @AccountID)
      RAISERROR (56002, 16, 1);

  SELECT @Saldo;

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

  EXECUTE sp_addmessage 56001, 16, 'Account bestaat niet';
  EXECUTE sp_addmessage 56002, 16, 'Account bestaat niet';

