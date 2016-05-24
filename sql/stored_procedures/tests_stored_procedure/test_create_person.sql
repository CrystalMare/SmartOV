BEGIN TRANSACTION TestGetSaldo

	-- Valide insert op de tabel persoon
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi@doei.com';

	-- Geen valide insert op de tabel persoon, persoon is te jong
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2015-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi@doei.com';

	-- Geen valide insert op de tabel persoon, email niet in juiste format
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi.doei.com';

ROLLBACK TRANSACTION TestGetSaldo

