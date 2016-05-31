-- PROC_GET_CARDS_BY_ACCOUNT

-- It works as it should be : Good

BEGIN TRANSACTION test_get_cards_by_account_1

  DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
  VALUES (@PERSOON_ID, 'Henk Petersen', '4534DS', '23', '01-01-1945', '0123456789', 'h.petersen@gmail.com')

  INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
  VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')

  INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
  VALUES (@KAART_ID, @ACCOUNT_ID, '5234267891224512', 'Test naam', DATEADD(day, 3, GETDATE()), GETDATE())

  EXECUTE dbo.PROC_GET_CARDS_BY_ACCOUNT @AccountID = @ACCOUNT_ID

ROLLBACK TRANSACTION

-- Account does not exists : Error

BEGIN TRANSACTION test_get_cards_by_account_2

DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @ACCOUNT_ID_2 UNIQUEIDENTIFIER = NEWID();

INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
VALUES (@PERSOON_ID, 'Henk Petersen', '4534DS', '23', '01-01-1945', '0123456789', 'h.petersen@gmail.com')

INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')

INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
VALUES (@KAART_ID, @ACCOUNT_ID, '5234267891224512', 'Test naam', DATEADD(day, 3, GETDATE()), GETDATE())

EXECUTE dbo.PROC_GET_CARDS_BY_ACCOUNT @AccountID = @ACCOUNT_ID_2

ROLLBACK TRANSACTION