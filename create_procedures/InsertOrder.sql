create procedure InsertOrder @StationID int, @UnitsPurchased int, @ClientVehicleRegNo varchar(50),
                             @OperatorUsername varchar(50), @OperatorPassword varchar(50)
as
begin
    declare @PermissionResponseCode int;
    declare @TotalSaleAmount int;
    declare @PricePerUnit int;
    declare @ClientID int;
    declare @ClientVehicleID int;
    declare @ClientVehicleType varchar(50);
    declare @ClientType varchar(50);
    declare @ClientCarbonCredit int;
    declare @ClientCreditLimit int;
    set @PermissionResponseCode = dbo.CHECKOPERATORPERMISSION(@OperatorUsername, @OperatorPassword, 'Update');
    if (@PermissionResponseCode = 404)
        begin
            throw 404, 'Operator not found', 1
        end
    if (@PermissionResponseCode = 403)
        begin
            throw 403, 'Operator does not have the required permissions to run this operation', 1
        end
    select @ClientVehicleType = VEHICLETYPE, @ClientID = CUSTOMERID, @ClientVehicleID = VEHICLEID
    from VEHICLETBL
    where VEHICLEREGNO = @ClientVehicleRegNo;
    select @ClientType = CUSTOMERTYPE, @ClientCreditLimit = CUSTOMERCREDITLIMIT, @ClientCarbonCredit = CARBONCREDITS
    from CUSTOMERTBL
    where CUSTOMERID = @ClientID;
    select @PricePerUnit = PRICEPERUNIT
    from ELECTRICITYTBL
             inner join CHARGERTBL on ELECTRICITYTBL.ELECTRICITYID = CHARGERTBL.ELECTRICITYID
    where CHARGERID = @StationID;
    set @TotalSaleAmount = @PricePerUnit * @UnitsPurchased;
    if (@TotalSaleAmount > @ClientCreditLimit)
        begin
            throw 500, 'Credit limit exceeded', 1;
        end
    if (@ClientVehicleType = 'Hybrid')
        set @TotalSaleAmount = @TotalSaleAmount + @TotalSaleAmount * 0.2;
    if (@ClientType = 'Multinationala')
        set @TotalSaleAmount = @TotalSaleAmount + @TotalSaleAmount * 0.1;
    if (@ClientType = 'Nationala')
        set @TotalSaleAmount = @TotalSaleAmount + @TotalSaleAmount * 0.05;
    set @TotalSaleAmount = @TotalSaleAmount - @ClientCarbonCredit * 0.01;
    insert into CHARGINGDETAILSTBL (CHARGERID, UNITSSOLD, SALESAMOUNT, SALEDATE, VEHICLEID)
    values (@StationID, @UnitsPurchased, @TotalSaleAmount, GETDATE(), @ClientVehicleID);
end
