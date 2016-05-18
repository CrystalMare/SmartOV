USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_UPDATE_PERSON', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_UPDATE_PERSON
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_UPDATE_PERSON -- EXAMPLE NAME
    @naam VARCHAR(255),
    @postcode VARCHAR(10),
    @huisnummer VARCHAR(5),
    @geboortedatum DATETIME,
    @telefoonnummer VARCHAR(15),
    @emailadres VARCHAR(255)
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF (@naam LIKE '%[a-zA-z]%')
  ELSE
    RAISERROR (56100, 16, 1);

  IF NOT EXISTS(SELECT 1 FROM dbo.PERSOON WHERE PERSOONID = @persoonid)
    RAISERROR (56101, 16, 1);
--   IF (@postcode LIKE '%[^a-zA-Z]%')
--     RAISERROR (56100, 16, 1);



  UPDATE dbo.PERSOON
  SET
    NAAM = @naam,
    POSTCODE = @postcode,
    HUISNUMMER = @huisnummer,
    GEBOORTEDATUM = @geboortedatum,
    TELEFOONNUMMER = @telefoonnummer,
    E_MAILADRES = @emailadres
  WHERE PERSOONID = @persoonid

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

  EXECUTE sp_addmessage 56100, 16, 'Special characters zijn niet toegestaan!';
  EXECUTE sp_addmessage 56101, 16, 'Persoon bestaat niet!';
