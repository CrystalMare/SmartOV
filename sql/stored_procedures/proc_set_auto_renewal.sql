USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_SET_AUTO_RENEWAL', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_SET_AUTO_RENEWAL
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_SET_AUTO_RENEWAL -- EXAMPLE NAME
    @accountid      UNIQUEIDENTIFIER, -- EXAMPLE PARAMETERS
    @rekeningnummer VARCHAR(34),
    @hoeveelheid    MONEY
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

--   IF NOT EXISTS(SELECT 1
--                 FROM dbo.ACCOUNT
--                 WHERE ACCOUNTID = @accountid)
--     RAISERROR (56030, 16, 1)

--   IF (SELECT AUTOMATISCH_OPWAARDEREN
--       FROM dbo.ACCOUNT
--       WHERE ACCOUNTID = @accountid) = 1
--     RAISERROR (56031, 16, 1)

  IF @hoeveelheid > 0
    UPDATE dbo.ACCOUNT
    SET AUTOMATISCH_OPWAARDEREN = 1,
      OPWAARDEERSALDO           = @hoeveelheid,
      REKENINGNUMMER            = @rekeningnummer
    WHERE ACCOUNTID = @accountid

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
