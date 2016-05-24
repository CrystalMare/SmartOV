BEGIN TRANSACTION TestGetSaldo

	-- Valide select op de tabel account
	EXECUTE  dbo.PROC_GET_SALDO @AccountID = '3FCECBDE-DC90-424F-BC60-2197C0BDF6EA';

	-- Geen valide select op de tabel account, account bestaat niet
	EXECUTE  dbo.PROC_GET_SALDO @AccountID = NEWID();

ROLLBACK TRANSACTION TestGetSaldo

