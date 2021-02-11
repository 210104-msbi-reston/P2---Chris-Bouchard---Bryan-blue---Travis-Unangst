/*
CREATE PROCEDURE proc_main @table VARCHAR(20),
@action VARCHAR(20)
AS
BEGIN
	IF @table = 'corporate'
		BEGIN
			EXECUTE proc_corporate @action;
		END
	ELSE IF @table = 'continent'
		BEGIN
			EXECUTE proc_continent @action;
		END
	ELSE IF @table = 'country'
		BEGIN
			EXECUTE proc_country @action;
		END
	ELSE IF @table = 'zone'
		BEGIN
			EXECUTE proc_zone @action;
		END
	ELSE IF @table = 'production'
		BEGIN
			EXECUTE proc_production @action;
		END
	ELSE IF @table = 'warehouse'
		BEGIN
			EXECUTE proc_warehouse @action;
		END
	ELSE IF @table = 'store'
		BEGIN
			EXECUTE proc_store @action;
		END
	ELSE IF @table = 'warehouseInventory'
		BEGIN
			EXECUTE proc_warehouseInventory @action;
		END
	ELSE IF @table = 'storeInventory'
		BEGIN
			EXECUTE proc_storeInventory @action;
		END
	ELSE IF @table = 'vinyl'
		BEGIN
			EXECUTE proc_vinyl @action;
		END
	ELSE IF @table = 'studio'
		BEGIN
			EXECUTE proc_studio @action;
		END
	ELSE IF @table = 'genre'
		BEGIN
			EXECUTE proc_genre @action;
		END
	ELSE IF @table = 'track'
		BEGIN
			EXECUTE proc_track @action;
		END
	ELSE IF @table = 'band'
		BEGIN
			EXECUTE proc_band @action;
		END
END
*/

CREATE PROCEDURE proc_corporate @action VARCHAR(20), 
@name VARCHAR(20) = NULL, 
@newName VARCHAR(20) = NULL,
@id INT = 0
AS
BEGIN
	PRINT @name;
	IF @newName IS NULL
		BEGIN
			PRINT 'null'
		END
	print @newName;
	print @id;

	IF @action = 'add'
		BEGIN
			INSERT INTO tbl_corporate(name) VALUES(@name);
		END
	ELSE IF @action = 'update'
		BEGIN
			UPDATE tbl_corporate
			SET name = @newName
			WHERE corporateId = @id
		END
END
--EXECUTE proc_corporate @action = 'update', @newName = 'thomas'

CREATE PROCEDURE proc_continent @action VARCHAR(20),
@continentName VARCHAR(20) = NULL, 
@newContinentName VARCHAR(20) = NULL,
@corporateId INT = 0
AS
BEGIN
	IF @corporateId = 0
		BEGIN
			SET @corporateId = (SELECT TOP(1) corporateId FROM tbl_corporate WHERE name = 'CBT Vinyls');
		END

	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_continent(continentName, corporateId) 
			VALUES(@continentName, @corporateId);
		END
	ELSE IF @action = 'update' ---------------------------------------------------------------
		BEGIN
			UPDATE tbl_continent
			SET continentName = @newContinentName
			WHERE continentName = @continentName
		END
END
--                          
CREATE PROCEDURE proc_country @action VARCHAR(20), 
@countryName VARCHAR(40) = NULL, 
@newCountryName VARCHAR(40) = NULL,
@continentName VARCHAR(20) = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_country(countryName, continentName) 
			VALUES(@countryName, @continentName);
		END
	ELSE IF @action = 'update' ---------------------------------------------------------------
		BEGIN
			UPDATE tbl_country
			SET countryName = @newCountryName
			WHERE countryName = @countryName;
		END
END

CREATE PROCEDURE proc_zone @action VARCHAR(20),
@countryName VARCHAR(40) = NULL,
@zoneName VARCHAR(20) = NULL,
@zoneId INT = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_zone(countryName, zoneName) 
			VALUES(@countryName, @zoneName);
		END
	ELSE IF @action = 'update' ---------------------------------------------------------------
		BEGIN
			UPDATE tbl_zone
			SET zoneName = @zoneName
			WHERE zoneId = @zoneId;
		END
END

CREATE PROCEDURE proc_production @action VARCHAR(20),
@continentName VARCHAR(20) = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_production(continentName)
			VALUES(@continentName);
		END
	ELSE IF @action = 'update' ---------------------------------------------------------------
		BEGIN
		END
END
CREATE PROCEDURE proc_warehouse @action VARCHAR(20),
@countryName VARCHAR(40) = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_warehouse(countryName) VALUES(@countryName);
		END
	ELSE IF @action = 'update' ---------------------------------------------------------------
		BEGIN
		END
END

CREATE PROCEDURE proc_store @action VARCHAR(20),
@zoneId INT = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN	
			INSERT INTO tbl_store(zoneId) VALUES(@zoneId);
		END
	ELSE IF @action = 'update' ---------------------------------------------------------------
		BEGIN
		END
END
CREATE PROCEDURE proc_warehouseInventory @action VARCHAR(20),
@warehouseId INT = NULL,
@vinylId INT = NULL,
@id INT = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_warehouseInventory(warehouseId,vinylId)
			VALUES(@warehouseId, @vinylId);
		END
	ELSE IF @action = 'update departure' ---------------------------------------------------------------
		BEGIN
			UPDATE tbl_warehouseInventory
			SET departure = GETDATE()
			WHERE id = @id
		END
END

CREATE PROCEDURE proc_storeInventory @action VARCHAR(20),
@storeId INT = NULL,
@vinylId INT = NULL,
@id INT = NULL
AS
BEGIN
	IF @action = 'add' ---------------------------------------------------------------
		BEGIN
			INSERT INTO tbl_storeInventory(storeId,vinylId)
			VALUES(@storeId, @vinylId);
		END
	ELSE IF @action = 'update departure' ---------------------------------------------------------------
		BEGIN
			UPDATE tbl_storeInventory
			SET departure = GETDATE()
			WHERE id = @id;
		END
END

CREATE PROCEDURE proc_vinyl @action VARCHAR(20),
@title VARCHAR(40) = NULL,
@releaseDate DATETIME = NULL,
@genreName VARCHAR(20) = NULL,
@bandName VARCHAR(20) = NULL
AS
BEGIN
	IF @action = 'add'
		BEGIN
			--insert into vinyl, get index @index = SCOPE_IDENTITY();
			INSERT INTO tbl_vinyl(title,releaseDate) VALUES(@title,@releaseDate);
			DECLARE @insertedVinylId INT;
			SET @insertedVinylId = SCOPE_IDENTITY();
			--insert into genre
			INSERT INTO tbl_genre(genreName, vinylId) VALUES(@genreName, @insertedVinylId);
			--insert into band
			INSERT INTO tbl_band(bandName, vinylId) VALUES(@bandName, @insertedVinylId);
			--don't know how to insert tracks nicely
			--dont know scraped studio info yet
		END
	ELSE IF @action = 'update'
		BEGIN
		END
END

/*
CREATE PROCEDURE proc_studio @action VARCHAR(20)
AS
BEGIN
	IF @action = 'add'
		BEGIN
		END
	ELSE IF @action = 'update'
		BEGIN
		END
END

CREATE PROCEDURE proc_genre @action VARCHAR(20)
AS
BEGIN
	IF @action = 'add'
		BEGIN
		END
	ELSE IF @action = 'update'
		BEGIN
		END
END
CREATE PROCEDURE proc_track @action VARCHAR(20)
AS
BEGIN
	IF @action = 'add'
		BEGIN
		END
	ELSE IF @action = 'update'
		BEGIN
		END
END
CREATE PROCEDURE proc_band @action VARCHAR(20)
AS
BEGIN
	IF @action = 'add'
		BEGIN
		END
	ELSE IF @action = 'update'
		BEGIN
		END
END

*/