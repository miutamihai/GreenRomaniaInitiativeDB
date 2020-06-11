create trigger UpdateCarbonCreditTrigger
on CHARGINGDETAILSTBL
    after insert
    as
begin
    declare @ClientID int;
    declare @ClientVehicleID int;
    declare @TotalSale int;
    declare @UnitsPurchased int;
    begin
        select @TotalSale = SALESAMOUNT, @ClientVehicleID = VEHICLEID, @UnitsPurchased = UNITSSOLD
        from inserted;
        if(@UnitsPurchased >= 100)
        begin
            select CUSTOMERID
            into ClientID
            from VEHICLETBL
            where VEHICLETBL.VEHICLEID = @ClientVehicleID;
            update CUSTOMERTBL
            set CARBONCREDITS = CARBONCREDITS + @TotalSale * 0.05
            where CustomerID = @ClientID;
        end
    end
end
