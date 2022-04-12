create database BT1801QLBanHang
go

use BT1801QLBanHang
go

create table Product (
	id_product int primary key identity(1,1),
	name_product nvarchar(200),
	manufacture nvarchar(200),
	origin nvarchar(50),
	accede int,
	saleprice int,
	mfg smalldatetime
)
go

create table sale(
	id_order int primary key identity(1,1),
	id_product int references product (id_product),
	note nvarchar(300),
	date_sale smalldatetime,
	quantity int,
	price int
)

--insertr data
insert into Product (name_product, manufacture, origin, accede,saleprice,mfg)
values
('Tivi' , 'Sony', 'China', 10000000, 15000000, '2021-05-05'),
('Destop' , 'SamSung', 'Viet Nam', 4000000, 700000, '2022-01-05'),
('Ban phim Ek87' , 'Dareu', 'Malaysia', 500000, 700000, '2022-2-02'),
('Mosue' , 'Gaming', 'Thialand', 100000, 1500000, '2020-03-05'),
('Tai nghe' , 'SoSenheisher', 'German', 900000, 1200000, '2021-05-05'),
('Legion 6 Pro' , 'Lenovo', 'China', 10000000, 17000000, '2021-07-07'),
('Speaker' , 'Logitech', 'Viet Nam', 10000000, 15000000, '2021-05-05'),
('Computer' , 'Dell', 'China', 10000000, 15000000, '2021-05-05')
go

insert into sale (id_product, note, date_sale, quantity, price)
values
(1, 'newbox' ,'2022-04-12' , 2, 15000000),
(1, 'newbox' ,'2022-04-12' , 5, 15000000),
(2, 'newbox' ,'2022-04-12' , 15, 15000000),
(4, 'newbox' ,'2022-04-12' , 25, 15000000),
(5, 'newbox' ,'2022-04-12' , 20, 15000000),
(6, 'newbox' ,'2022-04-12' , 2, 15000000),
(7, 'new like' ,'2022-04-12' , 10, 15000000),
(8, 'new like' ,'2022-04-12' , 10, 15000000),
(2, 'newbox' ,'2022-04-12' , 10, 15000000),
(2, 'newbox' ,'2022-04-12' , 10, 15000000)
go

-- 3. Thực hiện liệt kê tất cả các đơn hàng đã được bán ra -> Dùng view để thiết kế
create view view_donhang_saled
as
select sale.id_order,Product.name_product, sale.date_sale, sale.quantity, sale.price
from sale, Product
where sale.id_product = Product.id_product
go

select * from view_donhang_saled

-- 4. Liệt kê các đơn hàng được bán ra có xuất xứ -> yêu cầu viết procedure có tham số truyền vào là xuất xứ
create proc proc_saled_origin
@origin nvarchar(20)
as
begin
	select sale.id_order,Product.name_product,Product.origin, sale.date_sale, sale.quantity, sale.price
	from sale, Product
	where sale.id_product = Product.id_product and Product.origin =   @origin
end
go

exec proc_saled_origin  'Viet Nam'


--   5. Thống kê tổng giá bán được cho từng mặt hàng. -> viết procedure có tham số truyền vào là mặt hàng và tham số đấu già là total

create proc proc_total_saled
@product_name nvarchar(100),
@total int output
as
begin
	select @total = count(sale.price*Product.id_product)
	from Product,sale
	where sale.id_product = Product.id_product and Product.name_product = @product_name
end
go

declare @total int
exec proc_total_saled 'Destop', @total = @total output
print @total
go
