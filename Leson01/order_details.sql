create table order_details(ord_no nvarchar(5),item_no nvarchar(5),qty nvarchar(5))
go
insert into order_details(ord_no,item_no,qty)
values
('101','HW3','50')
go
insert into order_details(ord_no,item_no,qty)
values
('101','SW1','150')
go
insert into order_details(ord_no,item_no,qty)
values
('102','HW2','10')
go
insert into order_details(ord_no,item_no,qty)
values
('103','HW3','50')
go
insert into order_details(ord_no,item_no,qty)
values
('104','HW2','25')
go
insert into order_details(ord_no,item_no,qty)
values
('104','HW3','100')
go
insert into order_details(ord_no,item_no,qty)
values
('105','SW1','100')
go

select*from order_details
go

select ord_no,item_no from order_details
go