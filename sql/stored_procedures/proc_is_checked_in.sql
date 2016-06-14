USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_IS_CHECKED_IN', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_IS_CHECKED_IN
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_IS_CHECKED_IN -- EXAMPLE NAME
    @kaartid UNIQUEIDENTIFIER -- EXAMPLE PARAMETERS
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF EXISTS(SELECT 1
            FROM dbo.REIS
            WHERE KAARTID = @kaartid AND EINDPUNT IS NULL)
    SELECT CAST(1 AS BIT) AS checkedin;
  ELSE
    SELECT CAST(0 AS BIT) AS checkedin;


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
