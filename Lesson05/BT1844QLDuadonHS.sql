create database BT1844Duadonhocsinh
go

use BT1844Duadonhocsinh
go

create table hocvien(
	id int primary key identity(1,1),
	name nvarchar(50),
	address nvarchar(300),
	fullname_father nvarchar(50),
	fullnam_mother nvarchar(50),
	phone_number nvarchar(20),
	birthDate date,
	gender nvarchar(5),
	diadiem_id nvarchar(300)
)
go

create table Driver(
	id int primary key identity(1,1),
	name nvarchar(50),
	phone_number nvarchar(20),
	gender nvarchar(10),
	address nvarchar(300)
)
go
create table BusInfor(
	id int primary key identity(1,1),
	bus_no nvarchar(20),
	bus_type nvarchar(50),
	seat_number int,
	driver_id int references Driver(id)
)
go

create table AddressPlace(
	id int primary key identity(1,1),
	address nvarchar(300)
)
go

create table Jouney	(
	id_bus  int references BusInfor (id),
	id_diadiemdon int not null  references AddressPlace (id) ,
	primary key (id_bus, id_diadiemdon)
)
go



alter table hocvien
alter column diadiem_id int
go

alter table hocvien
add constraint fk_id_diadiem_hocvien foreign key (diadiem_id) references AddressPlace(id)
go

--insert date for table
insert into AddressPlace (address)
values
( '54 Le Trong Tan'),
( '54 Le Thanh Nghi'),
('54 Le Quy Don'),
( '54 Le Lai'),
( '54 Le Loi'),
('54 Ly Thai To'),
('54 Tran Nhan Tong')
go

insert into AddressPlace (address)
values
( 'Ho Tay'),
( 'Ngi Tam')
go


insert into hocvien (name,address,fullname_father,fullnam_mother,phone_number,birthDate,gender,diadiem_id)
values
('Hocvien 1',  'address 1', 'name father 1', 'name mother 1', '0981111111', '2000-12-02', 'Nam', 1),
('Hocvien 2',  'address 2', 'name father 2', 'name mother 2', '098112222', '2000-03-03', 'Nu', 2),
('Hocvien 3',  'address 3', 'name father 3', 'name mother 3', '09811113333', '2000-04-04', 'Nu', 3),
('Hocvien 4',  'address 4', 'name father 4', 'name mother 4', '09811114444', '2000-05-05', 'Nam', 4),
('Hocvien 5',  'address 5', 'name father 5', 'name mother 5', '0981111555', '2000-6-06', 'Nam', 5),
('Hocvien 6',  'address 6', 'name father 6', 'name mother 6', '098111666', '2000-7-07', 'Nu', 6),
('Hocvien 7',  'address 7', 'name father 7', 'name mother 7', '098116677', '2000-8-08', 'Nam', 7),
('Hocvien 8',  'address 3', 'name father 8', 'name mother 8', '0981111888', '2000-9-09', 'Nu', 2)
go

insert into Jouney (id_bus, id_diadiemdon)
values
(2,1),
(2,2),
(2,3),
(3,4),
(3,5),
(4,6),
(4,7)
go

insert into Jouney (id_bus, id_diadiemdon)
values
(4,8),
(4,9)
go

select * from hocvien
select * from BusInfor
select * from Driver
select * from AddressPlace
select * from Jouney


insert into Driver (name, phone_number, gender, address)
values
('Tay dua 1' , '0986644446' , 'Nam' , 'add_taydua 1'),
('Tay dua 2' , '098669999' , 'Nam' , 'add_taydua 2'),
('Tay dua 3' , '09860000' , 'Nam' , 'add_taydua 3')
go

insert into  BusInfor (bus_no, bus_type, seat_number, driver_id)
values 
('30G111.44', 'Bus Stype vip 1', 24, 1),
('30G111.55', 'Bus Stype vip 2', 30, 2),
('30G111.66', 'Bus Stype vip 3', 9, 3)
go

--Tạo View xem thông tin lộ trình đi của xe bus : tài xế, biển số xe, địa chỉ đón.
create view view_lotrinh_xebus
as
select Driver.name, BusInfor.bus_no, AddressPlace.address
from Driver, BusInfor, AddressPlace, Jouney
where BusInfor.driver_id = Driver.id and Jouney.id_bus = BusInfor.id and Jouney.id_diadiemdon = AddressPlace.id
group by  Driver.name, BusInfor.bus_no, AddressPlace.address
go

select *  from view_lotrinh_xebus


--Tạo Proc xem thông tin sinh viên theo biển số xe.
create proc proc_thogntinsv_BSX
@bx_id int
as 
begin
	select hocvien.id, hocvien.name, hocvien.address, hocvien.birthDate, hocvien.gender
	from hocvien,BusInfor, AddressPlace, Jouney
	where hocvien.diadiem_id = AddressPlace.id and Jouney.id_diadiemdon = AddressPlace.id and Jouney.id_bus = BusInfor.id and BusInfor.id = @bx_id
end

exec proc_thogntinsv_BSX 4


--Tao View xem thông tin sinh viên gồm : Tên SV, giới tính, địa chỉ đó
create view view_thongtinSV
as
select hocvien.name, hocvien.gender, hocvien.address
from hocvien
go

select * from view_thongtinSV
go