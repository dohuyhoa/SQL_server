create database BT1778
go

use Bt1778
go

create table hotel(
	id int primary key identity(1,1),
	hotelName nvarchar(30),
	address nvarchar(300),
	area float,
	owner nvarchar(50)
	)
go


create table room(
	room_no int primary key,
	id_hotel int references hotel(id),
	area float,
	kindOfRoom nvarchar(50),
	floor int
)
go

create table book(
	id int primary key identity(1,1),
	room_no int references room,
	book_date date,
	checkout_date date,
	number_people int,
	price int
)
go

-- Insert database
insert into hotel (hotelName, address, area, owner)
values
('A25', '54 Le Thanh Nghi', '200', 'A'),
('Mix Beutique', '285 Doi Can', '300', 'A'),
('Rose Love', '12 Tran Duy Hung', '50', 'B')
go

insert into hotel (hotelName, address, area, owner)
values
('MuongThanh', 'LinhDam', 200, 'A')
go


drop table hotel
drop table room
drop table book


insert into room(room_no, id_hotel, area, kindOfRoom, floor)
values
(1102, 1, 20, 'NORMAL', 1),
(1001, 1, 15, 'VIP', 2),
(1111, 1, 30, 'VIP', 2),
(2001, 2, 20, 'NORMAL', 1),
(2005, 3, 20, 'VIP', 2)
go	

insert into book (room_no, book_date, checkout_date, price)
values
(1102, '2021-01-15 10:00:00', '2021-01-16 18:00:00', 2),
(1001, '2021-03-02 10:00:00', '2021-03-04 18:00:00', 2),
(1111, '2021-02-05 10:00:00', '2021-02-06 18:00:00', 4),
(2001, '2021-01-15 10:00:00', '2021-01-16 18:00:00', 2),
(2005, '2021-02-15 10:00:00', '2021-02-16 18:00:00', 3),
(1001, '2021-02-15 10:00:00', '2021-02-16 18:00:00', 6),
(1111, '2021-02-15 10:00:00', '2021-02-16 18:00:00', 4)
go

--c1
select hotel.hotelName,hotel.address, room.room_no, room.kindOfRoom, room.floor 
from hotel,room
where hotel.id = room.id_hotel
go
--c2
select hotel.hotelName,hotel.address, room.room_no, room.kindOfRoom, room.floor 
from hotel inner join room on hotel.id = room.id_hotel
go

--thong ke
-all zoom
select hotel.hotelName,hotel.address, room.room_no
from hotel inner join room on hotel.id = room.id_hotel
go
--room_id >5
select hotel.hotelName,hotel.address, room.room_no, room.kindOfRoom, room.floor 
from hotel,room
where hotel.id = room.id_hotel and room.room_no > 5
go




select hotel.hotelName,hotel.address, room.room_no, room.kindOfRoom, room.floor, room.area
from hotel,room
where hotel.id = room.id_hotel and room.area >= 30
go

--thong ke theo ten ks, dia chi,so phong
select hotel.hotelName, hotel.address, room.room_no 
from hotel, room
where hotel.id = room.id_hotel
go

--thong ke theo ten ks, dia chi,so phong co so phong >5
select hotel.hotelName, hotel.address, room.room_no 
from hotel, room
where hotel.id = room.id_hotel and room.room_no > 1111
go

--Thông kê theo dữ liệu : Tên KS, địa chỉ, diện tích phòng lớn nhất
select hotel.hotelName, hotel.address, max(room.area) 'max area room'
from hotel, room
where hotel.id = room.id_hotel 
group by hotel.hotelName, hotel.address
go

--Thông kê theo dữ liệu : Tên KS, địa chỉ, diện tích phòng nhỏ nhất
select hotel.hotelName, hotel.address, min(room.area) 'min area room'
from hotel, room
where hotel.id = room.id_hotel 
group by hotel.hotelName, hotel.address
go

-- Thông kê theo dữ liệu : Tên KS, địa chỉ, tổng diện tích của tất cả các phòng
select hotel.hotelName, hotel.address, sum(room.area) 'total area'
from hotel, room
where hotel.id = room.id_hotel 
group by hotel.hotelName, hotel.address
go

--Thông kê theo dữ liệu : Tên KS, địa chỉ, diện tích trung bình của từng phòng
select hotel.hotelName, hotel.address, round(avg(room.area),2) 'average area'
from hotel, room
where hotel.id = room.id_hotel 
group by hotel.hotelName, hotel.address
go

--Thông kê theo dữ liệu : Tên KS, địa chỉ, khách sạn ko có phòng nào.
insert into hotel (hotelName, address, area, owner)
values
('Bolevart', '01 TranVanDu', '120', 'A')
go

select *from hotel
go

insert into room(room_no, id_hotel, area, kindOfRoom, floor)
values
(3, 4, 25, 'Luxury', 6),
go



select hotel.hotelName, hotel.address, count(room.id_hotel) 'No Room'
from hotel, room
where hotel.id = room.id_hotel 
group by hotel.hotelName, hotel.address
having count(room.id_hotel) = 0
go

select hotel.hotelName, hotel.address, count(room.id_hotel) 'No Room'
from hotel left join room on hotel.id = room.id_hotel 
group by hotel.hotelName, hotel.address
having count(room.id_hotel) = 0
go