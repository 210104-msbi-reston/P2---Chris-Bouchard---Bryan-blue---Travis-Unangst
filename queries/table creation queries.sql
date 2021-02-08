CREATE DATABASE CBTVinyls
USE CBTVinyls;

CREATE TABLE tbl_corporate(
	corporateId INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20) DEFAULT 'CBTVinyls',
	founded DATETIME DEFAULT GETDATE()
	);

CREATE TABLE tbl_continent(
	continentName VARCHAR(20) PRIMARY KEY,
	corporateId INT FOREIGN KEY REFERENCES tbl_corporate(corporateId),
);

CREATE TABLE tbl_country(
	countryName VARCHAR(40) PRIMARY KEY,
	continentName VARCHAR(20) FOREIGN KEY REFERENCES tbl_continent(continentName),
);
CREATE TABLE tbl_production(
	productionId INT PRIMARY KEY IDENTITY(1,1),
	continentName VARCHAR(20) FOREIGN KEY REFERENCES tbl_continent(continentName)
);
CREATE TABLE tbl_zone(
	zoneId INT PRIMARY KEY IDENTITY(1,1),
	countryName VARCHAR(40) FOREIGN KEY REFERENCES tbl_country(countryName),
	zoneName VARCHAR(10),
	CONSTRAINT chk_zoneName CHECK(zoneName IN('North','East','South','West'))
);
CREATE TABLE tbl_warehouse(
	warehouseId INT PRIMARY KEY IDENTITY(1,1),
	countryName VARCHAR(40) FOREIGN KEY REFERENCES tbl_country(countryName)
);
CREATE TABLE tbl_store(
	storeId INT PRIMARY KEY IDENTITY(1,1),
	zoneId INT FOREIGN KEY REFERENCES tbl_zone(zoneId)
);


CREATE TABLE tbl_vinyl(
	vinylId INT PRIMARY KEY IDENTITY(1,1),
	title VARCHAR(20),
	releaseDate DATETIME,
	price DECIMAL(19,2) NOT NULL
);
CREATE TABLE tbl_track(
	trackId INT PRIMARY KEY IDENTITY(1,1),
	trackName VARCHAR(40),
	vinylId INT FOREIGN KEY REFERENCES tbl_vinyl(vinylId)
);
CREATE TABLE tbl_band(
	bandId INT PRIMARY KEY IDENTITY(1,1),
	bandName VARCHAR(40),
	vinylId INT FOREIGN KEY REFERENCES tbl_vinyl(vinylId)
);
CREATE TABLE tbl_genre(
	genreId INT PRIMARY KEY IDENTITY(1,1),
	genreName VARCHAR(20),
	vinylId INT FOREIGN KEY REFERENCES tbl_vinyl(vinylId)
);

CREATE TABLE tbl_studio(
	studioId INT PRIMARY KEY IDENTITY(1,1),
	studioName VARCHAR(20),
	label VARCHAR(20),
	producer VARCHAR(20),
	vinylId INT FOREIGN KEY REFERENCES tbl_vinyl(vinylId)
);
CREATE TABLE tbl_artist(
	artistId INT PRIMARY KEY IDENTITY(1,1),
	fName VARCHAR(20) NOT NULL,
	lName VARCHAR(20) NOT NULL
);
CREATE TABLE tbl_band_artist(
	id INT PRIMARY KEY IDENTITY(1,1),
	bandId INT FOREIGN KEY REFERENCES tbl_band(bandId),
	artistId INT FOREIGN KEY REFERENCES tbl_artist(artistId)
);

----------------------------------
CREATE TABLE tbl_warehouseInventory(
	id INT PRIMARY KEY IDENTITY(1,1),
	warehouseId INT FOREIGN KEY REFERENCES tbl_warehouse(warehouseId),
	vinylId INT FOREIGN KEY REFERENCES tbl_vinyl(vinylId),
	arrival DATETIME DEFAULT GETDATE(),
	departure DATETIME
);
CREATE TABLE tbl_storeInventory(
	id INT PRIMARY KEY IDENTITY(1,1),
	storeId INT FOREIGN KEY REFERENCES tbl_store(storeId),
	vinylId INT FOREIGN KEY REFERENCES tbl_vinyl(vinylId),
	arrival DATETIME DEFAULT GETDATE(),
	departure DATETIME
);

add arrival DATETIME DEFAULT GETDATE()
CREATE TABLE tbl_logs(
	id INT PRIMARY KEY IDENTITY(1,1),
	message VARCHAR(50) NOT NULL,
	time DATETIME DEFAULT GETDATE()
);