BEGIN TRANSACTION TestAddSaldo1

	-- Valide insert op de tabel account

UPDATE dbo.ACCOUNT
SET SALDO = 0
WHERE ACCOUNTID = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7'

EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = 10;

IF NOT EXISTS(SELECT 1
					FROM dbo.ACCOUNT
					WHERE ACCOUNTID = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7'
					AND SALDO = 10)
		RAISERROR (56000, 16, 1, 'TestAddSaldo error')

ROLLBACK TRANSACTION TestAddSaldo1

BEGIN TRANSACTION TestAddSaldo2

	-- Geen valide insert op de tabel account, de saldo mag niet boven de 200 komen
	EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = 201;

ROLLBACK TRANSACTION TestAddSaldo2

BEGIN TRANSACTION TestAddSaldo3

	-- Geen valide insert op de tabel account, het account bestaat niet
	DECLARE @newid UNIQUEIDENTIFIER = NEWID();
	EXECUTE dbo.PROC_ADD_SALDO @accountid = @newid, @saldo = 10;

ROLLBACK TRANSACTION TestAddSaldo3

BEGIN TRANSACTION TestAddSaldo4

-- Geen valide insert op de tabel account, de saldo mag niet onder de 0 komen
EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = -10;

ROLLBACK TRANSACTION TestAddSaldo4