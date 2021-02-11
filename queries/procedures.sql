

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