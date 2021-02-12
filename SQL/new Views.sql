CREATE VIEW view_productionToWarehouse
AS
SELECT 
	p.productionId AS [Production Id],
	co.continentName AS [Continent],
	cu.countryName AS [Country],
	w.warehouseId AS [Warehouse Id]
FROM tbl_production AS p
	JOIN tbl_continent AS co
ON p.continentId = co.continentId
	JOIN tbl_country AS cu
ON cu.continentId = co.continentId
	JOIN tbl_warehouse AS w
ON w.countryId = cu.countryId;

CREATE VIEW view_warehouseToStore
AS
SELECT
	w.warehouseId AS [Warehouse Id],
	co.countryName AS [Country],
	z.zoneName AS [Zone],
	s.storeId AS [Store Id]
FROM tbl_warehouse AS w
	JOIN tbl_country AS co
ON co.countryId = w.countryId
	JOIN tbl_zone AS z
ON z.countryId = co.countryId
	JOIN tbl_store AS s
ON s.zoneId = z.zoneId;

CREATE VIEW view_productionInventoryToAlbumInfo
AS
SELECT
	p.id AS [Production Id],
	p.creation AS [Item Creation Date],
	p.departure AS [Production Departure Date],
	i.itemId AS [Item Id],
	i.sellPrice AS [Price Sold],
	a.title AS [Title],
	a.artist AS [Artist],
	a.releaseDate AS [Release Date]
FROM tbl_productionInventory AS p
	JOIN tbl_item AS i
ON i.itemId = p.itemId
	JOIN tbl_albumInfo AS a
ON a.albumInfoId = i.albumInfoId;

CREATE VIEW view_warehouseInventoryToAlbumInfo
AS
SELECT
	wi.id AS [Warehouse Id],
	wi.arrival AS [Warehouse Arrival Date],
	wi.departure AS [Warehouse Departure Date],
	i.itemId AS [Item Id],
	i.sellPrice AS [Price Sold],
	a.title AS [Title],
	a.artist AS [Artist],
	a.releaseDate AS [Release Date]
FROM tbl_warehouseInventory AS wi
	JOIN tbl_item AS i
ON i.itemId = wi.itemId
	JOIN tbl_albumInfo AS a
ON a.albumInfoId = i.albumInfoId;

CREATE VIEW view_storeInventoryToAlbumInfo
AS
SELECT
	si.id AS [Store Id],
	si.arrival AS [Store Arrival Date],
	si.departure AS [Store Departure Date],
	i.itemId AS [Item Id],
	i.sellPrice AS [Price Sold],
	a.title AS [Title],
	a.artist AS [Artist],
	a.releaseDate AS [Release Date]
FROM tbl_storeInventory AS si
	JOIN tbl_item AS i
ON i.itemId = si.itemId
	JOIN tbl_albumInfo AS a
ON a.albumInfoId = i.albumInfoId;








-- how to get both these views to join, left join where/having? testing data will help

CREATE VIEW view_itemToAlbumInfo
AS
SELECT *
FROM [view_albumInfoTracks]


CREATE VIEW view_trackCount
AS
SELECT 
	COUNT(*) AS [Track Count]
FROM tbl_albumInfo AS a
	JOIN tbl_track AS t
ON a.albumInfoId = t.albumInfoId
GROUP BY a.albumInfoId;

CREATE VIEW view_albumInfoTracks
AS
SELECT
	a.albumInfoId AS [Album Info Id],
	a.title AS [Title],
	a.artist AS [Artist],
	t.trackName AS [Track],
	a.releaseDate AS [Release Date]
FROM tbl_albumInfo AS a
	JOIN tbl_track AS t
ON a.albumInfoId = t.albumInfoId
-- test as       select * from view_albumInfoTracks

CREATE VIEW view_albumInfoGenres
AS
SELECT
DISTINCT
	a.albumInfoId AS [Album Info Id],
	a.title AS [Title],
	a.artist AS [Artist],
	g.genreName AS [Genre],
	a.releaseDate AS [Release Date]
FROM tbl_albumInfo AS a
	JOIN tbl_albumInfo_genre AS a_g
ON a_g.albumInfoId = a.albumInfoId
	JOIN tbl_genre AS g
ON a_g.genreId = g.genreId
-- test as       select * from view_albumInfoGenres