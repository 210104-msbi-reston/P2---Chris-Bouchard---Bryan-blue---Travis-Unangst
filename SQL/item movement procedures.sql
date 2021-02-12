CREATE PROCEDURE proc_transferItem
@toLocation VARCHAR(20),
@locationId INT,
@itemCount INT
AS
BEGIN
	IF @toLocation = 'Warehouse'
		BEGIN
			--while until itemCount
			-- production needs to create item instance
			--production needs to send 
		END


	DECLARE @countIncrement INT;
	SET @countIncrement = @itemCount;


END

CREATE PROCEDURE proc_productionToWarehouse 
@productionId INT,
@warehouseId INT
AS
BEGIN
	--create item
	--
END