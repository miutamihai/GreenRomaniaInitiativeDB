create procedure CreateVehicle @ClientVehicleRegNo varchar(50), @ClientVehicleFabricationDate date,
                               @ClientVehicleType varchar(50), @ClientID int,
                               @OperatorUsername varchar(50), @OperatorPassword varchar(50)
as
begin
    declare @PermissionResponseCode int;
    set @PermissionResponseCode = dbo.CHECKOPERATORPERMISSION(@OperatorUsername, @OperatorPassword, 'Insert');
    if (@PermissionResponseCode = 404)
        begin
            throw 404, 'Operator not found', 1
        end
    if (@PermissionResponseCode = 403)
        begin
            throw 403, 'Operator does not have the required permissions to run this operation', 1
        end

    insert into VehicleTBL(VehicleRegNo, VehicleFabricationDate, VehicleType, CustomerID) values
    (@ClientVehicleRegNo, @ClientVehicleFabricationDate, @ClientVehicleType, @ClientID)
end

