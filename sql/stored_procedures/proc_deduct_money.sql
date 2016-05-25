USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_DEDUCT_MONEY', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_DEDUCT_MONEY
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_DEDUCT_MONEY -- EXAMPLE NAME
    @accountid UNIQUEIDENTIFIER,
    @amount INT
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF @saldo + (SELECT SALDO FROM dbo.ACCOUNT WHERE ACCOUNTID = @accountid) < 0 --Wat moeten we doen hier?
    RAISERROR (56160, 16, 1);

  IF NOT EXISTS(SELECT 1 FROM dbo.ACCOUNT WHERE ACCOUNTID = @accountid)
    RAISERROR (56161, 16, 1);

  UPDATE dbo.ACCOUNT
  SET
    SALDO = SALDO - @saldo
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
