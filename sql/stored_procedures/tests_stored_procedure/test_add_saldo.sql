BEGIN TRANSACTION TestAddSaldo

	-- Valide insert op de tabel account
SELECT SALDO
FROM dbo.ACCOUNT
WHERE

EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = 10;


ROLLBACK TRANSACTION TestAddSaldo

	-- Geen valide insert op de tabel account, de saldo mag niet boven de 200 komen
	EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = 201;

ROLLBACK TRANSACTION TestAddSaldo

BEGIN TRANSACTION TestAddSaldo

	-- Geen valide insert op de tabel account, het account bestaat niet
	DECLARE @newid UNIQUEIDENTIFIER = NEWID();
	EXECUTE dbo.PROC_ADD_SALDO @accountid = @newid, @saldo = 10;

ROLLBACK TRANSACTION TestAddSaldo