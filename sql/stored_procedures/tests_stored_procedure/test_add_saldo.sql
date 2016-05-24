BEGIN TRANSACTION TestAddSaldo

	-- Valide insert op de tabel account
	EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = 10;

	-- Geen valide insert op de tabel account, de saldo mag niet boven de 200 komen
	EXECUTE dbo.PROC_ADD_SALDO @accountid = 'E6D77591-D3D9-4B2A-A855-8961A71DFEE7', @saldo = 201;

	-- Geen valide insert op de tabel account, het account bestaat niet
	EXECUTE dbo.PROC_ADD_SALDO @accountid = NEWID(), @saldo = 10;

ROLLBACK TRANSACTION TestAddSaldo