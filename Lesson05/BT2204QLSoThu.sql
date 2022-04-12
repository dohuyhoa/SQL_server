
﻿create database BT2209QLSOTHU
go
use BT2209QLSOTHU

-- Bảng Room (Thông tin từng chuồng trong sở thú)
create table Room(
	id int not null,
	name nvarchar(20),
	max int
)
go

-- Thông tin động vật (Animal)
create table Animal(
	id int not null,
	name nvarchar(50),
	age int, 
	buy_at datetime,
	room_id int
)
go

-- Loại thức ăn (FoodType)
create table FoodType(
	id int not null,
	name nvarchar(50),
	price float,
	amount float
)
go

--Quản lý thức ăn (FoodAnimal)
create table FoodAnimal (
	food_id int,
	animal_id int
)
go
--tao primary key
drop table Room
drop table Animal
drop table FoodType
drop table Room

alter table Room
add constraint pk_Room_id primary key (id)
go

alter table Animal
add constraint pk_Animal_id primary key (id)
go

alter table FoodType
add constraint pk_FoodType_id primary key (id)
go

--forign key
alter table Animal
add constraint fk_Animal_id foreign key (room_id) references Room (id)
go


alter table FoodAnimal 
add constraint fk_FoodAnimal foreign key (food_id) references FoodType (id)
go

alter table FoodAnimal 
add constraint fk_Animal foreign key (animal_id) references Animal (id)
go
---add data
insert into Room(id, name, max)
values
(1,'BitDog 2',10),
(2,'BitDog 3',4),
(3,'BitDog 3',5),
(4,'BitDog 4',5),
(5,'BitDog 5',8)
go

insert into Animal(id, name, age, buy_at, room_id)
values
(1,'Flamingo 1',4, '2002-12-12', 1),
(2,'Snake 1',5, '2002-12-1', 2),
(3,'Tiger 1',6, '2002-1-12', 4),
(4,'Elephent 1',8, '2002-2-12', 5),
(5,'Monkey 1',3, '2002-3-3', 1)
go

insert into Animal(id, name, age, buy_at, room_id)
values
(6,'Flamingo 2',4, '2002-12-12', 4),
(7,'Flamingo 3',4, '2002-12-12', 4),
(8,'Flamingo 4',4, '2002-12-12', 4),
(9,'Flamingo 5',4, '2002-12-12', 4),
(10,'Flamingo 6',4, '2002-12-12', 4),
(11,'Flamingo 7',4, '2002-12-12', 4)
go
insert into Animal(id, name, age, buy_at, room_id)
values
(12,'Flamingo 2',4, '2002-12-12', 4),
(13,'Flamingo 3',4, '2002-12-12', 4),
(14,'Flamingo 4',4, '2002-12-12', 4)
go

insert into Animal(id, name, age, buy_at, room_id)
values
(15,'Flamingo 2',4, '2002-12-12', 4),
(16,'Flamingo 3',4, '2002-12-12', 4),
(17,'Flamingo 4',4, '2002-12-12', 4),
(18,'Flamingo 2',4, '2002-12-12', 4),
(19,'Flamingo 3',4, '2002-12-12', 4),
(20,'Flamingo 4',4, '2002-12-12', 4),
(21,'Flamingo 3',4, '2002-12-12', 4),
(22,'Flamingo 4',4, '2002-12-12', 4)
go


insert into FoodType (id, name,price, amount)
values
(11,'Cam 1',12500, 10),
(22,'Cam 2',2500, 9),
(33,'Cam 3',30000, 8),
(44,'Cam 4',40000, 12),
(55,'Cam 5',50000, 1)
go

insert into FoodAnimal
values
(11,1),
(22,2),
(33,3),
(44,4),
(55,5)
go


--4. Xem thông tin động vật gồm các trường sau: tên chuồng, tên động vật, tuổi, ngày mua về
select Room.name, Animal.name, Animal.age, Animal.buy_at 
from Room,Animal
where Animal.room_id = Room.id
go

--5. Xem thông tin những chuồng có số động vật đang lưu vượt quá max của chuồng đó
select Room.id, Room.name, Room.max, count(Animal.room_id) 'Soluong'
from Room, Animal
where Animal.room_id = Room.id
group by Room.id, Room.name, Room.max
having count(Animal.room_id) > room.max
go

--6. Xem thông tin những chuồng còn so khả năng lưu thêm động vật vào
select Room.id, Room.name, Room.max, count(Animal.room_id) 'Soluong'
from Room, Animal
where Animal.room_id = Room.id
group by Room.id, Room.name, Room.max
having count(Animal.room_id) < room.max
go


--7. Viết proc có tham số là @animalId -> cho phép xem được thông tin loại thức ăn của động vật này.
create proc proc_xemthucan_dongvat
@animalId int
as 
begin
	select FoodAnimal.food_id, FoodType.name, Animal.name
	from FoodType, Animal, FoodAnimal
	where FoodAnimal.food_id = FoodType.id and FoodAnimal.animal_id = Animal.id and Animal.id = @animalId
end
go

exec  proc_xemthucan_dongvat 4


select *from Room
select *from Animal
select *from FoodType
select *from FoodAnimal
BT2209QLSOTHU.sql
Đang hiển thị BT2209QLSOTHU.sql.