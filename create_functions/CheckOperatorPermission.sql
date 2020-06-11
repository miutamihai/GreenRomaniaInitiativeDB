create function CheckOperatorPermission(@OperatorUsername varchar(50), @OperatorPassword varchar(50),
                                        @RequestedOperationName varchar(50))
    returns int
as
begin
    declare @ResponseCode int;
    declare @OperatorRoleID int;
    declare @OperatorPermission char(1);
    select @OperatorRoleID = USERROLEID
        from USERS
        where USERNAME = @OperatorUsername
          and USERPASSWORD = @OperatorPassword;
        if (@OperatorRoleId = 0 or @OperatorRoleId IS NULL)
            begin
                set @ResponseCode = 404; --not found
                return @ResponseCode
            end
        if (@RequestedOperationName = 'Select')
            begin
                select @OperatorPermission = ROLECANSELECT
                from USERROLES
                where ROLEID = @OperatorRoleId;
            end
        if (@RequestedOperationName = 'Update')
            begin
                select @OperatorPermission = RoleCanUpdate
                from USERROLES
                where ROLEID = @OperatorRoleId;
            end
        if (@RequestedOperationName = 'Insert')
            begin
                select @OperatorPermission = RoleCanInsert
                from USERROLES
                where ROLEID = @OperatorRoleId;
            end
        if (@RequestedOperationName = 'Delete')
            begin
                select @OperatorPermission = RoleCanDelete
                from USERROLES
                where ROLEID = @OperatorRoleId;
            end
        if (@OperatorPermission = 'n')
            begin
                set @ResponseCode = 403
                return @ResponseCode
            end
        set @ResponseCode = 200
        return (@ResponseCode);
end;
