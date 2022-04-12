create database BT2243
go

use BT2243
go

create table trongtai(
	id_trongtai int primary key  identity(1,1),
	fullname nvarchar(50) not null,
	address nvarchar(200) not null,
	level float,
	exp date
)
go



create table doibong(
	id_doibong int primary key identity(1,1),
	tendoibong nvarchar(50),
	sanchunha nvarchar(100),
	huanluyenvien nvarchar(50)
)
go

create table history(
	id int primary key identity(1,1),
	id_trongtai int references trongtai (id_trongtai),
	giaidau nvarchar(100) not null,
	ngaybat date,
	rate float,
	id_club_1 int references doibong (id_doibong),
	id_club_2 int references doibong (id_doibong),
	note nvarchar(500)
)
go

create table cauthu(
	id_cauthu int primary key identity(1,1),
	fullname nvarchar(50),
	birthday date,
	salary money,
	ngaybatdauda date
)
go
create table thongtindoibongcauthu(
	id_club int references doibong(id_doibong),
	id_player int  references cauthu(id_cauthu),
	ngaythamgia date
)
go
 


--insert cho bang
insert into trongtai(fullname, address, level, exp)
values
('Van Mui', 'Viet Nam', 2, '2000-9-9'),
('Donas Murphy', 'Ba Lan', 2, '2005-8-8'),
('Quang Toan', 'Viet Nam', 3, '1998-7-7'),
('Furikitai', 'Japan', 4, '2010-6-6'),
('John Murtath', 'England', 4, '2011-11-11'),
('Ba Nguyen', 'China', 1, '2001-12-12')
go

insert into doibong (tendoibong, sanchunha, huanluyenvien)
values
('Italia', 'Turin','Peirlo'),
('England', 'Arena','Saugate'),
('Brazin', 'Saul Paulo','Pele'),
('Japan', 'TokyoST','Suuki Honda'),
('American', 'Clifor','Philip Hulp')
go

insert into history (id_trongtai, giaidau,ngaybat,rate, id_club_1, id_club_2)
values
(1, 'WorldCup', '2000-3-12', 8,1,2),
(2, 'WorldCup', '2000-3-17', 9,3,4),
(3, 'WorldCup', '2000-3-16', 7,4,5),
(6, 'WorldCup', '2000-3-14', 6,1,3),
(4, 'WorldCup', '2000-3-9', 7,2,4),
(5, 'WorldCup', '2000-3-9', 7,1,4),
(2, 'WorldCup', '2000-3-9', 5,2,5)
go

insert into cauthu(fullname, birthday,salary, ngaybatdauda)
values
('Mess1', '1993-1-1', 200000,'2015-1-2'),
('Mess2', '1994-1-3', 220000,'2017-1-3'),
('Mess3', '1991-1-4', 200000,'2013-1-4'),
('Mess4', '1995-1-1', 200000,'2015-1-6'),
('Mess4', '1996-1-1', 200000,'2011-7-6')
go
insert into cauthu(fullname, birthday,salary, ngaybatdauda)
values
('Ronaldo 1', '1998-1-1', 200000,'2015-11-2'),
('Salah', '2000-1-3', 220000,'2017-12-3'),
('Kante', '1999-1-4', 200000,'2013-4-4'),
('Ramos', '1996-1-1', 200000,'2015-6-6'),
('Bruno', '1997-1-1', 200000,'2011-8-6')
go

insert into thongtindoibongcauthu(id_club, id_player, ngaythamgia)
values
(1, 1 ,'1999-12-12'),
(2,2, '1999-12-1'),
(3,3, '1999-12-2'),
(4,4, '1999-12-3'),
(5,5, '1999-12-3')
go

insert into thongtindoibongcauthu(id_club, id_player, ngaythamgia)
values
(1, 6 ,'1999-1-12'),
(2, 7, '1999-11-1'),
(2, 8, '1999-2-2'),
(4, 9, '1999-3-3'),
(5, 10, '1999-4-3')
go


select *from trongtai
select *from doibong
select*from cauthu
select *from thongtindoibongcauthu
select *from history

--Xem thông tin lịch sử bắt của trọng tài - tên trọng tài, level, exp, giải bóng, đội 1, đội 2
----------(Viết truy vấn và tạo view)
select trongtai.fullname, trongtai.level, trongtai.exp, history.giaidau, history.id_club_1, history.id_club_2
from history, trongtai
where history.id_trongtai = trongtai.id_trongtai
go
---------------tao view
create view view_lichsubat_trongtai 
as
select trongtai.fullname, trongtai.level, trongtai.exp, history.giaidau, history.id_club_1, history.id_club_2
from history, trongtai
where history.id_trongtai = trongtai.id_trongtai
go

-----sua lai
create view view_lichsubat_trongtai_test
as
select trongtai.fullname, trongtai.level, trongtai.exp, history.giaidau, history.id_club_1, DB1.tendoibong  'Doi bong 1',  history.id_club_2, DB2.tendoibong 'Doi bong 2'
from history, trongtai, doibong DB1, doibong DB2
where history.id_trongtai = trongtai.id_trongtai
			and DB1.id_doibong = history.id_club_1
			and DB2.id_doibong = history.id_club_2
go


select * from view_lichsubat_trongtai 
go
select * from view_lichsubat_trongtai _test
go

--Xem danh sach cau thu cua 1 doi bong
---,ten doi bong, id_cau thu, fullname,
select doibong.tendoibong, cauthu.fullname, cauthu.birthday
from doibong, cauthu, thongtindoibongcauthu
where thongtindoibongcauthu.id_club = doibong.id_doibong and thongtindoibongcauthu.id_player = cauthu.id_cauthu and doibong.id_doibong = 4
----view
create view view_danhsach_cauthu_ofdoibong
as 
select doibong.tendoibong, cauthu.fullname, cauthu.birthday
from doibong, cauthu, thongtindoibongcauthu
where thongtindoibongcauthu.id_club = doibong.id_doibong and thongtindoibongcauthu.id_player = cauthu.id_cauthu and doibong.id_doibong = 4
go

select * from view_danhsach_cauthu_ofdoibong

--5) Xem thông tin lịch sử bắt của trọng tài - tên trọng tài, level, exp, giải bóng, đội 1, đội 2 -> Tìm theo tên 1 đội bóng
--Viết proc có 1 tham số đầu vào là id đội bóng.
select trongtai.fullname, trongtai.level,  history.giaidau, history.id_club_1
from doibong, trongtai, thongtindoibongcauthu, history
where history.id_trongtai = trongtai.id_trongtai and history.id_club_1 = doibong.id_doibong and doibong.tendoibong = 'England' 
group by trongtai.fullname, trongtai.level,  history.giaidau, history.id_club_1
go


--proc
alter proc proc_trongtai
@doibongID int
as
begin
	select trongtai.fullname, trongtai.level,  history.giaidau, history.id_club_1, history.id_club_2
	from doibong, trongtai, history
	where history.id_trongtai = trongtai.id_trongtai and history.id_club_1 = doibong.id_doibong  and history.id_club_2 = doibong.id_doibong 
	and history.id_club_1 = @doibongID  or history.id_club_2 = @doibongID 
	group by trongtai.fullname, trongtai.level,  history.giaidau,  history.id_club_1, history.id_club_2
end
go

exec proc_trongtai 2

---code mau-----
select TrongTai.fullname, TrongTai.level, TrongTai.exp, LichSu.giaidau, LichSu.id_club_1, DB1.ten 'Doi Bong 1', LichSu.id_club_2, DB2.ten 'Doi Bong 2'
from TrongTai, LichSu, DoiBong DB1, DoiBong DB2
where TrongTai.id = LichSu.trongtai_id
	and DB1.id = LichSu.id_club_1
	and DB2.id = LichSu.id_club_2

select TrongTai.fullname, TrongTai.level, TrongTai.exp, LichSu.giaidau, DB1.ten 'Doi Bong 1', DB2.ten 'Doi Bong 2'
from TrongTai, LichSu, DoiBong DB1, DoiBong DB2
where TrongTai.id = LichSu.trongtai_id
	and DB1.id = LichSu.id_club_1
	and DB2.id = LichSu.id_club_2