-- PROC_BIND_CARD
USE smartOV
GO

-- DELETE IF PROC ALREADY EXISTS
IF OBJECT_ID('PROC_BIND_CARD', 'P') IS NOT NULL
  DROP PROCEDURE PROC_BIND_CARD
GO

-- ERROR MESSAGES
EXECUTE sp_addmessage 56060,16, 'Het opgegeven account bestaat niet.', @Replace=replace;
EXECUTE sp_addmessage 56061,16, 'De opgegeven kaart bestaat niet.', @Replace=replace;
EXECUTE sp_addmessage 56062,16, 'De opgegeven kaart is reeds gekoppeld aan een saldobeheerder.', @Replace=replace;
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_BIND_CARD
    @kaart UNIQUEIDENTIFIER,
    @account UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS(  SELECT 1
                  FROM dbo.ACCOUNT
                  WHERE ACCOUNTID = @account)
    RAISERROR (56060,16,1);

  IF NOT EXISTS(  SELECT 1
                  FROM dbo.KAART
                  WHERE KAARTID = @kaart)
      RAISERROR (56061,16,1);

  IF EXISTS(  SELECT 1
              FROM dbo.KAART
              WHERE KAARTID = @kaart
              AND ACCOUNTID IS NOT NULL)
      RAISERROR (56062,16,1);

  Update dbo.KAART
  SET dbo.KAART.ACCOUNTID = @account,
    KOPPELDATUM = GETDATE()
  WHERE KAARTID = @kaart

  IF @TranCounter = 0
    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    IF @TranCounter = 0
      ROLLBACK TRANSACTION;
    ELSE
      IF XACT_STATE() <> -1
        ROLLBACK TRANSACTION;

    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE();
    SELECT @ErrorSeverity = ERROR_SEVERITY();
    SELECT @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH
