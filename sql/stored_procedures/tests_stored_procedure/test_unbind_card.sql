-- PROC_UNBIND_CARD

-- THE KAARTID DOES WORK AS IT SHOULD BE : GOOD
BEGIN TRANSACTION test_unbind_card_1
  SET NOCOUNT ON

  DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
  DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
    VALUES (@PERSOON_ID, 'Henk Petersen', '4534DS', '23', '01-01-1945', '0123456789', 'h.petersen@gmail.com')
  INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
      VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')
  INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
    VALUES (@KAART_ID, @ACCOUNT_ID, '5234267891224512', 'Test naam', DATEADD(day, 3, GETDATE()), GETDATE())

  EXEC dbo.PROC_UNBIND_CARD @KaartID = @KAART_ID;
  GO

ROLLBACK TRANSACTION

-- THE KAARTID IS WRONG : ERROR

BEGIN TRANSACTION test_unbind_card_2
SET NOCOUNT ON

DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @ACCOUNT_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @WRONG_KAART_ID UNIQUEIDENTIFIER = NEWID();

INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
  VALUES (@PERSOON_ID, 'Henk Petersen', '4534DS', '23', '01-01-1945', '0123456789', 'h.petersen@gmail.com')

INSERT INTO dbo.ACCOUNT (ACCOUNTID, PERSOONID, SALDO, REKENINGNUMMER)
  VALUES (@ACCOUNT_ID, @PERSOON_ID, 0, 'NL91ABNA0417164300')

INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
  VALUES (@KAART_ID, @ACCOUNT_ID, '5234267891224512', 'Test naam', DATEADD(day, 3, GETDATE()), GETDATE())

EXEC dbo.PROC_UNBIND_CARD @KaartID = @WRONG_KAART_ID;

ROLLBACK TRANSACTION

-- THE ACCOUNTID OF CARD IS ALREADY NULL : ERROR

BEGIN TRANSACTION test_unbind_card_3
SET NOCOUNT ON

DECLARE @PERSOON_ID UNIQUEIDENTIFIER = NEWID();
DECLARE @KAART_ID UNIQUEIDENTIFIER = NEWID();

INSERT INTO dbo.PERSOON (PERSOONID, NAAM, POSTCODE, HUISNUMMER, GEBOORTEDATUM, TELEFOONNUMMER, E_MAILADRES)
VALUES (@PERSOON_ID, 'Henk Petersen', '4534DS', '23', '01-01-1945', '0123456789', 'h.petersen@gmail.com')

INSERT INTO dbo.KAART (KAARTID, ACCOUNTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
VALUES (@KAART_ID, NULL, '5234267891224512', 'Test naam', DATEADD(day, 3, GETDATE()), GETDATE())

EXEC dbo.PROC_UNBIND_CARD @KaartID = @KAART_ID;

ROLLBACK TRANSACTION