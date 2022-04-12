create database customers
go

use customers
go

create table khachhang(
	makh char(4) primary key,
	hoten varchar(40),
	dchi varchar(50),
	sodt varchar(20),
	ngsinh smalldatetime,
	ngdk smalldatetime,
	doanhso money
)
go

create table nhanvien(
	manv char(4) primary key,
	hoten varchar(40),
	sodt varchar(20),
	ngvl smalldatetime
)
go


create table sanpham(
	masp char(4) primary key,
	tensp varchar(40),
	dvt varchar(20),
	nuocsx varchar(40),
	gia money
)
go

create table hoadon(
	sohd int primary key,
	nghd smalldatetime,
	makh char(4) references khachhang(makh),
	manv char(4) references nhanvien(manv),
	trigia money
)
go

create table cthd(
	sohd int references hoadon(sohd),
	masp char(4)references sanpham(masp),
	sl int
)
go
--insert cac du lieu
--insert table nhan vien
insert into nhanvien(manv, hoten, sodt,ngvl)
values
('NV01', 'Nguyen Nhu Nhut','0927345678','2006/4/13'),
('NV02', 'Le Thi Phi Yen','0987567390','2006/4/21'),
('NV03', 'Nguyen Vawn B','097047382','2006/4/27'),
('NV04', 'Ngo Thanh Tuan','0913758498','2006/6/24'),
('NV05', 'Nguyen Thi Truc Thanh','0918590387','2006/7/20')
go

select * from nhanvien
go

select * from khachhang
go

insert into khachhang(makh,hoten,dchi,sodt,ngsinh,doanhso,ngdk)
values
('KH01','Nguyen Van A','721 Tran Hung Dao, Q5, TpHCM','08823451','1960/10/22',13060000,'2006/07/22'),
('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','0908256478','1974/4/3',280000,'2006/07/30'),
('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','0938776266','1980/6/12',3860000,'2006/8/5'),
('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','0917325476','1965/3/9',250000,'2006/10/02'),
('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','08246108','1950/3/10',21000,'2006/10/28'),
('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','08631738','1981/12/31',915000,'2006/11/24'),
('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','0916783565','1971/4/6',12500,'2006/12/01'),
('KH08','Phan Thi Thanh','45/2  An Duong Vuong, Q5, TpHCM','0938435756','1971/1/10',365000,'2006/12/13'),
('KH09','Le NHa Vinh','873 Le hong Phong, Q5, TpHCM','08654763','1979/9/3',70000,'2006/01/14'),
('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','08768904','1983/5/2',67500,'2006/01/16')
go

insert into sanpham values ('BC01','But chi','cay','Singapore',3000)
go
insert into sanpham values ('BC02','But chi','cay','Singapore',5000)
go
insert into sanpham values ('BC03','But chi','cay','Viet Nam',3500)
go
insert into sanpham values ('BC04','But chi','hop','Viet Nam',30000)
go
insert into sanpham values ('BB01','But bi','cay','Viet Nam',5000)
go
insert into sanpham values ('BB02','But bi','cay','Trung Quoc',7000)
go
insert into sanpham values ('BB03','But bi','hop','Thai Lan',100000)
go
insert into sanpham values ('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
go
--
insert into sanpham values ('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
insert into sanpham values ('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
insert into sanpham values ('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
insert into sanpham values ('TV05','Tap 100 trang','chuc','Viet Nam',23000)
insert into sanpham values ('TV06','Tap 200 trang','chuc','Viet Nam',53000)
insert into sanpham values ('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
insert into sanpham values ('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
insert into sanpham values ('ST02','So tay loai 1','quyen','Viet Nam',55000)
insert into sanpham values ('ST03','So tay loai 2','quyen','Viet Nam',51000)
insert into sanpham values ('ST04','So tay ','quyen','Thai Lan',55000)
insert into sanpham values ('ST05','So tay mong','quyen','Thai Lan',20000)
insert into sanpham values ('ST06','Phan viet bang','hop','Viet Nam',5000)
insert into sanpham values ('ST07','Phan khong bui','hop','Viet Nam',7000)
insert into sanpham values ('ST08','Bong bang','cai','Viet Nam',1000)
insert into sanpham values ('ST09','But long','cay','Viet Nam',5000)
insert into sanpham values ('ST10','But long','cay','Trung Quoc',7000)

select * from sanpham
go

insert into hoadon values (1001,'2006/07/23','KH01','NV01',320000)
insert into hoadon values (1002,'2006/02/12','KH01','NV02',840000)
insert into hoadon values (1003,'2006/08/23','KH02','NV01',100000)
insert into hoadon values (1004,'2006/09/01','KH02','NV01',180000)
insert into hoadon values (1005,'2006/10/20','KH01','NV02',3800000)
insert into hoadon values (1006,'2006/10/16','KH01','NV03',2430000)
insert into hoadon values (1007,'2006/10/28','KH03','NV03',510000)
insert into hoadon values (1008,'2006/10/28','KH01','NV03',440000)
insert into hoadon values (1009,'2006/10/28','KH03','NV04',200000)
insert into hoadon values (1010,'2006/11/01','KH01','NV01',5200000)
insert into hoadon values (1011,'2006/11/04','KH04','NV03',250000)
insert into hoadon values (1012,'2006/11/30','KH05','NV03',21000)
insert into hoadon values (1013,'2006/12/12','KH06','NV01',5000)
insert into hoadon values (1014,'2006/12/31','KH03','NV02',3150000)
insert into hoadon values (1015,'2007/01/01','KH06','NV01',910000)
insert into hoadon values (1016,'2007/01/01','KH07','NV02',12500)
insert into hoadon values (1017,'2007/01/02','KH08','NV03',35000)
insert into hoadon values (1018,'2007/01/13','KH08','NV03',330000)
insert into hoadon values (1019,'2007/01/13','KH01','NV03',30000)
insert into hoadon values (1020,'2007/01/14','KH09','NV04',70000)
insert into hoadon values (1021,'2007/01/16','KH10','NV03',67500)
insert into hoadon values (1022,'2007/01/16',null,'NV03',7000)
insert into hoadon values (1023,'2007/01/17',null,'NV01',330000)

select * from hoadon
drop table hoadon
drop table khachhang
drop table sanpham
drop table nhanvien
drop table cthd

insert into cthd values (1001,'TV02',10)
insert into cthd values (1001,'ST01',5)
insert into cthd values (1001,'BC01',5)
insert into cthd values (1001,'BC02',10)
insert into cthd values (1001,'ST08',10)
insert into cthd values (1002,'BC04',20)
insert into cthd values (1002,'BB01',20)
insert into cthd values (1002,'BB02',20)
insert into cthd values (1003,'BB03',10)
insert into cthd values (1004,'TV01',20)
insert into cthd values (1004,'TV02',20)
insert into cthd values (1004,'TV03',20)
insert into cthd values (1004,'TV04',20)
insert into cthd values (1005,'TV05',50)
insert into cthd values (1005,'TV06',50)
insert into cthd values (1006,'TV07',20)
insert into cthd values (1006,'ST01',30)
insert into cthd values (1006,'ST02',10)
insert into cthd values (1007,'ST03',10)
insert into cthd values (1008,'ST04',8)
insert into cthd values (1009,'ST05',10)
insert into cthd values (1010,'TV07',50)
insert into cthd values (1010,'ST07',50)
insert into cthd values (1010,'ST08',100)
insert into cthd values (1010,'ST04',50)
insert into cthd values (1010,'TV03',100)
insert into cthd values (1011,'ST06',50)
insert into cthd values (1012,'ST07',3)
insert into cthd values (1013,'ST08',5)
insert into cthd values (1014,'BC02',80)
insert into cthd values (1014,'BB02',100)
insert into cthd values (1014,'BC04',60)
insert into cthd values (1014,'BB01',50)
insert into cthd values (1015,'BB02',30)
insert into cthd values (1015,'BB03',7)
insert into cthd values (1016,'TV01',5)
insert into cthd values (1017,'TV02',1)
insert into cthd values (1017,'TV03',1)
insert into cthd values (1017,'TV04',5)
insert into cthd values (1018,'ST04',6)
insert into cthd values (1019,'ST05',1)
insert into cthd values (1019,'ST06',2)
insert into cthd values (1020,'ST07',10)
insert into cthd values (1021,'ST08',5)
insert into cthd values (1021,'TV01',7)
insert into cthd values (1021,'TV02',10)
insert into cthd values (1022,'ST07',1)
insert into cthd values (1023,'ST04',6)