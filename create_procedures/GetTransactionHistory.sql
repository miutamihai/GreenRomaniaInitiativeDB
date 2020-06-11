create procedure GetTransactionHistory @ClientName varchar(50), @DateLimit date
as
    begin
        declare @ClientID int;
        select @ClientID = CUSTOMERID
        from CUSTOMERTBL
        where CUSTOMERNAME = @ClientName;
        select * from CHARGINGDETAILSTBL
        inner join VEHICLETBL on CHARGINGDETAILSTBL.VEHICLEID = VEHICLETBL.VEHICLEID
        inner join CUSTOMERTBL on VEHICLETBL.CUSTOMERID = CUSTOMERTBL.CUSTOMERID
        where CUSTOMERTBL.CUSTOMERID = @ClientID and SALEDATE <= @DateLimit;
    end
