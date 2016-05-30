USE smartov -- EXAMPLE DATABASENAME
GO

--EXECUTE sp_addmessage 56080, 16, 'Kaart is niet gevonden!';

IF OBJECT_ID('PROC_GET_PRODUCTS', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_GET_PRODUCTS
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_PRODUCTS -- EXAMPLE NAME
    @kaartid UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS(SELECT 1 FROM dbo.KAART WHERE KAARTID = @kaartid)
      RAISERROR (56080, 16, 1);

  SELECT r.REISPRODUCTID, NAAM, (DATEADD(dd, r.GELDIGHEID, pk.KOPPELDATUM)) AS Vervaldatum, KORTING
  FROM dbo.REISPRODUCT r INNER JOIN dbo.PRODUCT_OP_KAART pk ON r.REISPRODUCTID = pk.REISPRODUCTID INNER JOIN dbo.KORTINGSREISPRODUCT k ON r.REISPRODUCTID = k.REISPRODUCTID
  WHERE KAARTID = @kaartid

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
