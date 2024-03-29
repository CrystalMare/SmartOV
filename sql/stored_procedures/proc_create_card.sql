USE smartov -- EXAMPLE DATABASENAME
GO

IF OBJECT_ID('PROC_CREATE_CARD', 'P') IS NOT NULL -- EXAMPLE PROCEDURE NAME
  DROP PROCEDURE PROC_CREATE_CARD
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE PROC_CREATE_CARD -- EXAMPLE NAME
    @kaartnummer CHAR(16),
    @kaartnaam   VARCHAR(255),
    @vervaldatum DATETIME,
    @persoon UNIQUEIDENTIFIER,
    @persoonid UNIQUEIDENTIFIER
AS
  DECLARE @TranCounter INT;
  SET @TranCounter = @@TRANCOUNT;
  IF @TranCounter > 0
    SAVE TRANSACTION ProcedureSave;
  ELSE
    BEGIN TRANSACTION;
  BEGIN TRY

  IF LEN(@kaartnaam) > 26
    RAISERROR (56210, 16, 1);

  IF @vervaldatum < GETDATE()
    RAISERROR (56211, 16, 1);

  DECLARE @kaart UNIQUEIDENTIFIER;
  SET @kaart = NEWID();
  DECLARE @kaartid UNIQUEIDENTIFIER = NEWID()

  INSERT INTO dbo.KAART (KAARTID, KAARTNUMMER, KAARTNAAM, VERVALDATUM, KOPPELDATUM)
      OUTPUT INSERTED.KAARTID
  VALUES (
    @kaart,
    @kaartid,
    @kaartnummer,
    @kaartnaam,
    DATEADD(yy, 5, GETDATE()),
    @vervaldatum,
    GETDATE()
  )

  INSERT INTO dbo.PERSOONLIJKE_KAART (KAARTID, PERSOONID)
  VALUES (
    @kaart,
    @persoon
  );

  SELECT @kaart;
  INSERT INTO dbo.PERSOONLIJKE_KAART(KAARTID, PERSOONID)
      OUTPUT INSERTED.KAARTID
  VALUES (
    @kaartid,
    @persoonid
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

  EXECUTE sp_addmessage 56210, 16, 'De kaartnaam mag niet langer dan 26 tekens zijn!';
  EXECUTE sp_addmessage 56211, 16, 'De vervaldatum mag niet voor de huidige datum zijn!';