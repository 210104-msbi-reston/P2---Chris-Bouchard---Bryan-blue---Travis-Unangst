CREATE VIEW view_productionToWarehouse
AS
SELECT 
	p.productionId AS [Production Id],
	co.continentName AS [Continent],
	cu.countryName AS [Country],
	w.warehouseId AS [Warehouse Id]
FROM tbl_production AS p
	JOIN tbl_continent AS co
ON p.continentName = co.continentName
	JOIN tbl_country AS cu
ON cu.continentName = co.continentName
	JOIN tbl_warehouse AS w
ON w.countryName = cu.countryName;

CREATE VIEW view_warehouseToStore
AS
SELECT
	w.warehouseId AS [Warehouse Id],
	co.countryName AS [Country],
	z.zoneName AS [Zone Name],
	s.storeId AS [Store Id]
FROM tbl_warehouse AS w
	JOIN tbl_country AS co
ON co.countryName = w.countryName
	JOIN tbl_zone AS z
ON z.countryName = co.countryName
	JOIN tbl_store AS s
ON s.zoneId = z.zoneId;

CREATE VIEW view_warehouseInventory
AS
SELECT
	wi.id AS [Warehouse Id],
	wi.arrival AS [Warehouse Arrival Date],
	wi.departure AS [Warehouse Departure Date],
	v.title AS [Vinyl Title],
	v.releaseDate AS [Vinyl Release Date]
FROM tbl_warehouseInventory AS wi
	JOIN tbl_vinyl AS v
ON v.vinylId = wi.vinylId;

CREATE VIEW view_storeInventory
AS
SELECT
	s.id AS [Store Id],
	s.arrival AS [Store Arrival Date],
	s.departure AS [Store Departure Date],
	v.title AS [Vinyl Title],
	v.releaseDate AS [Vinyl Release Date]
FROM tbl_storeInventory AS s
	JOIN tbl_vinyl AS v
ON v.vinylId = s.vinylId;

CREATE VIEW view_vinyl
AS
SELECT
	v.title AS [Vinyl Title],
	v.releaseDate AS [Vinyl Release Date],
	--studio info missing I don't know what info we scrape yet
	g.genreName AS [Genre],
	--track info missing, i dont know how to implement tracks yet
	b.bandName AS [Band]
FROM tbl_vinyl AS v
	JOIN tbl_genre AS g
ON g.vinylId = v.vinylId
	JOIN tbl_band AS b
ON b.vinylId = v.vinylId