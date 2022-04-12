create table order_details(ord_no nvarchar(5), item_no nvarchar(5), qty nvarchar(5))
go
insert into order_details(ord_no,item_no,qty)
values
('101','HW3','50')
go
DELETE FROM order_details;
go