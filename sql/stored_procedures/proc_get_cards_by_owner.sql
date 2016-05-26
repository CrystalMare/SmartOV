-- PROC_GET_CARDS_BY_OWNER
USE smartov
GO

-- DELETE IF PROC EXISTS
IF OBJECT_ID('PROC_GET_CARDS_BY_OWNER', 'P') IS NOT NULL
  DROP PROCEDURE PROC_GET_CARDS_BY_OWNER
GO

-- ERROR MESSAGES
EXECUTE sp_addmessage 56140, 16, 'Opgegeven persoon kan niet gevonden worden.', @replace = REPLACE;
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_CARDS_BY_OWNER
    @PersoonID UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS(  SELECT 1
                  FROM dbo.PERSOON
                  Where PERSOONID = @PersoonID)
      RAISERROR(56140,16,1);

  SELECT kaartID
  FROM dbo.PERSOONLIJKE_KAART
  Where PERSOONID = @PersoonID

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
