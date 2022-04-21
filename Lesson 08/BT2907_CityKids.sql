create database BT2907CityKids
go

use BT2907CityKids
go

create table Zone (
	id int primary key identity(1,1),
	zone_name nvarchar(100)
)
go

create table Game (
	id int primary key identity(1,1),
	game_name nvarchar(100),
	zone_id int references Zone (id),
	price int,
	type int,
	constraint check_type check (type in (0,1))
)
go


create table Store (
	id int primary key identity(1,1),
	store_name  nvarchar(100),
	zone_id int references Zone (id),
	company_name nvarchar(100)
)
go

create table Drink (
	id int primary key identity(1,1),
	drink_name nvarchar(50),
	price int,
	store_id int references Store (id)
)
go

create table Ticket (
	id int primary key identity(1,1),
	price int,
	buy_date date,
	game_id int references Game(id)
)
go
 --Bảng quản lý ticket: id tự tăng, giá vé, ngày mua, id trờ chơi -> foreign key (để trống -> Loại vé vào cửa)

create table Orders (
	id int primary key identity(1,1),
	drink_id int references Drink(id),
	buy_date date,
	price int,
	num int
)
go

--insert
insert into Zone (zone_name)
values
('Zone01'),
('Zone02'),
('Zone03')
go
select*from Zone

insert into Store (store_name,zone_id, company_name)
values
('Store A',1, 'Company A'),
('Store B',1, 'Company B'),
('Store C',2, 'Company C'),
('Store D',3, 'Company A'),
('Store e',2, 'Company B')
go

insert into Drink (drink_name, price, store_id)
values
('CocaCola', 10000, 1),
('RedBull', 15000, 1),
('Sting', 10000, 1),
('Cocaola', 10000, 2),
('Cafe', 10000, 2),
('Cam ep', 20000, 3),
('Soda', 10000, 4),
('C2', 10000, 5)
go

insert into Orders(drink_id, buy_date, price, num)
values
(1,'2022-04-04', 10000, 2),
(1,'2022-04-05', 10000, 3),
(2,'2022-04-04', 10000, 2),
(3,'2022-04-03', 10000, 5),
(4,'2022-04-03', 10000, 1),
(5,'2022-04-06', 10000, 5),
(6,'2022-04-08', 10000, 4),
(7,'2022-04-09', 10000, 10),
(8,'2022-04-01', 10000, 10)
go

insert into Game (game_name, zone_id, price, type)
values
('Game 01', 1, 40000, 0),
('Game 02', 1, 50000, 1),
('Game 03', 2, 50000, 1),
('Game 04', 3, 30000, 0),
('Game 05', 3, 80000, 0)
go

insert into Ticket (price, buy_date, game_id)
values
(40000, '2022-02-04', 1),
(50000, '2022-02-04', 2),
(50000, '2022-02-04', 3),
(30000, '2022-02-04', 4),
(80000, '2022-02-04', 5),
(50000, '2022-02-04', 2),
(50000, '2022-02-04', 2)
go

-- Tinh tiền thu được theo từng tro` chơi theo ngày cụ thể, tiền thu được của đối tác và của CityKids
select Game.id,Game.game_name, Game.type,Ticket.buy_date, sum( Game.price)
from Game, Ticket
where Game.id = Ticket.game_id
group by Game.id,Game.game_name, Game.type,Ticket.buy_date

-- Tính doanh thu đc của từng của hàng dịch vụ
select Store.store_name, Game.type, sum( Game.price)
from Game, Ticket, Store, Zone
where Game.id = Ticket.game_id and Zone.id = Store.zone_id and Game.zone_id = Zone.id
group by Store.store_name, Game.type,Store.store_name


-- Tạo trigger cho phép xóa thông tin 1 đồ uống
create trigger trigger_delete_drink on Drink
instead of delete
as
begin
	delete from Orders where drink_id in (select id from deleted)
	delete from Drink where id in (select id from deleted)
end

select * from Drink
delete from Drink where id = 8

-- Tạo trigger không cho sửa thông tin giá vé trong bản ticket

create trigger trigger_updata_ticket_price on Ticket
for update
as
begin
	if update (price)
	begin
		print N'Khong duoc phep xoa gia ve'
		rollback transaction
	end
end

select *from Ticket
update Ticket set price = 10000 where id = 6