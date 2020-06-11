insert into CustomerTBL(customername, customeraddress, customercity, customercounty, customercreditlimit, carboncredits,
                        noofemployees, customertype)
values
('Lidl Romania', 'str Capitan Aviator Alexandru Șerbanescu, nr 58a', 'Bucuresti', 'Bucuresti', 200,
               15, 5000, 'Multinationala'),
('SC ANNABELLA SRL', 'str. Barajului, nr.52', 'Rm Valcea', 'Valcea', 100,
               0, 749, 'Nationala'),
('Nerds Computing', 'str Calea Dumbrăvii nr 121b', 'Sibiu', 'Sibiu', 12,
               0, 12, 'Locala');

select * from CustomerTBL;
