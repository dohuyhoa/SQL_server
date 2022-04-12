create database BT1825
go

 use BT1825
 go

 create table BaiDoXe(
	tenbai nvarchar(100),
	mabaidoxe int not null primary key,
	diachi nvarchar(300)
 )
 go

 create table  ChuSoHuu(
	chusohuu_id int primary key,
	ten nvarchar(50),
	socmnd int,
	diachi nvarchar(300)
 )
 go

 create table ThongTinGui(
	tenxe nvarchar(50),
	biensoxe nvarchar(20),
	mabaidoxe int references BaiDoXe (mabaidoxe),
	ngayguixe date,
	ngaylayxe date,
	chiphi int,
	chusohuu_id int references ChuSoHuu (chusohuu_id)
 )
 go

 --insert data into table
 insert into BaiDoXe (tenbai,mabaidoxe, diachi)
 values
 ('BV Bach Mai', 101, 'Bach Mai'),
 ('DH Xay Dung', 102, '55 Giai Phong'),
 ('Cho Mo', 103, 'Minh Khai')
 go

 insert into ChuSoHuu(chusohuu_id,ten,socmnd,diachi)
 values
 (1122, 'Kha Banh', 111111, 'Bac Ninh' ),
 (3322, 'Quyet Coi', 12345, 'Ninh Binh' ),
 (4422, 'Luu Bi', 33333, 'Bac Giang' )
 go

 drop table BaiDoXe
  drop table ChuSoHuu
   drop table ThongTinGui

 insert into ThongTinGui(tenxe, biensoxe, mabaidoxe, ngayguixe, ngaylayxe, chiphi, chusohuu_id)
values
('Honda Dream', '99H8888', 101, '2022-10-01', '2022-10-10', 50000, 1122),
('Honda Civic', '99H6666', 101, '2022-11-02', '2022-11-12', 400000, 1122),
('Honda City', '98H8888', 101, '2022-08-06', '2022-08-12', 600000, 3322),
('Camry 2.0', '35A6688', 102, '2022-01-01', '2022-01-10', 450000, 4422),
('BMW X5', '98H0055', 103, '2022-5-5', '2022-5-10', 250000, 4422),
('Wave 110', '98H1111', 103, '2022-10-01', '2022-10-10', 2000, 4422)
 go

 select * from BaiDoXe
 select * from ChuSoHuu
  select * from ThongTinGui

  -- Hiển thị thông tin người gửi xe (số cmtnd, tên, tên bãi đỗ xe, biển số xe)
  select ChuSoHuu.socmnd, ChuSoHuu.ten, BaiDoXe.tenbai, ThongTinGui.biensoxe
  from ChuSoHuu, BaiDoXe,  ThongTinGui
  where ThongTinGui.mabaidoxe =  BaiDoXe.mabaidoxe and ThongTinGui.chusohuu_id = ChuSoHuu.chusohuu_id
  go


--Tạo Stores

-- Đếm số lượt gửi xe của 1 khách hàng theo id_chusohuu
  select ChuSoHuu.socmnd, ChuSoHuu.ten, count(ChuSoHuu.chusohuu_id) 'so luot gui xe'
  from ChuSoHuu, BaiDoXe,  ThongTinGui
  where ThongTinGui.mabaidoxe =  BaiDoXe.mabaidoxe and ThongTinGui.chusohuu_id = ChuSoHuu.chusohuu_id
  group by  ChuSoHuu.socmnd, ChuSoHuu.ten
  go


-- Tính tổng chi phí gửi xe của 1 khách hàng theo id chủ sở hữu
  select ChuSoHuu.socmnd, ChuSoHuu.ten, sum(ThongTinGui.chiphi) 'Tong chi phi'
  from ChuSoHuu, BaiDoXe,  ThongTinGui
  where ThongTinGui.mabaidoxe =  BaiDoXe.mabaidoxe and ThongTinGui.chusohuu_id = ChuSoHuu.chusohuu_id
  group by  ChuSoHuu.socmnd, ChuSoHuu.ten
  go


-- Kiểm tra chủ sở hữu xe có đang gửi xe hay không -> In thông tin -> số CMTND, tên, tên bãi đỗ xe, biển số xe
create proc proc_check_guixe
@id_chusohuu int
as
begin
	select ChuSoHuu.chusohuu_id ,ChuSoHuu.socmnd, ChuSoHuu.ten, BaiDoXe.tenbai, ThongTinGui.biensoxe
	 from ChuSoHuu, BaiDoXe,  ThongTinGui
	where ThongTinGui.mabaidoxe =  BaiDoXe.mabaidoxe and ThongTinGui.chusohuu_id = ChuSoHuu.chusohuu_id and ChuSoHuu.chusohuu_id = @id_chusohuu 
end
go



exec  proc_check_guixe 1122
go

--Hiển thị tất cả các xe mà id chủ sở hữu đã từng gửi xe -> In Bãi đỗ xe, biển số xe.
create proc proc_chusohuu_guixe
@chusohuu_ID int
as
begin
	select ChuSoHuu.chusohuu_id, ChuSoHuu.ten, BaiDoXe.tenbai, ThongTinGui.biensoxe
	 from ChuSoHuu, BaiDoXe,  ThongTinGui
	where ThongTinGui.mabaidoxe =  BaiDoXe.mabaidoxe and ThongTinGui.chusohuu_id = ChuSoHuu.chusohuu_id and @chusohuu_ID = ChuSoHuu.chusohuu_id
end
go

exec  proc_chusohuu_guixe 1122
exec  proc_chusohuu_guixe 3322
exec  proc_chusohuu_guixe 4422