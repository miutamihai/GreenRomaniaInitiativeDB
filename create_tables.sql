create table CustomerTBL(
    CustomerID int primary key identity ,
    CustomerName varchar(50) ,
    CustomerAddress varchar(50) ,
    CustomerCity varchar(50) ,
    CustomerCounty varchar(50) ,
    CustomerCreditLimit int ,
    CarbonCredits int ,
    NoOfEmployees int ,
    CustomerType varchar(50)
);

create table VehicleTBL(
  VehicleID int primary key identity,
  VehicleRegNo varchar(7) ,
  VehicleFabricationDate date ,
  VehicleType varchar(10),
  CustomerID int references CUSTOMERTBL(CustomerID)
);

create table ElectricityTBL(
    ElectricityID int primary key identity,
    ProducerName varchar(50),
    PricePerUnit int
);

create table ChargerTBL(
    ChargerID int primary key identity,
    ChargerAddress varchar(50) ,
    ChargerCity varchar(50) ,
    ChargerCounty varchar(50) ,
    ElectricityID int references ELECTRICITYTBL(ElectricityID)
);

create table ChargingDetailsTBL(
    TransactionID int primary key identity,
    ChargerID int references CHARGERTBL(ChargerID) ,
    UnitsSold int ,
    SalesAmount int ,
    SaleDate date ,
    VehicleID int references VEHICLETBL(VehicleID)
);

create table UserRoles(
    RoleID int primary key identity,
    RoleName varchar(50) ,
    RoleCanSelect char(1) ,
    RoleCanUpdate char(1) ,
    RoleCanInsert char(1) ,
    RoleCanDelete char(1)
);

create table Users(
    UserID int primary key identity,
    UserName varchar(50) ,
    UserPassword varchar(50) ,
    UserRoleID int references USERROLES(RoleID)
);


