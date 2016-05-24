USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_UPDATE_PERSON', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_UPDATE_PERSON
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_UPDATE_PERSON -- EXAMPLE NAME
    @persoonid UNIQUEIDENTIFIER,
    @naam VARCHAR(255),
    @postcode VARCHAR(10),
    @huisnummer VARCHAR(5),
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

--   IF (@naam LIKE '%[a-zA-z]%')
<<<<<<< HEAD
--   ELSE
=======
>>>>>>> 376a679f61e1cc3391e0e20fcc95590d2fffdf27
--     RAISERROR (56100, 16, 1);

  IF (@geboortedatum) > (DATEADD(yy, -5, GETDATE()))
    RAISERROR (56101, 16, 1);

<<<<<<< HEAD
  IF @emailadres NOT LIKE '%_@__%.__%'
    RAISERROR (56102, 16, 1);

  IF @telefoonnummer LIKE '%[a-zA-Z]%'
    RAISERROR (56103, 16, 1);
=======
  IF (@geboortedatum) > (DATEADD(yy, -5, GETDATE()))
    RAISERROR (56102, 16, 1);

  IF @emailadres NOT LIKE '%_@__%.__%'
    RAISERROR (56103, 16, 1);

  IF @telefoonnummer LIKE '%[a-zA-Z]%'
    RAISERROR (56104, 16, 1);

  IF (@postcode LIKE '%[^a-zA-Z0-9]%')
    RAISERROR (56105, 16, 1);

  IF (@huisnummer LIKE '%[^a-zA-Z0-9]%')
    RAISERROR (56106, 16, 1);

  IF LEN(@huisnummer) > 5
    RAISERROR (56107, 16, 1);

  IF ISDATE(@geboortedatum) = 0
    RAISERROR (56108, 16, 1);

  IF LEN(@telefoonnummer) < 8
    RAISERROR (56109, 16, 1);

  IF LEN(@telefoonnummer) > 15
    RAISERROR (561010, 16, 1);
>>>>>>> 376a679f61e1cc3391e0e20fcc95590d2fffdf27

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
<<<<<<< HEAD
  EXECUTE sp_addmessage 56101, 16, 'Je moet ouder zijn om 5 jaar om te registreren!';
  EXECUTE sp_addmessage 56102, 16, 'Geen valide email adress';
  EXECUTE sp_addmessage 56103, 16, 'Characters zijn niet toegestaan in het telefoonnumer!';
=======
  EXECUTE sp_addmessage 56101, 16, 'Persoon bestaat niet!';
  EXECUTE sp_addmessage 56102, 16, 'Persoon bestaat niet!';
  EXECUTE sp_addmessage 56103, 16, 'Geen valide email adress';
  EXECUTE sp_addmessage 56104, 16, 'Characters zijn niet toegestaan!';
  EXECUTE sp_addmessage 56105, 16, 'Geen speciale tekens toegestaan in de postcode';
  EXECUTE sp_addmessage 56106, 16, 'Geen speciale tekens toegestaan in het huisnummer';
  EXECUTE sp_addmessage 56107, 16, 'Huisnummer mag niet langer zijn dan 5 tekens';
  EXECUTE sp_addmessage 56108, 16, 'Geen valide datum!';
  EXECUTE sp_addmessage 56109, 16, 'Telefoonnummer mag niet korter dan 8 tekens zijn';
  EXECUTE sp_addmessage 561010, 16, 'Telefoonnummer mag niet langer dan 15 tekens zijn';
>>>>>>> 376a679f61e1cc3391e0e20fcc95590d2fffdf27
