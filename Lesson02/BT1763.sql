create database BT1763
go

use BT1763
go

create table sinhvien(
	rollno int primary key,
	fullname nvarchar(50),
	age int,
	address nvarchar(200),
	email nvarchar(150),
	phoneNumber nvarchar(20),
	gender nvarchar(15)
)
go

insert into sinhvien(rollno,fullname,age,address,email,phoneNumber,gender)
values
(1102,'Do Huy Hoa',23,'Ha Noi','dohuyhoa@gmail.com','0352099841','nam'),
(1103,'Nguyen Aa An',24,'Ha Noi', 'Nguyenanna@gmail.com','0356999841','nam'),
(1104,'Duong Anh Tu',25,'Ha Noi', 'Duong nah yu.com','0356119841','nu'),
(1105,'Maiu Ly',26,'Ha Noi', 'maily@gmail.com','0356000841','nu'),
(1106,'Dang Ka',27,'Ha Noi', 'dangxuanka.com','0356349841','nam')
go
--bang mon hoc
create table monhoc(
	mamonhoc int primary key identity(1,1),
	tenmonhoc nvarchar(30)
)
go

insert into monhoc(tenmonhoc)
values
('HTML/CSS/Javascript'),
('AngularJS'),
('SQL server'),
('PHP'),
('Ruby')
go


create table bangdiem(
	diem int,
	rollno int,
	mamonhoc int,
)
go

insert into bangdiem(diem,rollno,mamonhoc)
values(8,3,3),(9,1,1),(7,4,4),(6,5,5),(10,1,3)
go
--bang  lop hoc
create table lophoc(
	malophoc int primary key identity(1,1),
	tenlophoc nvarchar(10),
	rollno int
)
go

insert into lophoc(tenlophoc,rollno)
values
	('C2110L',2110),
	('C2111L',2111),
	('C2112L',2112),
	('C2113L',2113),
	('C2114L',2114)
go
--bnag phong hoc
create table phonghoc(
	tenphonghoc nvarchar(50),
	maphonghoc int primary key identity(1,1),
	sobanhoc int,
	soghehoc int,
	diachilophoc nvarchar(100)
)
go
insert into phonghoc(tenphonghoc,sobanhoc,soghehoc,diachilophoc)
values
('theory1',20,20,'tang 1'),
('theory2',25,25,'tang 2'),
('theory3',15,15,'tang 3'),
('lab 1',20,20,'tang 1'),
('lab 2',25,25,'tang 2'),
('lab 3',15,15,'tang 3')
go


select * from sinhvien
go

select * from monhoc
go

select * from bangdiem
go

select * from lophoc
go

select * from phonghoc
go

select * from phonghoc
where sobanhoc > 5 and soghehoc > 5
go

select * from phonghoc
where sobanhoc > 5 and soghehoc > 5 and sobanhoc < 20 and soghehoc <20
go