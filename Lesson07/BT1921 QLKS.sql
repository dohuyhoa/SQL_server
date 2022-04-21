-- Tao CSDL
create database BT2781
go

-- Kich hoat CSDL
use BT2781
go

-- Tao Tables
create table Roles (
	id int primary key identity(1,1),
	rolename nvarchar(50)
)
go

create table Users (
	id int primary key identity(1,1),
	fullname nvarchar(50),
	birthday date,
	gender nvarchar(20),
	email nvarchar(150),
	phone_number nvarchar(20),
	address nvarchar(200),
	role_id int references Roles (id)
)
go

create table Room (
	id int primary key identity(1,1),
	room_no nvarchar(20) not null,
	type nvarchar(20),
	max_num int,
	price float
)
go

create table Booking (
	id int primary key identity(1,1),
	staff_id int references Users (id),
	customer_id int references Users (id),
	checkin datetime,
	checkout datetime
)
go

create table BookingDetail (
	booking_id int references Booking (id),
	room_id int references Room (id),
	price float,
	unit float,
	primary key (booking_id, room_id)
)
go

create table UserDetail (
	booking_id int references Booking (id),
	room_id int references Room (id),
	customer_id int references Users (id),
	primary key (booking_id, room_id, customer_id)
)

create table Category (
	id int primary key identity(1,1),
	name nvarchar(50)
)
go

create table Product (
	id int primary key identity(1,1),
	category_id int references Category (id),
	title nvarchar(150),
	thumbnail nvarchar(500),
	description ntext,
	price float,
	amount int
)
go

create table Services (
	id int primary key identity(1,1),
	booking_id int references Booking (id),
	customer_id int references Users (id),
	product_id int references Product (id),
	price float,
	amount int,
	buy_date datetime
)
go

-- Insert Data
insert into Roles (rolename)
values
('Admin'),
('Staff'),
('Customer')
go

insert into Users (fullname, email, phone_number, role_id)
values
('Admin', 'admin@gmail.com', '233423423', 1),
('Staff', 'staff@gmail.com', '345345435', 2),
('TRAN VAN A', 'a@gmail.com', '233423423', 3),
('TRAN VAN B', 'b@gmail.com', '567567567', 3),
('TRAN VAN C', 'c@gmail.com', '233423423', 3)
go

insert into Category (name)
values
('Cafe'),
('Sinh To'),
('Nuoc Ngot')
go

insert into Product (title, price, category_id)
values
('Cafe Nau', 25000, 1),
('Cafe Da', 25000, 1),
('RedBull', 15000, 3),
('Sinh To Bo', 55000, 2)
go

insert into Room (room_no, price, type, max_num)
values
('R001', 1000, 'NORMAL', 2),
('R002', 2000, 'VIP', 2),
('R003', 3000, 'DIAMON', 2),
('R004', 1200, 'NORMAL', 2),
('R005', 1500, 'NORMAL', 2),
('R006', 1800, 'VIP', 2)
go

insert into Booking (staff_id, customer_id, checkin, checkout)
values
(2, 3, '2022-02-18', '2022-02-25'),
(2, 3, '2022-03-02', '2022-03-06'),
(2, 4, '2022-02-22', '2022-02-25')
go

insert into UserDetail (booking_id, customer_id, room_id)
values
(1, 3, 1),
(1, 4, 1),
(1, 5, 2),
(2, 3, 2),
(2, 5, 2),
(3, 4, 3)
go

insert into BookingDetail (booking_id, room_id, price, unit)
values
(1, 1, 1000, 7),
(1, 2, 2000, 7),
(2, 2, 2000, 4),
(3, 3, 3000, 3)
go

insert into Services (booking_id, customer_id, product_id, price, amount, buy_date)
values
(1, 3, 1, 25000, 2, '2022-02-20'),
(1, 4, 2, 25000, 1, '2022-02-22'),
(2, 5, 3, 15000, 2, '2022-02-22')
go

-- Xem thông tin khách hàng đã tới khách sạn gồm: tên (User), sđt (User), ngày checkin (Booking), checkout (Booking), mã phòng (Room) tìm theo customer_id -> Sử dụng proc
create proc proc_view_customer
	@customerId int
as
begin
	select Users.id, Users.fullname, Users.phone_number, Booking.checkin, Booking.checkout, Room.room_no
	from Users, Booking, Room, UserDetail
	where Room.id = UserDetail.room_id
		and UserDetail.booking_id = Booking.id
		and UserDetail.customer_id = Users.id
		and Users.id = @customerId
end

exec proc_view_customer 3


create proc proc_view_customer_by_booking
	@bookingId int
as
begin
	select Users.id, Users.fullname, Users.phone_number, Booking.checkin, Booking.checkout, Room.room_no
	from Users, Booking, Room, UserDetail
	where Room.id = UserDetail.room_id
		and UserDetail.booking_id = Booking.id
		and UserDetail.customer_id = Users.id
		and Booking.id = @bookingId
end

exec proc_view_customer_by_booking 1

-- Tính tổng tiền sử dụng đặt phòng theo booking_id
create view vw_tongtienroom
as
select Booking.id, Booking.checkin, Booking.checkout, sum(BookingDetail.price * BookingDetail.unit) 'TongTienRoom'
from Booking, BookingDetail
where Booking.id = BookingDetail.booking_id
group by Booking.id, Booking.checkin, Booking.checkout

create view vw_tongtienservice
as
select Booking.id, Booking.checkin, Booking.checkout, sum(Services.price * Services.amount) 'TongTienDichVu'
from Booking, Services
where Booking.id = Services.booking_id
group by Booking.id, Booking.checkin, Booking.checkout

-- Tien Dat Phong, Tien Dich Vu, Tong Chi Phi
select A.id, A.checkin, A.checkout, A.TongTienRoom, B.TongTienDichVu, A.TongTienRoom + B.TongTienDichVu 'TongTien'
from vw_tongtienroom A, vw_tongtienservice B
where A.id = B.id
go
