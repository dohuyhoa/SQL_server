create database BT1815QLCafe
go

use BT1815QLCafe
go

create table Catagory (
	id int primary key identity(1,1),
	name nvarchar(50),
)
go

create table Products (
	id int primary key identity(1,1),
	title nvarchar(200),
	thumbnail  nvarchar(500),
	description text,
	price  float,
	id_catagory int  references Catagory (id)
)
go

create table Staff (
	id int primary key identity(1,1),
	fullname  nvarchar(50),
	phone nvarchar(50),
	birthday  date,
	address  nvarchar(200),
	email  nvarchar(200)
)
go

create table Customer(
	id  int  primary key identity(1,1),
	fullname nvarchar(50),
	birthday  date,
	phone_number  nvarchar(20),
	email  nvarchar(200),
	address  nvarchar(200)
)
go

create table  Orders(
		id int  primary key identity(1,1),
		staff_id  int references Staff (id),
		customer_id  int  references Customer (id),
		total_price  float,
		order_date date,
		note  varchar(500)
)
go

create table OrderDetail (
		id int  primary key identity(1,1),
		order_id int references Orders(id),
		product_id int references Products(id),
		number int,
		price float,
		total_price float
)
go

insert into Catagory (name)
values
('Cafe'),
('Sinh To')
go

select * from Catagory

insert into Products (title, thumbnail, description, price, id_catagory)
values
('Cafe nong', 'Thumbnail_1', 'Noi dung 1', 32000, 1),
('Cafe da', 'Thumbnail_2', 'Noi dung 2', 32000, 1),
('Cafe sua', 'Thumbnail_3', 'Noi dung 3', 32000, 1),
('Sinh to bo', 'Thumbnail_4', 'Noi dung 4', 42000, 2),
('Sinh to mang cau', 'Thumbnail_5', 'Noi dung 5', 42000, 2)
go

select * from Products

insert into Staff(fullname, birthday, email, address)
values
('Nguyen Tran A', '1998-03-03', 'nguyentrana@gmail.com', 'Ha Noi'),
('Nguyen Tran B', '1999-03-08', 'nguyentranb@gmail.com', 'Ha Noi')
go

insert into Customer(fullname, birthday, email, address, phone_number)
values
('Hoang Tran A', '1998-03-01', 'Hoanglea@gmail.com', 'Ha Noi', '035600000'),
('Hoang Tran B', '1998-03-02', 'Hoanglea@gmail.com', 'Ha Noi', '035600022'),
('Hoang Tran V', '1998-03-03', 'Hoanglea@gmail.com', 'Ha Noi', '035600011'),
('Hoang Tran D', '1998-03-04', 'Hoanglea@gmail.com', 'Ha Noi', '035600033'),
('Hoang Tran E', '1998-03-05', 'Hoanglea@gmail.com', 'Ha Noi', '0356000044')
go

insert into Orders(staff_id, customer_id, total_price, order_date, note)
values
(1, 1, 70000, '2021-02-26', ''),
(1, 1, 105000, '2021-02-5', ''),
(2, 2, 140000, '2021-02-27', ''),
(2, 3, 30000, '2021-02-25', ''),
(2, 4, 80000, '2021-02-25', '')
go

select * from Orders

insert into OrderDetail(order_id, product_id, number, price, total_price)
values
(5, 1, 2, 35000, 70000),
(6, 2, 3, 35000, 105000),
(7, 1, 4, 35000, 140000),
(8, 3, 1, 30000, 30000),
(9, 5, 2, 40000, 80000)
go

create clustered index id_Orders on OrderDetail (order_id)
go

-- Hiển thị danh sách loại đồ uống theo một danh mục -> yêu cầu viết truy vấn sql, tạo store (phần này làm 2 ý tách biết)
select Catagory.name, Products.title, Products.thumbnail, Products.description, Products.price
from Catagory left join Products
on  Catagory.id = Products.id_catagory

create proc proc_product_category
@categoryId int
as
select Catagory.name, Products.title, Products.thumbnail, Products.description, Products.price
from Catagory,Products
where Catagory.id = Products.id_catagory and Catagory.id = @categoryId 
go


exec proc_product_category 1
exec proc_product_category 2

-- Hiển thị danh mục sản phẩm trong 1 đơn hàng -> yêu cầu viết truy vấn sql và tạo 1 store cho chức năng này
select Products.id, Products.title, Catagory.name, OrderDetail.number, OrderDetail.price, OrderDetail.total_price
from Products left join Catagory on Products.id_catagory = Catagory.id
	     left join OrderDetail on OrderDetail.product_id = Products.id
where OrderDetail.order_id = 5

create proc proc_order 
@order_id int
as
select Products.id, Products.title, Catagory.name, OrderDetail.number, OrderDetail.price, OrderDetail.total_price
from Products left join Catagory on Products.id_catagory = Catagory.id
	     left join OrderDetail on OrderDetail.product_id = Products.id
where OrderDetail.order_id = @order_id
go

exec proc_order 5

-- Hiển thị danh mục các đơn hàng theo mã KH.
select Customer.id, Customer.fullname, Orders.total_price, Orders.order_date
from Customer left join Orders on Customer.id = Orders.customer_id
where Customer.id = 3

-- Hiển thị doanh thu theo ngày bắt đầu và ngày kết thức -> yêu cầu viết theo store.
create proc proc_total_all
@startdate date,
@enddate date
as
select  Sum(Orders.total_price) 'Total All'
from Orders
where Orders.order_date between @startdate and @enddate
go

exec proc_total_all  '2021-02-08',  '2021-02-28'


