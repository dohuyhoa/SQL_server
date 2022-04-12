create database BT1776
go

use BT1776
go

create table hang_hoa(
	id int primary key identity(1,1),
	tenMatHang nvarchar(100),
	nhaSanXuat nvarchar(50),
	xuatXu nvarchar(30),
	giaNhap int,
	giaBan int,
	ngaySanXuat date
)
go

insert into hang_hoa(tenMatHang,nhaSanXuat,xuatXu,giaNhap,giaBan,ngaySanXuat)
values
('Bphone 3','Bphone','Viet Nam',1000,1200,'2018-08-12'),
('Bphone 4','Bphone','Viet Nam',300,400,'2019-09-13'),
('Iphone 5','Iphone','China',1600,1800,'2014-10-14'),
('Iphone 6','Iphone','China',1700,1900,'2015-11-15'),
('Iphone 7','Iphone','China',1800,2000,'2016-12-16'),
('Iphone 8','Iphone','China',1800,2100,'2017-01-17'),
('Iphone 8 Pro','Iphone','China',2000,2300,'2018-02-18'),
('Iphone X','Iphone','China',2500,3000,'2019-03-19'),
('Iphone X Pro','Iphone','China',2400,2900,'2020-04-20'),
('Iphone XI','Iphone','China',2800,3500,'2021-05-21')
go

-- Thiết kế bảng bán hàng gồm các column sau
-- id đơn hàng kiểu số nguyên, khóa chính, tự tăng
-- id_hanghoa khóa ngoai liên kết vs khóa id của bang hàng hóa
-- chú thich : dùng ghi lại cho mỗi đơn hàng
-- ngày bán : kiểu date
-- số lượng

-- ->Thực hiện nhập 10 bản ghi cho bảng này
create table ban_hang(
	id_donHang int primary key identity(1,1),
	id int references hang_hoa(id),
	chuThich nvarchar(500),
	ngayBan date,
	soLuong int
)
go

insert into ban_hang(id,chuThich,ngayBan,soLuong)
values
(1,'new box','2012-12-12',10),
(2,'like new','2013-12-01',8),
(3,'new box','2014-12-12',10),
(4,'full box','2015-6-12',5),
(5,'new box','2016-8-12',10),
(6,'new box','2017-7-21',10),
(2,'like new 98%','2018-3-12',8),
(7,'new box','2019-6-4',8),
(8,'new box','2020-12-12',15),
(10,'new box','2021-10-10',20)
go

insert into ban_hang(id,chuThich,ngayBan,soLuong)
values
(7,'new box','2012-1-1',3),
(5,'like new','2019-12-01',7)
go


select * from hang_hoa
go

select * from ban_hang
go

drop table ban_hang
go

drop table hang_hoa
go

--liet ke all don hang duoc ban ra

select hang_hoa.id,  hang_hoa.tenMatHang, hang_hoa.nhaSanXuat, hang_hoa.giaBan, ban_hang.ngayBan, ban_hang.soLuong
from hang_hoa, ban_hang
where hang_hoa.id = ban_hang.id
go
--view
create view view_banhang_list
as 
select hang_hoa.id, hang_hoa.tenMatHang,hang_hoa.nhaSanXuat, hang_hoa.giaBan, ban_hang.ngayBan, ban_hang.soLuong
from hang_hoa, ban_hang
where hang_hoa.id = ban_hang.id
go

drop view view_banhang_list

select * from view_banhang_list

--use inner join
select hang_hoa.id, hang_hoa.tenMatHang,hang_hoa.nhaSanXuat, hang_hoa.giaBan, ban_hang.ngayBan, ban_hang.soLuong
from hang_hoa inner join ban_hang on  hang_hoa.id = ban_hang.id
go

--tao view

-- xuat ra sp ban co xuat xu Viet nam
-----use select
select hang_hoa.id, hang_hoa.tenMatHang,hang_hoa.nhaSanXuat, hang_hoa.xuatXu
from hang_hoa, ban_hang
where hang_hoa.id = ban_hang.id and hang_hoa.xuatXu = 'Viet Nam'
go

create view view_banhang_vietnam
as
select hang_hoa.id, hang_hoa.tenMatHang, hang_hoa.nhaSanXuat,hang_hoa.xuatXu, hang_hoa.giaBan, ban_hang.ngayBan, ban_hang.soLuong
from hang_hoa inner join ban_hang on  hang_hoa.id = ban_hang.id
where hang_hoa.xuatXu = 'Viet Nam'
go

drop view view_banhang_vietnam
go

select * from view_banhang_vietnam
go

--tinh tong gia ban duoc cho ca mat hang
----use select
select  hang_hoa.id , hang_hoa.tenMatHang, hang_hoa.nhaSanXuat, ban_hang.soLuong, sum(ban_hang.soLuong) 'Tong so luong', sum(ban_hang.soLuong*hang_hoa.giaBan) 'Tong gia ban'
from hang_hoa, ban_hang
where  ban_hang.id =  hang_hoa.id 
group by  hang_hoa.id , hang_hoa.tenMatHang, hang_hoa.nhaSanXuat,ban_hang.soLuong
go


----use view
create view view_total_giaban
as
select hang_hoa.id, hang_hoa.tenMatHang, hang_hoa.nhaSanXuat, hang_hoa.xuatXu, hang_hoa.giaBan, ban_hang.soLuong,sum(ban_hang.soLuong*hang_hoa.giaBan)'total'
from hang_hoa,ban_hang
where  ban_hang.id = hang_hoa.id 
group by hang_hoa.id,hang_hoa.tenMatHang,hang_hoa.nhaSanXuat, hang_hoa.xuatXu, hang_hoa.giaBan, ban_hang.soLuong
go

select * from view_total_giaban
go
select * from hang_hoa
go
select * from ban_hang
go


drop view view_total_giaban
go

--use proc
create proc proc_view_banhang_vietnam
@origin nvarchar(20)
as
begin
	select hang_hoa.id, hang_hoa.tenMatHang, hang_hoa.nhaSanXuat,hang_hoa.xuatXu, hang_hoa.giaBan, ban_hang.ngayBan, ban_hang.soLuong
	from hang_hoa inner join ban_hang on  hang_hoa.id = ban_hang.id
	where hang_hoa.xuatXu = 'viet Nam'
end

drop proc proc_view_banhang_vietnam
go

exec proc_view_banhang_vietnam 'Viet Nam'
