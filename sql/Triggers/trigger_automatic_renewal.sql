use smartov

CREATE TRIGGER trigger_automatic_renewal
  ON dbo.ACCOUNT
  AFTER UPDATE
  AS

  DECLARE @account UNIQUEIDENTIFIER
  DECLARE @huidig_saldo INT
  DECLARE @opwaardeerbedrag INT

  SET @account = (  SELECT accountid
                    FROM INSERTED)
  IF EXISTS(  SELECT 1
              FROM dbo.ACCOUNT
              WHERE accountid = @account
              AND ACCOUNT.REKENINGNUMMER IS NOT NULL
              AND ACCOUNT.SALDO<0)
  BEGIN
    SET @huidig_saldo = (SELECT SALDO
                         FROM dbo.ACCOUNT
                         WHERE ACCOUNTID = @account)
    SET @opwaardeerbedrag = ( SELECT OPWAARDEERSALDO
                              FROM dbo.ACCOUNT
                              WHERE ACCOUNTID = @account)
    UPDATE dbo.ACCOUNT
      SET SALDO = @huidig_saldo+@opwaardeerbedrag
      WHERE ACCOUNTID = @account
  END

