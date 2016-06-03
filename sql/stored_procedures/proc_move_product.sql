USE smartov
GO

-- -- ERROR MESSAGES
-- EXECUTE sp_addmessage 56091, 16, 'Kaart bestaat niet.';
-- EXECUTE sp_addmessage 56092, 16, 'Reisproduct bestaat niet.';
-- EXECUTE sp_addmessage 56093, 16, 'Kaart is niet gekoppeld aan uw account';

-- DELETE IF PROD ALREADY EXISTS
IF OBJECT_ID('PROC_MOVE_PRODUCT', 'P') IS NOT NULL
  DROP PROCEDURE PROC_MOVE_PRODUCT
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_MOVE_PRODUCT
  @productOpKaartId UNIQUEIDENTIFIER,
  @kaartid UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS (SELECT 1 FROM dbo.KAART WHERE KAARTID = @kaartid)
      RAISERROR(56091, 16, 1)

--   IF NOT EXISTS (SELECT 1 FROM dbo.REISPRODUCT WHERE REISPRODUCTID = @productOpKaartId)
--       RAISERROR(56092, 16, 1)

  IF (SELECT ACCOUNTID FROM dbo.KAART WHERE KAARTID = @kaartid) IS NULL
      RAISERROR (56093, 16, 1)

  UPDATE dbo.PRODUCT_OP_KAART
  SET KAARTID = @kaartid
  WHERE PRODUCTOPKAARTID = @productOpKaartId

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