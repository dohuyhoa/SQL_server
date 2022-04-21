create database Quanlinhanhkhau
go

use Quanlinhanhkhau
go

create table QuanHuyen(
   MaQH int identity(1,1) not null,
   TenQH nvarchar(100)
)
go

create table DuongPho(
   DuongID int not null,
   MaQh int not null,
   TenDuong int not null,
   NgayDuyetTen datetime null
)
go

alter table DuongPho
alter column TenDuong nvarchar(100)
go


create table NhaTrenPho(
   NhaID int not null,
   DuongID int not null,
   ChuHo nvarchar(50) not null,
   DienTich money null
)
go


create clustered index CI_NhaTrenPho_NhaID on NhaTrenPho(NhaID)

create unique nonclustered index UI_QuanHuyen_TenQH on QuanHuyen(TenQH)
 
drop index QuanHuyen.UI_QuanHuyen_TenQH 

alter table NhaTrenPho
add SoNhanKhau int

alter table QuanHuyen
 add constraint PK_QuanHuyen Primary key (MaQH)

alter table DuongPho
 add constraint PK_DuongPho Primary key (DuongID)

alter table NhaTrenPho
 add constraint PK_NhaTrenPho Primary key (NhaID)

alter table NhaTrenPho
 add constraint FK_NhaTrenPho_DuongPho Foreign key (DuongID) references DuongPho(DuongID)

alter table DuongPho
 add constraint FK_DuongPho_QuanHuyen Foreign key (MaQH) references QuanHuyen(MaQH)

alter table DuongPho
add constraint CK_DuongPho_NgayDuyetTen check (NgayDuyetTen between '1945-09-02' and getdate())

alter table DuongPho
drop constraint CK_DuongPho_NgayDuyetTen

insert into QuanHuyen(TenQH)
values
('Ba Dinh'),
('Hoang Mai')
go


select * from QuanHuyen

insert into DuongPho(DuongID,MaQH,TenDuong,NgayDuyetTen)
values
(1,1,'Doi Can','1946-10-19'),
(2,1,'Van Phuc','1998-12-30'),
(3,2,'Giai Toa','1975-09-21')
go

select * from DuongPho

insert into NhaTrenPho(NhaID,DuongID,ChuHo,DienTich,SoNhanKhau)
values
(1,1,'Ha Khanh Toan',100,4),
(2,1,'Le Hong Hai',20,12),
(3,2,'Tran Khanh',40,1)

 update DuongPho set TenDuong = 'Giai Phong' where TenDuong =  'Giai Toa'

create view vw_all_Nha_Tren_Pho
as
select TenQH,TenDuong,NgayDuyetTen,ChuHo,DienTich,SoNhanKhau 
from NhaTrenPho,DuongPho,QuanHuyen
where DuongPho.DuongID = NhaTrenPho.DuongID 
  and DuongPho.MaQH = QuanHuyen.MaQH
  go

select * from vw_all_Nha_Tren_Pho

create view vw_AVG_Nha_Tren_Pho 
as
select TenDuong, AVG(NhaTrenPho.DienTich)'Dien Tich Trung Binh',AVG(NhaTrenPho.SoNhanKhau)'So Nhan Khau TB'
from NhaTrenPho,DuongPho
where DuongPho.DuongID = NhaTrenPho.DuongID 
 group by DuongPho.TenDuong
 
select * from vw_AVG_Nha_Tren_Pho
order by 'Dien Tich Trung Binh','So Nhan Khau TB' asc


create proc sp_NgayQuyetTen_DuongPho
  @NgayDuyet datetime
as
begin
 select DuongPho.NgayDuyetTen,DuongPho.TenDuong,QuanHuyen.TenQH
 from DuongPho,QuanHuyen
 where DuongPho.MaQH = QuanHuyen.MaQH
  and DuongPho.NgayDuyetTen = @NgayDuyet
end

declare @NgayDuyet datetime
select @NgayDuyet = Convert (datetime,'30/12/1998',103)
exec sp_NgayQuyetTen_DuongPho @NgayDuyet 


select * from NhaTrenPho

create trigger [FOR_UPDATE_NHA_TREN_PHO] on NhaTrenPho
for update 
as
begin
 if(select count(SoNhanKhau) from inserted where SoNhanKhau <= 0 ) > 0
 begin
	  print N'So Nhan Khau Yeu Cau >0'
	  rollback transaction
	 end
 end
 go


 update NhaTrenPho set SoNhanKhau = 0 where NhaID =2