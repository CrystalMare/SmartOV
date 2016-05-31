IF OBJECT_ID('PROC_GET_CARDS_BY_CARDNUMBER', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_GET_CARDS_BY_CARDNUMBER
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_GET_CARDS_BY_CARDNUMBER -- EXAMPLE NAME
    @cardnumber int, -- EXAMPLE PARAMETERS
    @detailed bit = 0
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF @Detailed = 1
    SELECT dbo.KAART.KAARTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM, PERSOONID
    FROM dbo.KAART
      LEFT JOIN dbo.PERSOONLIJKE_KAART ON dbo.KAART.KAARTID = dbo.PERSOONLIJKE_KAART.KAARTID
    WHERE @cardnumber = KAARTNUMMER;
  ELSE
    SELECT KAARTID
    FROM dbo.KAART
    WHERE @cardnumber = KAARTNUMMER;

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