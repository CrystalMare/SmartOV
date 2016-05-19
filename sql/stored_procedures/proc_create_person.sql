USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_CREATE_PERSON', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_CREATE_PERSON
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_CREATE_PERSON -- EXAMPLE NAME
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

--   IF (@naam LIKE '%[^a-zA-Z0-9]%')
--     RAISERROR (56220, 16, 1);

  DECLARE @persoonid UNIQUEIDENTIFIER = NEWID();

  IF EXISTS (SELECT 1 FROM dbo.PERSOON WHERE PERSOONID = @persoonid)
      RAISERROR (56221, 16, 1);

  IF (@geboortedatum) > (DATEADD(yy, -5, GETDATE()))
      RAISERROR (56222, 16, 1);

  IF @emailadres NOT LIKE '%_@__%.__%'
      RAISERROR (56223, 16, 1);

  IF @telefoonnummer LIKE '%[a-zA-Z]%'
      RAISERROR (56224, 16, 1);

  INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
      OUTPUT INSERTED.PERSOONID
  VALUES (
    @persoonid,
    @naam,
    @postcode,
    @huisnummer,
    @geboortedatum,
    @telefoonnummer,
    @emailadres
  )

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

  EXECUTE sp_addmessage 56220, 16, 'Special characters zijn niet toegestaan!';
  EXECUTE sp_addmessage 56221, 16, 'Als dit gebeurt wordt Sven crazy!';
  EXECUTE sp_addmessage 56222, 16, 'Je moet ouder zijn om 5 jaar om te registreren!';
  EXECUTE sp_addmessage 56223, 16, 'Geen valide email adress';
  EXECUTE sp_addmessage 56224, 16, 'Characters zijn niet toegestaan in het telefoonnumer!', @replace = replace;
