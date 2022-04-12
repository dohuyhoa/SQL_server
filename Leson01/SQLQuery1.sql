create table students(
	roll_number nvarchar(20),
	first_name nvarchar(30),
	last_name nvarchar(30),
	subject_name nvarchar(30),
	mark nvarchar(4),
)
	go

insert into students(roll_number,first_name,last_name,subject_name,mark)
values('R001', 'Nguyen', 'Hoa', 'AngularJS', '4')
go

select*from students
go