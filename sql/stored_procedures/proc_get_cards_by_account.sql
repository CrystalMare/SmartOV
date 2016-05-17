IF OBJECT_ID('PROC_GET_CARDS_BY_ACCOUNT', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_GET_CARDS_BY_ACCOUNT
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_CARDS_BY_ACCOUNT -- EXAMPLE NAME
    @AccountID UNIQUEIDENTIFIER -- EXAMPLE PARAMETERS
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS (SELECT 1 FROM dbo.ACCOUNT WHERE @AccountID = ACCOUNTID)
    RAISERROR(56050, 16, 1);

  SELECT *
  FROM dbo.KAART
  WHERE @AccountID = ACCOUNTID

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

EXECUTE sp_addmessage 56050, 16, 'Dit is een test!';