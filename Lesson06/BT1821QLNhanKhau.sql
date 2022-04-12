create database BT1821QLNhanKhau
go

use BT1821QLNhanKhau
go

create table QuanHuyen(
	MaQH int not null identity(1,1),
	TenQH nvarchar(100)
)
go

create table DuongPho(
	DuongID int not null,
	MaQH int not null,
	TenDuong nvarchar(max) not null,
	NgayDuyetTen datetime null,
)
go

create table NhaTrenPho (
	NhaID int not null,
	DuongID int not null,
	ChuHo nvarchar(50) null,
	DienTich money null
)
go

create index CI_NhaTrenPho_NhaID on NhaTrenPho (NhaID)
go

create index UI_QuanHuyen_TenQH on QuanHuyen (TenQH)
go

alter table NhaTrenPho
add SoNhanKhau int
go

--primary key
alter table QuanHuyen
add constraint PK_QuanHuyen primary key (MaQH)
go

alter table DuongPho
add constraint PK_DuongPho primary key (DuongID)
go

alter table NhaTrenPho
add constraint PK_NhaTenPho primary key (NhaID)
go


---add foreign key
alter table NhaTrenPho
add constraint FK_NhaTrenPho_DuongPho foreign key (DuongID) references DuongPho(DuongID)
go

alter table DuongPho
add constraint FK_DuongPho_QuanHuyen foreign key (MaQH) references QuanHuyen (MaQH)
go

--add check
alter table DuongPho
add constraint CK_DuongPho_NgayDuyetTen check (NgayDuyetTen between '1945-09-02' and getdate())
go



insert into QuanHuyen (TenQH)
values
('Ba Dinh'),
('Hoang Mai'),
('Hoan Kiem'),
('Cau Giay'),
('Thanh Xuan')
go

insert into DuongPho (DuongID, MaQH, TenDuong, NgayDuyetTen)
values
(1,1, 'Doi Can', '1946-10-19'),
(2,1, 'Van Phuci', '1998-12-30'),
(3,1, 'Giai Toa', '1975-09-21'),
(4,2, 'Ton Duc Thang', '1980-02-02'),
(5,3, 'Dinh Le', '1982-02-02'),
(6,3, 'Trang Tien', '1972-05-5'),
(7,4, 'Com Vong', '1980-02-02'),
(8,4, 'Duy  Tan', '1982-02-02'),
(9,5, 'Truong Chinh', '1972-05-5')
go

insert into NhaTrenPho (NhaID, DuongID,ChuHo,DienTich, SoNhanKhau)
values
(1,1,'Ha Khanh Toan' , 100, 4),
(2,1,'Le Hong Hai' , 20, 12),
(3,2,'Tran Khanh' , 40,1),
(4,3,'Nguyen Son' , 110, 6),
(5,4,'Luu Bi' , 30, 3),
(7,5,'L Tran  Loi' , 40, 5),
(8,6,'Nguyen Duy Ta' , 45, 6)
go


select * from QuanHuyen
select * from NhaTrenPho
select * from DuongPho

drop table QuanHuyen
drop table DuongPho
drop table NhaTrenPho

select * from NhaTrenPho

-- 6. query Operation
update DuongPho set TenDuong = 'Giai Phong' where TenDuong = 'Giai Toa'
go

-- 7 View
create view vw_all_Nha_Tren_Pho 
as 
select top 3 QuanHuyen.TenQH, DuongPho.TenDuong, DuongPho.NgayDuyetTen,  NhaTrenPho.ChuHo, NhaTrenPho.DienTich, NhaTrenPho.SoNhanKhau
from QuanHuyen, NhaTrenPho, DuongPho
where NhaTrenPho.DuongID = DuongPho.DuongID and DuongPho.MaQH = QuanHuyen.MaQH
go

select * from vw_all_Nha_Tren_Pho

-- 8.View 2
create view vw_AVG_NhaTrenPho
as 
select DuongPho.TenDuong, avg(NhaTrenPho.DienTich) ' Dien tich TB', avg(NhaTrenPho.SoNhanKhau) 'So Nhan Khau TB '
from QuanHuyen, NhaTrenPho, DuongPho
where NhaTrenPho.DuongID = DuongPho.DuongID and DuongPho.MaQH = QuanHuyen.MaQH
group by  DuongPho.TenDuong
go

---chua lam dk
select * from vw_AVG_NhaTrenPho
order by Dien tich TB desc , avg(NhaTrenPho.SoNhanKhau)

create proc sp_NGayDuyetTen_DuongPho
@NgayDuyet date
as
begin
	select DuongPho.NgayDuyetTen , DuongPho.TenDuong, QuanHuyen.TenQH
	from QuanHuyen, DuongPho
	where DuongPho.MaQH = QuanHuyen.MaQH and DuongPho.NgayDuyetTen = @NgayDuyet
end
go

declare @NgayDuyet date
select @NgayDuyet = convert(date, '30/12/1998', 103)
exec  sp_NGayDuyetTen_DuongPho @NgayDuyet


create trigger for_update_nha_Tren_pho on NhaTrenPho
for update
as
begin
	if(select count(*) from inserted where SoNhanKhau <=0) >0
	begin
		print N'Yeu cap update SoNhanKhau phai lon hon 0'
		rollback transaction
		end
end
go

update NhaTrenPho set SonhanKhau = 0 where NhaID = 3

create trigger InsteadOf_delete_DuongPho on DuongPho
instead of delete
as
begin
	delete from QuanHuyen where MaQH in (select DuongID from deleted)
	delete from DuongPho where DuongID in (select DuongID from deleted)
end
go

delete from DuongPho where DuongId =9