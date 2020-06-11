insert into UserRoles(rolename, rolecanselect, rolecanupdate, rolecaninsert, rolecandelete) values
( 'DbAdmin', 'y', 'y', 'y', 'y'),
('Manager', 'y', 'y', 'y', 'n'),
('Operator', 'y', 'y', 'y', 'n'),
( 'Client', 'y', 'n', 'n', 'n') ;

select * from UserRoles;
