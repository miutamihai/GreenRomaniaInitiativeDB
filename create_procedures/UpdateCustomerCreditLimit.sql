create procedure UpdateCustomerCreditLimit @ClientName varchar(50), @NumberOfIntroducedCredits int,
@OperatorUsername varchar(50), @OperatorPassword varchar(50)
as
    begin
        declare @PermissionResponseCode int;
   set @PermissionResponseCode = dbo.CHECKOPERATORPERMISSION(@OperatorUsername, @OperatorPassword, 'Update');
        if(@PermissionResponseCode = 404)
            throw 404, 'Operator credentials wrong', 1
        if(@PermissionResponseCode = 403)
            throw 403, 'Operator does not have the required permissions to run this operation', 1;
        update CUSTOMERTBL
        set CUSTOMERCREDITLIMIT = CUSTOMERCREDITLIMIT + @NumberOfIntroducedCredits
        where CUSTOMERNAME = @ClientName;
    end
