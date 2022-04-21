-- Tao CSDL
create database BT2899
go

-- Kich hoat CSDL
use BT2899
go

-- Tao Tables
create table customer (
	id int primary key identity(1,1),
	fullname nvarchar(50),
	birthday date,
	phone nvarchar(20),
	email nvarchar(150),
	point int default 0
)
go

create table places (
	id int primary key identity(1,1),
	title nvarchar(200),
	address nvarchar(200)
)
go

create table tour (
	id int primary key identity(1,1),
	place_id int references places (id),
	startdate datetime,
	enddate datetime,
	price float
)
go

create table booking (
	tour_id int references tour (id),
	customer_id int references customer (id),
	booking datetime
)
go

-- insert data
insert into places (title, address)
values
('A', 'Dia Chi A'),
('B', 'Dia Chi B'),
('C', 'Dia Chi C'),
('D', 'Dia Chi D'),
('E', 'Dia Chi E')
go

insert into tour (place_id, startdate, enddate, price)
values
(1, '2022-02-12', '2022-02-14', 2000000),
(2, '2022-02-15', '2022-02-18', 3000000),
(3, '2022-02-16', '2022-02-20', 5000000)
go

insert into customer (fullname, email, phone, birthday, point)
values
('TRAN VAN A', 'a@gmail.com', '324234', '1998-02-19', 10),
('TRAN VAN B', 'b@gmail.com', '324234', '1998-06-29', 10),
('TRAN VAN C', 'c@gmail.com', '324234', '1998-08-19', 10),
('TRAN VAN D', 'd@gmail.com', '324234', '1998-07-15', 10),
('TRAN VAN E', 'e@gmail.com', '324234', '1998-11-23', 10)
go

insert into booking (tour_id, customer_id, booking)
values
(1, 1, '2022-02-10'),
(1, 2, '2022-02-11'),
(2, 3, '2022-02-10'),
(2, 4, '2022-02-12'),
(1, 5, '2022-02-15')
go

---------------------------------
-- Xem danh sách người đi theo 1 tour -> viết proc tìm theo tour_id
---- Dia danh (places), price (tour), startdate (tour), enddate (tour), fullname (customer), phone (customer)
create proc proc_view_customer
	@tourId int
as
begin
	select places.title, tour.price, tour.startdate, tour.enddate, customer.fullname, customer.phone
	from places, tour, customer, booking
	where customer.id = booking.customer_id
		and booking.tour_id = tour.id
		and tour.place_id = places.id
		and tour.id = @tourId
end

exec proc_view_customer 1
exec proc_view_customer 5

-- Viết trigger không cho phép xóa thông tin khách hàng
create trigger TG_no_delete_customer on customer
for delete
as
begin
	print 'Khong dc phep xoa thong tin khach hang'
	rollback transaction
end

delete from customer

-- Viết trigger không cho sửa giá tiền trong bảng Tour
create trigger TG_no_update_price_tour on tour
for update
as
begin
	if update(price)
	begin
		print 'Ban ko duoc sua gia tien'
		rollback transaction
	end
end

select * from tour

update tour set price = 20000 where id = 1

-- Thông kê tiền thu được cho từ Tour -> Viết view
create view vw_statistic_money
as
select places.title, tour.id, tour.startdate, tour.enddate, sum (tour.price) 'TongTien'
	from places, tour, booking
	where booking.tour_id = tour.id
		and tour.place_id = places.id
	group by places.title, tour.id, tour.startdate, tour.enddate

select * from vw_statistic_money

select * from booking
select * from customer

create trigger TG_add_point_customer on booking
for insert
as
begin
	update customer set point = point + 1 where id in (select customer_id from inserted)
end

insert into booking (tour_id, customer_id, booking)
values
(2, 1, '2022-02-12')
go

