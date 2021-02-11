CREATE DATABASE CBTVinyls
drop database cbtvinyls
USE CBTVinyls;
------------------------------------------------------------------------------------------------
CREATE TABLE tbl_continent(
	continentId INT PRIMARY KEY IDENTITY(1,1),
	continentName VARCHAR(20)
);

CREATE TABLE tbl_country(
	countryId INT PRIMARY KEY IDENTITY(1,1),
	continentId INT FOREIGN KEY REFERENCES tbl_continent(continentId),
	countryName VARCHAR(255)
);
CREATE TABLE tbl_production(
	productionId INT PRIMARY KEY IDENTITY(1,1),
	continentId INT FOREIGN KEY REFERENCES tbl_continent(continentId)
);
CREATE TABLE tbl_zone(
	zoneId INT PRIMARY KEY IDENTITY(1,1),
	countryId INT FOREIGN KEY REFERENCES tbl_country(countryId),
	zoneName VARCHAR(10),
	CONSTRAINT chk_zoneName CHECK(zoneName IN('North','East','South','West'))
);
CREATE TABLE tbl_warehouse(
	warehouseId INT PRIMARY KEY IDENTITY(1,1),
	countryId INT FOREIGN KEY REFERENCES tbl_country(countryId)
);
CREATE TABLE tbl_store(
	storeId INT PRIMARY KEY IDENTITY(1,1),
	zoneId INT FOREIGN KEY REFERENCES tbl_zone(zoneId)
);


CREATE TABLE tbl_albumInfo(
	albumInfoId INT PRIMARY KEY IDENTITY(1,1),
	title VARCHAR(20) NOT NULL,
	artist VARCHAR(40) NOT NULL,
	releaseDate DATETIME
); 
CREATE TABLE tbl_track(
	trackId INT PRIMARY KEY IDENTITY(1,1),
	albumInfoId INT FOREIGN KEY REFERENCES tbl_albumInfo(albumInfoId),
	trackName VARCHAR(50)
);

CREATE TABLE tbl_genre(
	genreId INT PRIMARY KEY IDENTITY(1,1),
	genreName VARCHAR(20),
);
CREATE TABLE tbl_albumInfo_genre(
	id INT PRIMARY KEY IDENTITY(1,1),
	albumInfoId INT FOREIGN KEY REFERENCES tbl_albumInfo(albumInfoId),
	genreId INT FOREIGN KEY REFERENCES tbl_genre(genreId)
);


CREATE TABLE tbl_item(
	itemId INT PRIMARY KEY IDENTITY(1,1),
	albumInfoId INT FOREIGN KEY REFERENCES tbl_albumInfo(albumInfoId),
	sellPrice DECIMAL(19,2) NOT NULL
);

CREATE TABLE tbl_productionInventory(
	id INT PRIMARY KEY IDENTITY(1,1),
	productionId INT FOREIGN KEY REFERENCES tbl_production(productionId),
	itemId INT FOREIGN KEY REFERENCES tbl_item(itemId),
	creation DATETIME DEFAULT GETDATE(),
	departure DATETIME
);

CREATE TABLE tbl_warehouseInventory(
	id INT PRIMARY KEY IDENTITY(1,1),
	warehouseId INT FOREIGN KEY REFERENCES tbl_warehouse(warehouseId),
	itemId INT FOREIGN KEY REFERENCES tbl_item(itemId),
	arrival DATETIME DEFAULT GETDATE(),
	departure DATETIME
);
CREATE TABLE tbl_storeInventory(
	id INT PRIMARY KEY IDENTITY(1,1),
	storeId INT FOREIGN KEY REFERENCES tbl_store(storeId),
	itemId INT FOREIGN KEY REFERENCES tbl_item(itemId),
	arrival DATETIME DEFAULT GETDATE(),
	departure DATETIME
);

CREATE TABLE tbl_logs(
	id INT PRIMARY KEY IDENTITY(1,1),
	message VARCHAR(50) NOT NULL,
	time DATETIME DEFAULT GETDATE()
);




