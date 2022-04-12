create database BT1844Remake_DuadonHS
go

use  BT1844Remake_DuadonHS
go

create table Student (
	id int primary key identity(1,1),
	name nvarchar(100),
	address_st  nvarchar(300),
	father_name  nvarchar(100),
	father_phoneNumber  nvarchar(15),
	mother_name  nvarchar(100),
	birthday date,
	gender  nvarchar(5),
	id_position  int references Position (id)
)
go

select * from Student

create table Driver (
	id int primary key identity(1,1),
	name_driver nvarchar(100),
	phone_number nvarchar(20),
	gender nvarchar(5),
	address nvarchar(300),
)
go


create table Bus (
	id int primary key identity(1,1),
	bus_no nvarchar(10),
	type_bus nvarchar(20),
	seats int,
	id_driver int references Driver (id)
)
go

create table Position (
	id int primary key identity(1,1),
	address nvarchar(300)
)
go

create table Schedule (
	id_bus int references Bus (id),
	id_position int references Position (id),
	primary key (id_bus, id_position)
	)
go

--insert data
insert into Position (address)
values 
('54 Le Thanh Nghi'),
('32 Ban Dao Linh Dam'),
('999 Ben Xe Giap Bat'),
('12 Dai Hoc BK'),
('Truong Chinh '),
('Bach Mai'),
('Dai Tu'),
('Cu Lu')
go


insert into Driver (name_driver, phone_number, gender, address)
values
('Tai xe A', '09991111', 'Nam', 'address driver 1'),
('Tai xe b','09992222', 'Nu', 'address driver 1'),
('Tai xe C','09991333', 'Nam', 'address driver 1')
go

insert into Bus (bus_no, type_bus, seats, id_driver)
values
('Bus so 1', 'Xanh', 24, 1),
('Bus so 2', 'Vang', 12, 2),
('Bus so 3', 'Do', 9, 3)
go

insert into Schedule(id_bus, id_position)
values
(1,1),
(1,2),
(1,3),
(1,4),
(2, 5),
(2, 6),
(3, 7),
(3, 8)
go


insert into Student (name, address_st, father_name, father_phoneNumber, mother_name, birthday, gender, id_position)
values
('Hoc sinh 1' , 'address hs 1' , 'father nam1' , 'phone 1' , 'mother name 1' , '2005-01-01', 'Nam', 1),
('Hoc sinh 2' , 'address hs 2' , 'father nam2' , 'phone 2' , 'mother name 1' , '2005-01-01', 'Nu', 2),
('Hoc sinh 3' , 'address hs 3' , 'father nam3' , 'phone 3' , 'mother name 1' , '2005-01-01', 'Nam', 3),
('Hoc sinh 4' , 'address hs 4' , 'father nam4' , 'phone 4' , 'mother name 1' , '2005-01-01', 'Nam', 4),
('Hoc sinh 5' , 'address hs 5' , 'father nam5' , 'phone 5' , 'mother name 1' , '2005-01-01', 'Nu', 5),
('Hoc sinh 6' , 'address hs 6' , 'father nam6' , 'phone 6' , 'mother name 1' , '2005-01-01', 'Nam', 1),
('Hoc sinh 7' , 'address hs 7' , 'father nam7' , 'phone 7' , 'mother name 1' , '2005-01-01', 'Nu', 2),
('Hoc sinh 8' , 'address hs 8' , 'father nam8' , 'phone 8' , 'mother name 1' , '2005-01-01', 'Nam', 8),
('Hoc sinh 9' , 'address hs 9' , 'father nam9' , 'phone 9' , 'mother name 1' , '2005-01-01', 'Nu', 7),
('Hoc sinh 10' , 'address hs 10' , 'father name10' , 'phone 10' , 'mother name 1' , '2005-01-01', 'Nam', 6),
('Hoc sinh 11' , 'address hs 11' , 'father name11' , 'phone 11' , 'mother name 1' , '2005-01-01', 'Nam',5)
go


--Tạo View xem thông tin lộ trình đi của xe bus : tài xế, biển số xe, địa chỉ đón.
create view view_schedule_bus
as
select Driver.name_driver, Bus.bus_no, Position.address
from Driver,Bus, Position, Schedule
where Driver.id = Bus.id_driver and Bus.id = Schedule.id_bus and Schedule.id_position = Position.id
go

select * from view_schedule_bus
go

--Tạo Proc xem thông tin sinh viên theo biển số xe.
create proc proc_infoStudent_busNo
as
begin
	select Student.name, Student.address_st, Student.father_name, Student.birthday, Student.gender
	from Student, Bus, Position, Schedule
	where Student.id_position = Position.id and Position.id = Schedule.id_position and Schedule.id_bus = Bus.id and Bus.bus_no = 'Bus so 2'
end

exec proc_infoStudent_busNo 
-- Tao View xem thông tin sinh viên gồm : Tên SV, giới tính, địa chỉ đó
create view view_infor_student
as
select Student.name, Student.address_st, Student.gender
from Student
go

select * from view_infor_student



----- TRIGGER
select * from student

create trigger TG_check_birthday_insert_student on student
for insert
as
begin
	-- Goi xu ly block nay -> khi thuc hien insert du lieu vao bang student
	-- rollback transaction
	if (select count(*) from inserted where birthday < '2000-01-01') > 0
	begin
		print N'Ko duoc chen hoc vien co ngay sinh < 2000-01-01'
		rollback transaction
	end
end


insert into student (fullname, birthday, gender, address, father_name, father_phone, mother_name, mother_phone, position_id)
values
('HS II', '2016-02-16', 'Nam', 'Ha Noi', 'F A', '232434', 'M A', '343534', 1)


insert into student (fullname, birthday, gender, address, father_name, father_phone, mother_name, mother_phone, position_id)
values
('HS III', '1999-02-16', 'Nam', 'Ha Noi', 'F A', '232434', 'M A', '343534', 1)

-- sua trigger create -> alter
-- Xoa trigger
drop trigger TG_check_birthday_insert_student

-- update
select * from student

update student set birthday = '1999-02-12' where id = 10
go


create trigger TG_check_birthday_update_student on student
for update
as
begin
	-- Goi xu ly block nay -> khi thuc hien insert du lieu vao bang student
	-- rollback transaction
	if (select count(*) from inserted where birthday < '2000-01-01') > 0
	begin
		print N'Ko duoc update hoc vien co ngay sinh < 2000-01-01'
		rollback transaction
	end
end

update student set birthday = '1999-02-12' where id = 9

update student set fullname = 'AAA' where id < 3

create trigger TG_no_update_fullname_student on student
for update
as
begin
	if update(fullname)
	begin
		print 'Ko dc thay doi ten hoc vien'
		rollback transaction
	end
end

select * from student

-- Ko cho phep xoa ban ghi: 1, 2, 5, 6
delete from student where id >= 5

create trigger TG_no_delete_1_2_5_6_student on student
for delete
as
begin
	if (select count(*) from deleted where id in (1,2,5,6)) > 0
	begin
		print 'Ko dc xoa ban ghi 1, 2, 5, 6'
		rollback transaction
	end
end

----
select * from student
select * from position
select * from schedule
select * from bus
select * from driver

insert into driver (fullname, gender, phone, address)
values
('AA', 'Nam', '234234', 'Ha Noi')
go

delete from driver where id = 6

delete from driver where id = 5

delete from schedule where bus_id in (select id from bus where driver_id = 5)

delete from bus where driver_id = 5

create trigger TG_instead_of_delete_driver on driver
instead of delete
as
begin
	delete from schedule where bus_id in (select id from bus where driver_id in (select id from deleted))

	delete from bus where driver_id in (select id from deleted)

	delete from driver where id in (select id from deleted)
end

delete from driver where id = 4