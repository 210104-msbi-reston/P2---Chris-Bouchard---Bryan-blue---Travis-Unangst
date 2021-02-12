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
	SET @zoneCount = FLOOR(RAND()*4); 

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


-----------------------------------------------------------------------------------
--ssis import album list
	--for each row in the album list
	--title,artist,genre,year,img_url,tracklist
	--The Dark Side Of The Moon | Pink Floyd | Rock;Prog Rock;Psychedelic Rock | 1973 | https://img.discogs.com/jKTmuxcsYe2TqcahU3QqVXJLssU=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-1873013-1471100381-3022.jpeg.jpg | Speak To Me;Breathe;On The Run;Time;The Great Gig In The Sky;Money;Us And Them;Any Colour You Like;Brain Damage;Eclipse

CREATE PROCEDURE proc_initAlbum 
@aTitle VARCHAR(255),
@aArtist VARCHAR(100),
@aYear DATETIME,
@aLink VARCHAR(max)
--@aGenre VARCHAR(100),
--@aTracks VARCHAR(max)
AS
BEGIN
	--variables
	DECLARE @insertedAlbumIdentity INT;

	--add to info table
	INSERT INTO tbl_albumInfo(title,artist,releaseDate,imgLink)
	VALUES(@aTitle,@aArtist,@aYear,@aLink);

	SET @insertedAlbumIdentity = SCOPE_IDENTITY();

	--break up genres on the ; delimiter
	--get count
	--check for genre

	--add to genre table
END

CREATE PROCEDURE proc_initGenre
@genre VARCHAR(25),
@title VARCHAR(255),
@artist VARCHAR(100)
AS
BEGIN
	DECLARE @albumInfoId INT;
	DECLARE @genreId INT;

	--check if already a genre
	IF NOT EXISTS (SELECT * FROM tbl_genre 
                   WHERE genreName = @genre)
	   BEGIN
			--insert into genre table
		   INSERT INTO tbl_genre(genreName) VALUES (@genre);
		   --connect genre id to albumInfoId
		   --get genreId
		   SET @genreId = SCOPE_IDENTITY();
	   END
	ELSE
		BEGIN
			--genre already exists
			--find genre id by genreName
			SELECT @genreId = genreId FROM tbl_genre;
		END

	--get albumInfoId
	SELECT @albumInfoId = albumInfoId FROM tbl_albumInfo
	WHERE title = @title
	AND artist = @artist;
	--we have albumInfoId and genreId
	--create tbl_albumInfo_genre
	INSERT INTO tbl_albumInfo_genre(albumInfoId, genreId)
	VALUES(@albumInfoId, @genreId);
END

CREATE PROCEDURE proc_initTrack
@track VARCHAR(50),
@title VARCHAR(255),
@artist VARCHAR(100)
AS
BEGIN
	--find albumInfoId
	--insert into tbl_track
	DECLARE @albumInfoId INT;
	SELECT albumInfoId FROM tbl_albumInfo
	WHERE title = @title
	AND artist = @artist

	INSERT INTO tbl_track(albumInfoId, trackName)
	VALUES(@albumInfoId, @track);
END


--import warehouse list into ssis
CREATE PROCEDURE proc_initWarehousesInventory
@warehouseId INT,
@albumInfoId INT,
@itemCount INT
AS
BEGIN
	--create increment for itemCount
	DECLARE @foundProductionId INT;
	DECLARE @countIncrement INT;
	SET @countIncrement = @itemCount;

	WHILE @countIncrement > 0
		BEGIN
			SELECT @countIncrement = @countIncrement -1;
			--select random production house with TOP(1) --ORDER BY NEWID()
			SELECT TOP(1) @foundProductionId = [Production Id] FROM view_productionToWarehouse
			WHERE [Warehouse Id] = @warehouseId
			ORDER BY NEWID();

			--commission order
			INSERT INTO tbl_item(

		END

END

select * from view_productionToWarehouse
WHERE [Warehouse Id] = 1
