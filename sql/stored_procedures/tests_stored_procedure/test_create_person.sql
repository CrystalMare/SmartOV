BEGIN TRANSACTION TestCreatePerson1

	-- Valide insert op de tabel persoon
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi@doei.com';

	IF NOT EXISTS(SELECT 1 FROM dbo.PERSOON WHERE NAAM = 'Test Persoon')
			RAISERROR (56000, 16, 1);

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson2

	-- Geen valide insert op de tabel persoon, persoon is te jong
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2015-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson3

	-- Geen valide insert op de tabel persoon, email niet in juiste format
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi.doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson4

	-- Geen valide insert op de tabel persoon, telefoonnummer mag geen letters bevatten
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '13678higrse65654', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson5

	-- Geen valide insert op de tabel persoon, telefoonnummer mag niet langer dan 15 tekens zijn
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865897643654365654', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson6

	-- Geen valide insert op de tabel persoon, telefoonnummer mag niet korter dan 8 tekens zijn
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '154', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson7

	-- Geen valide insert op de tabel persoon, postcode mag geen speciale characters bevatten
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '731^&*4JC', @huisnummer = '24', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson8

	-- Geen valide insert op de tabel persoon, huisnummer mag geen special characters bevatten
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '2$#4', @geboortedatum = '2001-11-11', @telefoonnummer = '13678higrse65654', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION

BEGIN TRANSACTION TestCreatePerson9

	-- Geen valide insert op de tabel persoon, huisnummer mag langer dan 5 tekens zijn
	EXECUTE dbo.PROC_CREATE_PERSON @naam = 'Test Persoon', @postcode = '7314JC', @huisnummer = '24abcd', @geboortedatum = '2001-11-11', @telefoonnummer = '1367865654', @emailadres = 'hoi@doei.com';

ROLLBACK TRANSACTION