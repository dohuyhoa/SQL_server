create database QLCHthoitrang
go
use QLCHthoitrang
create table product(
	id int primary key identity(1,1),
	title nvarchar(500),
	thumbnail nvarchar(3000),
	content text,
)
go


create table productlist(
	id int primary key identity(1,1),
	name nvarchar(30)
)
go

alter table productlist
add price int
go

alter table productlist
add num int
go

alter table productlist
add created_at date
go

alter table productlist
add updateed_at date
go
alter table productlist
add id_cat int
go


--them foreign key
alter table productlist
add constraint fk_id_id_cat foreign key (id_cat) references product (id)
go

--Thêm 5 sản phẩm vào bảng sản phẩm &  3 sản phầm vào bảng danh mục sản phẩm

insert into product(title,thumbnail,content)
values
	('ÁO SƠ MI NAM OVERSIZED THE BATMAN BOOZILLA','https://cdn.boo.vn/products/4901/ao-so-mi-nam-oversized-the-batman-boozilla-zoxem-0.jpg','Áo sơ mi dáng oversize thích hợp cho cả nam và nữ
- Áo được in tràn hình xung quanh áo'),
('ÁO PHÔNG OVERSIZED ALL OVER PRINT THE BATMAN BOOZILLA','https://cdn.boo.vn/products/4896/ao-phong-oversized-all-over-print-the-batman-boozilla-697lt-0.jpg',' Áo được thiết kế với 2 gam màu basic là đen và trắng, cùng hình in logo Batman màu đỏ nổi bật trước ngực tạo điểm nhấn
- Form áo regular thích hợp cho cả nam và nữ'),
('TÚI TOTE BATMAN','https://cdn.boo.vn/products/4899/tui-tote-batman-te11y-1.jpg','TÚI TOTE BATMAN thuộc thương hiệu BOOZILLA - Được mua bản quyền chính thức từ WARNER BROS'),
('ÁO PHÔNG LOOSE ESSENTIAL 1','https://cdn.boo.vn/products/4594/ao-phong-loose-essential-1-zus8f-0.jpg','
- Áo thun unisex thích hợp với cả nam và nữ. Mặc làm áo thun cặp, áo nhóm rất phù hợp.'),
('ÁO PHÔNG UN OVERSIZED PATTERN DẦN DẦN','https://cdn.boo.vn/products/4855/ao-phong-un-oversized-pattern-dan-dan-solidden-blackden-2.jpg','Áo phông thuộc BST Tết - DẦN DẦN
- Áo unisex dáng oversize thích hợp cho cả nam và nữ')
go


insert into productlist(name,price,num,created_at,updateed_at,id_cat)
values
('ÁO SƠ MI NAM ',0,12,'2000-12-14','2018-3-12',1),
('ÁO PHÔNG',480000,99,'2020-12-11','2022-12-28',2),
('TÚI',1299000,200,'2021-4-1','2022-3-12',3)
go

delete  from productlist

--sửa giá bán price = 5000 với điều kiện giá bán đang = 0 hoặc rỗng hoặc null
update productlist set price = 5000
where price = 0 or price =null or price =''
go

--sửa giá bán => giảm 10% giá bán với các sản phẩm đăng trước ngày 2020/06/06 (Ví dụ sản phẩm A có giá 50$ => sản 10% sẽ có giá là : 45$)
update productlist set price = price*90%
where created_at < '2020-06-06'
go

--.Xoá sản phẩm đăng trước ngày 2016/12/31
delete  from productlist
where created_at < '2016-12-21'


select * from product
select * from productlist


