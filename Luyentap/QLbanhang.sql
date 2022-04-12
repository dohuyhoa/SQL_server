create database QuanlyBanHang
go

use QuanlyBanHang
go

create table KHACHHANG (
	MAKH char(4) not null,
	HOTEN varchar(40),
	DCHI varchar(50),
	SODT varchar(20),
	NGSH smalldatetime,
	NGDK smalldatetime,
	DOANHSO money
)
go



create table NHANVIEN (
	MANV char(4) not null,
	HOTEN varchar(40)  not null,
	SODT varchar(20),
	NGVL smalldatetime
)
go

create table SANPHAM (
	MASP char(4)  not null,
	TENSP  varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money
)
go

create table HOADON (
	SOHD int  not null,
	NGHD smalldatetime,
	MAKH char(4) not null,
	MANV  char(4)  not null,
	TRIGIA money
)
go

create table CTHD (
	SOHD int not null,
	MASP char(4) not null,
	SL int
)
go

-- them primary forenkey
-----primary key
alter table KHACHHANG
add constrat pk_makh_khachhang primary key (MAKH)
go

alter table NHANVIEN
add constrat pk_manv_nhanvien primary key (MANV)
go

alter table SANPHAM
add constrat pk_masp_sanpham primary key (MASP)
go

alter table HOADON
add constrat pk_sohd_hoadon primary key (SOHD)
go


---Foreign key
alter table HOADON
add constrat fk_makh_hoadon foreign key (MAKH) references KHACHHANG (MAKH)
go

alter table HOADON
add constrat fk_masp_hoadon foreign key (MANV) references NHANVIEN (MANV)
go

alter table CTHD
add constrat fk_SOHD_CTHD foreign key (SOHD) references HOADON (SOHD)
go

alter table CTHD
add constrat fk_MASP_CTHD foreign key (MASP) references SANPHAM (MASP)
go

--THEM DU LIEU CHO BANG
insert into KHACHHANG(MAKH,HOTEN, DCHI, SODT, NGSH, NGDK, DOANHSO)
values
('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22' ,'2006-10-22', 13060000),
('KH02', 'Tran Ngoc Han', '23-5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-04-03', '2006-07-30', 280000),
('KH03', 'Tran Ngoc Lh', '50-34 Le Daij Hanh, Q10, TpHCM', '0917325476' , '1965-03-09', '2006-08-05', 3860000),
('KH04', 'Tran Mh Long', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22' ,'2006-10-02', 13060000),
('KH05','Le Nhat Mh', '34, Truong Dh, Q 3, Tp HCM' ,'08246108', '1950-03-10', '2006-10-28',21000),
('KH06','Le Hoai Thuong','227, Nguyen Van Cu, Q 5, Tp HCM','08631738','1981-12-31','2006-11-24',915000),
('KH07','Nguyen Van Tam','32-3, Tran Bh Trong, Q 5, Tp HCM','0916783565','1971-04-06' ,'2006-12-01',12500),
('KH08','Phan Thi Thanh','45-2, An Duong Vuong, Q 5, Tp HCM','0938435756','1971-01-10','2006-12-13',365000),
('KH09','Le Ha Vh','873, Le Hong Phong, Q 5, Tp HCM','08654763','1979-09-03','2007-01-14',70000),
('KH10','Ha Duy Lap','34-34B, Nguyen Trai, Q 1, Tp HCM','08768904','1983-05-02','2007-01-16',67500)
go

insert into NHANVIEN(MANV, HOTEN, SODT, NGVL)
VALUES
	('NV01','Nguyen Nhu Nhut','0927345678','2006-04-13'),
	('NV02','Le Thi Phi Yen','0987567390','2006-04-21'),
	('NV03','Nguyen Van B','0997047382','2006-04-27'),
	('NV04','Ngo Thanh Tuan','0913758498','2006-06-24'),
	('NV05','Nguyen Thi Truc Thanh','0918590387','2006-07-20')
go

insert into SANPHAM(MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
	('BC01','But chi','cay','Sgapore',3000),
	('BC02','But chi','cay','Sgapore',5000),
	('BC03','But chi','cay','Viet Nam',3500),
	('BC04','But chi','hop','Viet Nam',30000),
	('BB01','But bi','cay','Viet Nam',5000),
	('BB02','But bi','cay','Trung Quoc',7000),
	 ('BB03','But bi','hop','Thai Lan',100000),
	('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
go

insert into SANPHAM(MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
	('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500),
	('TV03','Tap 100 giay tot','quyen','Viet Nam',3000),
	('TV04','Tap 200 giay tot','quyen','Viet Nam',5500),
	('TV05','Tap 100 trang','chuc','Viet Nam',23000),
	('TV06','Tap 200 trang','chuc','Viet Nam',53000),
	('TV07','Tap 100 trang','chuc','Trung Quoc',34000),
	('ST01','So tay 500 trang','quyen','Trung Quoc',40000),
	('ST02','So tay loai 1','quyen','Viet Nam',55000),
	('ST03','So tay loai 2','quyen','Viet Nam',51000),
	('ST04','So tay ','quyen','Thai Lan',55000),
	('ST05','So tay mong','quyen','Thai Lan',20000),
	('ST06','Phan viet bang','hop','Viet Nam',5000),
	('ST07','Phan khong bui','hop','Viet Nam',7000),
	('ST08','Bong bang','cai','Viet Nam',1000),
	('ST09','But long','cay','Viet Nam',5000),
	('ST10','But long','cay','Trung Quoc',7000)
go

insert into HOADON(SOHD,NGHD, MAKH, MANV, TRIGIA)
values
	(1001,'2006-07-23','KH01','NV01',320000),
	(1002,'2006-08-12','KH01','NV02',840000),
	(1003,'2006-08-23','KH02','NV01',100000),
	(1004,'2006-09-01','KH02','NV01',180000),
	(1005,'2006-10-20','KH01','NV02',3800000),
	(1006,'2006-10-16','KH01','NV03',2430000),
	(1007,'2006-10-28','KH03','NV03',510000),
	(1008,'2006-10-28','KH01','NV03',440000),
	(1009,'2006-10-28','KH03','NV04',200000),
	(1010,'2006-11-01','KH01','NV01',5200000),
	(1011,'2006-11-04','KH04','NV03',250000),
	(1012,'2006-11-30','KH05','NV03',21000),
	(1013,'2006-12-12','KH06','NV01',5000),
	(1014,'2006-12-31','KH03','NV02',3150000),
	(1015,'2007-01-01','KH06','NV01',910000),
	(1016,'2007-01-01','KH07','NV02',12500),
	(1017,'2007-01-02','KH08','NV03',35000),
	(1018,'2007-01-13','KH08','NV03',330000),
	(1019,'2007-01-13','KH01','NV03',30000),
	(1020,'2007-01-14','KH09','NV04',70000),
	(1021,'2007-01-16','KH10','NV03',67500),
	(1022,'2007-01-16','KH10','NV03',7000),
	(1023,'2007-01-17','KH08','NV01',330000)
go

insert into CTHD(SOHD, MASP, SL)
values
(1001,'TV02',10),
(1001,'ST01',5),
(1001,'BC01',5),
(1001,'BC02',10),
(1001,'ST08',10),
(1002,'BC04',20),
(1002,'BB01',20),
(1002,'BB02',20),
(1003,'BB03',10),
(1004,'TV01',20),
(1004,'TV02',20),
(1004,'TV03',20),
(1004,'TV04',20),
(1005,'TV05',50),
(1005,'TV06',50),
(1006,'TV07',20),
(1006,'ST01',30),
(1006,'ST02',10),
(1007,'ST03',10),
(1008,'ST04',8),
(1009,'ST05',10),
(1010,'TV07',50),
(1010,'ST07',50),
(1010,'ST08',100),
(1010,'ST04',50),
(1010,'TV03',100),
(1011,'ST06',50),
(1012,'ST07',3),
(1013,'ST08',5),
(1014,'BC02',80),
(1014,'BB02',100),
(1014,'BC04',60),
(1014,'BB01',50),
(1015,'BB02',30),
(1015,'BB03',7),
(1016,'TV01',5),
(1017,'TV02',1),
(1017,'TV03',1),
(1017,'TV04',5),
(1018,'ST04',6),
(1019,'ST05',1),
(1019,'ST06',2),
(1020,'ST07',10),
(1021,'ST08',5),
(1021,'TV01',7),
(1021,'TV02',10),
(1022,'ST07',1),
(1023,'ST04',6)
go


--Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
alter table SANPHAM
add GHICHU varchar(20)
go
select *from SANPHAM

--Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
alter table SANPHAM
alter column GHICHU varchar(100)
go


--Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
alter table SANPHAM
drop column GHICHU
go


--Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
alter table KHACHHANG
add LOAIKH tinyint
go

alter table KHACHHANG
alter column LOAIKH varchar(100)
go


----CHECK
--------Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
alter table SANPHAM
add constraint check_sanpham check (DVT in ('cay','hop', 'cai','quyen', 'chuc'))
go
insert into SANPHAM(MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
	('JK03','Tap 200 giay mong','quyen','Trung Quoc',400)
	go
	-----------Giá bán của sản phẩm từ 500 đồng trở lên.
	alter table SANPHAM
	add constraint check_giaban_sanpham check (GIA >500)
	go

	----------Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
alter table CTHD
add constraint check_soluong check (SL >= 1)
go


	insert into CTHD(SOHD, MASP, SL)
	values
	(1001,'TV02',0),
	(1001,'ST01',5)
	go

	-----Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
alter table KHACHHANG
add constraint check_ngaydangky check (NGDK >NGSH)
go

-----Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách --hàng đó đăng ký thành viên (NGDK).
-----CHUA LAM DUOC
alter table KHACHHANG,HOADON
add constraint check_ngaymuahang check (HOADON.NGHD  > KHACHHANG.NGSH)
go
	

select * from KHACHHANG
select * from NHANVIEN
select * from SANPHAM
select * from HOADON
select * from CTHD
