USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_ADD_SALDO', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_ADD_SALDO
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_ADD_SALDO -- EXAMPLE NAME
    @accountid UNIQUEIDENTIFIER, -- EXAMPLE PARAMETERS
    @saldo INT
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF @saldo + (SELECT SALDO FROM dbo.ACCOUNT WHERE ACCOUNTID = @accountid) > 200
      RAISERROR (56020, 16, 1)

  UPDATE dbo.ACCOUNT
  SET
    SALDO = @saldo + SALDO
  OUTPUT INSERTED.SALDO
  WHERE ACCOUNTID  = @accountid

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

  EXECUTE sp_addmessage 56020, 16, 'Het saldo mag niet hoger 200 euro zijn!';
