create database baidauxe
go
use baidauxe
go

create table baidoxe(
	tenbai nvarchar(50),
	mabaidoxe int primary key identity(1,1),
	diachi nvarchar(200)
)
go

insert into baidoxe(tenbai,diachi)
values
('Bach Khoa 1','56 Ta Quang Buu'),
('Bach Khoa 2','02 Ta Quang Buu'),
('Bach Khoa 3','04 Ta Quang Buu'),
('Bach Khoa 4','11 Ta Quang Buu'),
('Bach Khoa 5','22 Ta Quang Buu')
go

--thong tin gui
create table thongtingui(
	id int primary key identity(1,1),
	tenxe nvarchar(50),
	biensoxe nvarchar(20),
	mabaidoxe int,
	id_chusohuu int,
)
go


insert into thongtingui(tenxe,biensoxe,mabaidoxe,id_chusohuu)
values
('Maybach 650','29H888-88',1,1),
('Lexus 570','29H128-88',2,2),
('Land cruiser XL','29H888-66',3,3),
('G63 ','29H888-77',4,4),
('Honda City','29H666-88',5,5)
go

drop table thongtingui
--bang chu so huu
create table chusohuu(
	id_chusohuu int primary key identity(1,1),
	ten_chusohuu nvarchar(30),
	so_cmnd nvarchar(20),
	diachi_chusohuu nvarchar(200)
)
go

insert into chusohuu(ten_chusohuu,so_cmnd,diachi_chusohuu)
values
	('Do Huy Hoa','173394818','Thanh Tri'),
	('Do  Hoa','1117311','Thanh Tri'),
	('Do Huy','0017222','Huu Hoa'),
	('JaeKin','017312128','Ba Dinh'),
	('Luose','173000','Ba Dinh')
go

select * from baidoxe
go

select * from thongtingui
go

select * from chusohuu
go

select chusohuu.so_cmnd,chusohuu.ten_chusohuu,baidoxe.tenbai,thongtingui.biensoxe from chusohuu,baidoxe,thongtingui
go