create database BT1788orBT2123Hotel
go

use BT1788orBT2123Hotel
go

create table Hotel (
	id int primary key identity(1,1),
	hotelName nvarchar(100),
	address nvarchar(300),
	hotel_area int,
	owner_hotel  nvarchar(50),
)
go

create table Room (
	room_no  nvarchar(20) primary key,
	id_hotel int references Hotel (id),
	room_area int,
	room_type  nvarchar(100),
	floor int
)
go

create table Book (
	id int primary key identity(1,1),
	room_no nvarchar(20) references Room (room_no),
	checkin_date date,
	checkout_date date,
	contain_persons int,
	price money
)
go
---insert data
insert into Hotel (hotelName, hotel_area, owner_hotel)
values
('Rosa Hotel', 130, 'Kha Ba'),
('Home Hotel', 150, 'Cao Tang'),
('Mix Hotel', 100, 'Luc Kiem')
go

insert into Room (room_no,id_hotel, room_area, room_type, floor)
values
('P2201', 1,30, 'Vip', 2),
('P2202', 1,25, 'Pro', 2),
('P3301', 1,30, 'Couple', 3),
('T2201', 2,25, 'Luxury', 2),
('T2202', 2,22, 'Hoi An', 3),
('KS2201', 2, 32, 'Lang Man', 4),
('KS2202', 2, 30, 'Uyen Uong', 4)
go

insert into Book (room_no, checkin_date, checkout_date, contain_persons, price)
values
('P2201', '2021-11-11', '2021-11-13', 2, 3000000),
('P2202', '2021-11-11', '2021-11-13', 2, 3400000),
('P2201', '2021-11-12', '2021-11-14', 2, 2200000),
('P3301', '2021-11-13', '2021-11-15', 1, 1800000),
('T2201', '2021-11-14', '2021-11-17', 2, 2500000),
('T2202', '2021-11-15', '2021-11-19', 3, 5000000),
('KS2201', '2021-11-20', '2021-11-23', 2, 1700000),
('KS2202', '2021-11-11', '2021-11-25', 3, 15000000)
go


-- 2) Hiển thị thông  tin khách sạn gồm các trường : Tên KS, địa chỉ, mã phòng, loại phòng, tầng

--- --2.1) Tất cả các dữ liệu
select Hotel.hotelName, Hotel.address, Room.room_no, Room.room_type, Room.floor
from Hotel, Room
where Hotel.id = Room.id_hotel
go

 --   2.2) Chỉ những phòng có diện tích 30 m2 trở lên
 select Hotel.hotelName, Hotel.address, Room.room_no, Room.room_type, Room.floor, Room.room_area
from Hotel, Room
where Hotel.id = Room.id_hotel and Room.room_area >= 30
go


---3) Thống kê theo dữ liệu : Tên KS, địa chỉ, số phòng
---- Tất cả
select Hotel.hotelName as 'Ten Khach San' , Hotel.address, count(Room.room_no) as 'So phong'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address

   -- - Số phòng > 5
  select Hotel.hotelName as 'Ten Khach San' , Hotel.address, count(Room.room_no) as 'So phong'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address 
having  count(Room.room_no) > 1


--4) Thông kê theo dữ liệu : Tên KS, địa chỉ, diện tích phòng lớn nhất
select Hotel.hotelName as 'Ten Khach San' , Hotel.address, max(Room.room_area) as  'Max-area-room'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address 


-- 5) Thông kê theo dữ liệu : Tên KS, địa chỉ, diện tích phòng nhỏ nhất
select Hotel.hotelName as 'Ten Khach San' , Hotel.address, min(Room.room_area) as  'Min-area-room'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address 
go

-- 6) Thông kê theo dữ liệu : Tên KS, địa chỉ, tổng diện tích của tất cả các phòng
select Hotel.hotelName as 'Ten Khach San' , Hotel.address, sum(Room.room_area) as  'Total-area-room'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address 

-- 7) Thông kê theo dữ liệu : Tên KS, địa chỉ, diện tích trung bình của từng phòng
select Hotel.hotelName as 'Ten Khach San' , Hotel.address, avg(Room.room_area) as  'Avg-area-room'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address 

-- 8) Thông kê theo dữ liệu : Tên KS, địa chỉ, khách sạn ko có phòng nào.
select Hotel.hotelName as 'Ten Khach San' , Hotel.address, count(Room.room_area) as  'Null Room'
from Hotel left join Room on Hotel.id = Room.id_hotel 
group by Hotel.hotelName, Hotel.address 
having count(Room.room_area) = 0
go