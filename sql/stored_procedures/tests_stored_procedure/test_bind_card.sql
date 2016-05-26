-- PROC_BIND_CARD

-- IT WORKS AS IT SHOULD BE : GOOD

BEGIN TRANSACTION test_bind_card_1

  DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
  VALUES (@PERSOON_ID, 'Henk Petersen', '2322SD', '23', '01-08-1944', '0323845522', 'henk.petersen@gmail.com')

  INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
  VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')

  INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
  VALUES (@KAART_ID, NULL, '3235514563158658', 'test naam', DATEADD(day, 3, GETDATE()), GETDATE())

  EXECUTE dbo.PROC_BIND_CARD @kaart = @KAART_ID, @account = @ACCOUNT_ID

ROLLBACK TRANSACTION

-- KAART IS ALREADY BINDED TO ACCOUNT : ERROR

BEGIN TRANSACTION test_bind_card_2

DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
VALUES (@PERSOON_ID, 'Henk Petersen', '2322SD', '23', '01-08-1944', '0323845522', 'henk.petersen@gmail.com')

INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')

INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
VALUES (@KAART_ID, @ACCOUNT_ID, '3235514563158658', 'test naam', DATEADD(day, 3, GETDATE()), GETDATE())

EXECUTE dbo.PROC_BIND_CARD @kaart = @KAART_ID, @account = @ACCOUNT_ID

ROLLBACK TRANSACTION

-- THE ACCOUNT DOES NOT EXISTS : ERROR

BEGIN TRANSACTION test_bind_card_3

DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
VALUES (@PERSOON_ID, 'Henk Petersen', '2322SD', '23', '01-08-1944', '0323845522', 'henk.petersen@gmail.com')

INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
VALUES (@KAART_ID, NULL, '3235514563158658', 'test naam', DATEADD(day, 3, GETDATE()), GETDATE())

EXECUTE dbo.PROC_BIND_CARD @kaart = @KAART_ID, @account = @ACCOUNT_ID

ROLLBACK TRANSACTION

-- KAARTID DOES NOT EXISTS

BEGIN TRANSACTION test_bind_card_4

DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
VALUES (@PERSOON_ID, 'Henk Petersen', '2322SD', '23', '01-08-1944', '0323845522', 'henk.petersen@gmail.com')

INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')

EXECUTE dbo.PROC_BIND_CARD @kaart = @KAART_ID, @account = @ACCOUNT_ID

ROLLBACK TRANSACTION