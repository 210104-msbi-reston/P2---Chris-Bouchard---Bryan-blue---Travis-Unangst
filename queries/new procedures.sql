	--init warehouse 1 / country
	--init zone 4
	--init store 1-3 random
-----------------------------------------------------------------------------------
--ssis import continent list
	-- for each row in continent list run this

CREATE PROCEDURE proc_initProduction @contId INT
AS
BEGIN
	--init production house 2 / continent
		--get amount of production houses (2)
		-- use amount as a loop
			--create production house
	
	DECLARE @productionCount INT;
	SET @productionCount = 2;
	WHILE @productionCount > 0
		BEGIN
			SELECT @productionCount = @productionCount - 1;
			INSERT INTO tbl_production(continentId) VALUES(@contId);
		END
END
-- EXECUTE proc_initProduction @contId = ?
--test
	-- SELECT *  FROM tbl_production

-----------------------------------------------------------------------------------
--ssis import country list
	--for each row in country list run this

CREATE PROCEDURE proc_initWarehouseAndZone @countrId INT
AS
BEGIN
	--init production house 2 / continent
		--get amount of production houses (2)
		-- use amount as a loop
			--create production house
	
	DECLARE @warehouseCount INT;
	SET @warehouseCount = 2;
	DECLARE @insertedWarehouseId INT;

	WHILE @warehouseCount > 0
		BEGIN
			SELECT @warehouseCount = @warehouseCount - 1;
			INSERT INTO tbl_warehouse(countryId) VALUES(@countrId);

			SET @insertedWarehouseId = SCOPE_IDENTITY();

			INSERT INTO tbl_zone(countryId, zoneName) VALUES(@countrId, 'North');
			INSERT INTO tbl_zone(countryId, zoneName) VALUES(@countrId, 'East');
			INSERT INTO tbl_zone(countryId, zoneName) VALUES(@countrId, 'South');
			INSERT INTO tbl_zone(countryId, zoneName) VALUES(@countrId, 'West');
		END
END
-- EXECUTE proc_initWarehouseAndZone @countrId = ?
--test
	-- SELECT count(*) AS [warehouse in country] FROM tbl_warehouse GROUP BY countryId
	-- SELECT * FROM tbl_zone

-----------------------------------------------------------------------------------
--ssis import zone list
	--for each row in zone lis run this

CREATE PROCEDURE proc_initStore @zoneId INT
AS
BEGIN
	DECLARE @zoneCount INT;
	SET @zoneCount = RAND()*(3-1)+1; 

	WHILE @zoneCount > 0
		BEGIN
			SELECT @zoneCount = @zoneCount - 1;

			INSERT INTO tbl_store(zoneId) VALUES(@zoneId);
		END
END

-- EXECUTE proc_initStore @zoneId = ?
--test
	-- SELECT * FROM tbl_store
	-- SELECT COUNT(*) AS [stores in zone] FROM tbl_store GROUP BY zoneId