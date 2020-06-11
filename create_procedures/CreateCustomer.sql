create procedure CreateCustomer @ClientName varchar(50), @ClientAddress varchar(50),
                                @ClientCity varchar(50), @ClientCounty varchar(50), @ClientNoOfEmployees int,
                                @OperatorUsername varchar(50), @OperatorPassword varchar(50)
as
begin
    declare @PermissionResponseCode int;
    declare @ClientType varchar(50);
    set @PermissionResponseCode = dbo.CHECKOPERATORPERMISSION(@OperatorUsername, @OperatorPassword, 'Insert');
    if (@PermissionResponseCode = 404)
        begin
            throw 404, 'Operator not found', 1
        end
    if (@PermissionResponseCode = 403)
        begin
            throw 403, 'Operator does not have the required permissions to run this operation', 1
        end
    if (@ClientNoOfEmployees < 500)
        begin
            set @ClientType = 'Locala'
        end
    else
        if (@ClientNoOfEmployees <= 1000)
            begin
                set @ClientType = 'Nationala';
            end
        else
            set @ClientType = 'Multinationala';

    insert into CUSTOMERTBL(customername, customeraddress, customercity, customercounty,
                            customercreditlimit, carboncredits, noofemployees, customertype)
    values (@ClientName, @ClientAddress, @ClientCity, @ClientCounty,
            100, 0, @ClientNoOfEmployees, @ClientType);
end

