create database Aptech2
go

use Aptech2
go

create table Customer (
	cID int primary key,
	cName nvarchar(25),
	cAge tinyint
)
go


create table Product (
	pID int primary key, 
	pName nvarchar(25),
	pPrice int
)
go

create table Orders (
	oID int primary key,
	cID int references Customer (cID),
	oDate datetime,
	oTotalPrice int
)
go

create table OrderDetail (
	oID int references Orders (oID),
	pID int references Product (pID),
	odQTY int
)
go

insert into Product (pID, pName, pPrice)
values
(1,'Ban La' , 1000),
(2,'Quat Chay' , 500),
(3,'May Bom Hong' , 20),
(4,'Tivi' , 5000),
(5, 'Tu Lanh' , 7000)
go



insert into Customer (cID, cName, cAge)
values
(1 , 'Tuan Anh', 19),
(2 , 'Viet Hung', 22),
(3 , 'Hoang Minh', 40),
(4 , 'Ngoc Hai', 14)
go

insert into Orders (oID, cID, oDate)
values
(1,1,'2007-9-15'),
(2,3,'2007-9-20'),
(3,1,'2007-9-23')
go

insert into OrderDetail (oID, pID, odQTY)
values
(1,1,3),
(1,3,5),
(1,4,2),
(2,5,1),
(2,5,4),
(2,3,5),
(3,1,12)
go

select *from Customer
select * from Orders
select * from OrderDetail
select * from Product

--2
select * from Orders 
order by oID desc

--3
select top 1   pName, pPrice from  Product
order by pPrice desc

select pName, max(pPrice) 'pPrice' from Product
group by pName

--4
select Customer.cName, Product.pName from Customer, Product, Orders, OrderDetail
where Customer.cID = Orders.cID and Orders.oID = OrderDetail.oID and OrderDetail.pID = Product.pID 
order by cName 


--5 
select Customer.cName from Customer,Orders
where  Customer.cID = Orders.cID and  Orders.cID in (null, 0, '') 

--6 
select Orders.oID , Orders.oDate, OrderDetail.odQTY, Product.pName, Product.pPrice
from Orders, OrderDetail, Product
where Orders.oID = OrderDetail.oID and OrderDetail.pID = Product.pID

--7
select Orders.oID , Orders.oDate, sum(OrderDetail.odQTY * Product.pPrice) ' Total'
from Orders, OrderDetail, Product
where Orders.oID = OrderDetail.oID and OrderDetail.pID = Product.pID
group by Orders.oID , Orders.oDate

--8
create view view_total_
as
select Orders.oID , Orders.oDate, sum(OrderDetail.odQTY * Product.pPrice) 'Total'
from Orders, OrderDetail, Product
where Orders.oID = OrderDetail.oID and OrderDetail.pID = Product.pID
group by Orders.oID , Orders.oDate

select * from view_total_

alter view vw_total_all
as
select sum(Total) 'Total cost all orders'
from view_total_ 


select *from vw_total_all