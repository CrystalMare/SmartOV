USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_GET_ALL_AVAILABLE_PRODUCTS', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_GET_ALL_AVAILABLE_PRODUCTS
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_ALL_AVAILABLE_PRODUCTS -- EXAMPLE NAME
    @kaartid UNIQUEIDENTIFIER -- EXAMPLE PARAMETERS
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF NOT EXISTS(SELECT 1 FROM dbo.KAART WHERE KAARTID = @kaartid)
      RAISERROR (56310, 16, 1);

  SELECT
    dbo.REISPRODUCT.REISPRODUCTID,
    NAAM,
    KORTING
  FROM dbo.REISPRODUCT
    JOIN (
           SELECT REISPRODUCTID
           FROM dbo.REISPRODUCT
           EXCEPT
           SELECT PRODUCT_OP_KAART.REISPRODUCTID
           FROM dbo.PRODUCT_OP_KAART
             JOIN dbo.REISPRODUCT ON dbo.PRODUCT_OP_KAART.REISPRODUCTID = dbo.REISPRODUCT.REISPRODUCTID
           WHERE KAARTID = @kaartid
                 AND
                 DATEADD(DD, GELDIGHEID, KOPPELDATUM) > GETDATE()
         ) AS AVAILABLE ON dbo.REISPRODUCT.REISPRODUCTID = AVAILABLE.REISPRODUCTID
    LEFT JOIN dbo.KORTINGSREISPRODUCT ON dbo.REISPRODUCT.REISPRODUCTID = dbo.KORTINGSREISPRODUCT.REISPRODUCTID

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
