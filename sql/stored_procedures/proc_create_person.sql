USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_CREATE_PERSON', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_CREATE_PERSON
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_CREATE_PERSON -- EXAMPLE NAME
    @naam VARCHAR(255),
    @postcode VARCHAR(10),
    @huisnummer VARCHAR(255),
    @geboortedatum DATETIME,
    @telefoonnummer VARCHAR(255),
    @emailadres VARCHAR(255)
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  DECLARE @persoonid UNIQUEIDENTIFIER = NEWID();

  IF EXISTS (SELECT 1 FROM dbo.PERSOON WHERE PERSOONID = @persoonid)
    RAISERROR (56221, 16, 1);

  IF (@geboortedatum) > (DATEADD(yy, -5, GETDATE()))
    RAISERROR (56222, 16, 1);

  IF @emailadres NOT LIKE '%_@__%.__%'
      RAISERROR (56223, 16, 1);

  IF (@telefoonnummer LIKE '%[a-zA-Z]%')
      RAISERROR (56224, 16, 1);

  IF (@postcode LIKE '%[^a-zA-Z0-9]%')
      RAISERROR (56225, 16, 1);

  IF (@huisnummer LIKE '%[^a-zA-Z0-9]%')
      RAISERROR (56226, 16, 1);

  IF LEN(@huisnummer) > 5
    RAISERROR (56227, 16, 1);

  IF ISDATE(@geboortedatum) = 0
    RAISERROR (56228, 16, 1);

  IF LEN(@telefoonnummer) < 8
      RAISERROR (56229, 16, 1);

  IF LEN(@telefoonnummer) > 15
    RAISERROR (562210, 16, 1);

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

--   EXECUTE sp_addmessage 56220, 16, 'Special characters zijn niet toegestaan!';
--   EXECUTE sp_addmessage 56221, 16, 'Als dit gebeurt wordt Sven crazy!';
--   EXECUTE sp_addmessage 56222, 16, 'Je moet ouder zijn om 5 jaar om te registreren!';
--   EXECUTE sp_addmessage 56223, 16, 'Geen valide email adress';
--   EXECUTE sp_addmessage 56224, 16, 'Characters zijn niet toegestaan in het telefoonnumer!', @replace = REPLACE;
--   EXECUTE sp_addmessage 56224, 16, 'Characters zijn niet toegestaan!';
--   EXECUTE sp_addmessage 56225, 16, 'Geen speciale tekens toegestaan in de postcode', @replace =  REPLACE;
--   EXECUTE sp_addmessage 56226, 16, 'Geen speciale tekens toegestaan in het huisnummer', @replace =  REPLACE;
--   EXECUTE sp_addmessage 56227, 16, 'Huisnummer mag niet langer zijn dan 5 tekens';
--   EXECUTE sp_addmessage 56228, 16, 'Geen valide datum!';
--   EXECUTE sp_addmessage 56229, 16, 'Telefoonnummer mag niet korter dan 8 tekens zijn';
--   EXECUTE sp_addmessage 562210, 16, 'Telefoonnummer mag niet langer dan 15 tekens zijn';
