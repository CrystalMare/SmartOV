-- PROC_GET_CARDS_BY_OWNER

-- IT WORKS AS IT SHOULD BE : GOOD

BEGIN TRANSACTION test_get_cards_by_owner_1

  DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.Persoon (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
    VALUES (@PERSOON_ID, 'Henk Petersen', '2323SD', '23', '01-08-1944', '0123834643', 'henk.petersen@gmail.com')

  INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
    VALUES (@KAART_ID, NULL, '5459025586208613', 'test naam', DATEADD(DAY, 3, GETDATE()), GETDATE())

  INSERT INTO dbo.PERSOONLIJKE_KAART (KAARTID, PERSOONID)
    VALUES (@KAART_ID, @PERSOON_ID)

  EXECUTE dbo.PROC_GET_CARDS_BY_OWNER @PersoonID = @PERSOON_ID

ROLLBACK TRANSACTION

-- WANTED PERSOON IS NOT FOUND : ERROR

BEGIN TRANSACTION test_get_cards_by_owner_2

  DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @PERSOON_ID_2 UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.Persoon (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
    VALUES (@PERSOON_ID, 'Henk Petersen', '2323SD', '23', '01-08-1944', '0123834643', 'henk.petersen@gmail.com')

  INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
    VALUES (@KAART_ID, NULL, '5459025586208613', 'test naam', DATEADD(DAY, 3, GETDATE()), GETDATE())

  INSERT INTO dbo.PERSOONLIJKE_KAART (KAARTID, PERSOONID)
    VALUES (@KAART_ID, @PERSOON_ID)

  EXECUTE dbo.PROC_GET_CARDS_BY_OWNER @PersoonID = @PERSOON_ID_2

ROLLBACK TRANSACTION