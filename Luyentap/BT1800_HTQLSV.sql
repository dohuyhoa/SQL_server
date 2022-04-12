create database BT1800
go

use BT1800
go

create table Class(
	ClassId int not null,
	ClassCode nvarchar(50)
)
go

create table Student (
	StudentId int not null,
	StudentName nvarchar(50),
	BirthDate datetime,
	ClassId int
)
go

alter table Student
alter column BirthDate date
go

create table Subject(
	SubjectId int not null,
	SubjectName nvarchar(100),
	Sessioncount int
)
go

create table Result(
	StudentId int not null,
	SubjectId int not null,
	Mark int
)
go

create index NCI_Student_StudentName on Student (StudentName)
go

select * from Student
select * from Class
select * from Subject
select * from Result

alter table Result
alter column Mark float
go

drop table Result

--primary key
alter table Class 
add constraint pk_Class primary key (classId)
go

alter table Student
add constraint pk_Student primary key (StudentId)
go

alter table Subject
add constraint pk_Subject primary key (SubjectId)
go

alter table Result
add constraint pk_Result primary key (StudentId, SubjectId)
go


--Add foreign ky
alter table Student
add constraint fk_Student_Class foreign key (ClassId) references Class (ClassId)
go

alter table Result
add constraint fk_Result_Student foreign key (StudentId) references Student (StudentId)
go

alter table Result
add constraint fk_Result_Subject foreign key (SubjectId) references Subject (SubjectId)
go

alter table Subject
add constraint CK_Subject_SessionCount check (SessionCount > 0)
go

---insert datda foro table
insert into Student(StudentId, StudentName, BirthDate, ClassId)
values
(1, N'Phạm Tuấn Anh', '1993-08-05', 1),
(2, N'Phan Văn Huy', '1992-06-10', 1),
(3, N'Nguyễn Hoàng Minh', '1992-09-07', 2),
(4, N'Trần Tuấn Tú', '1993-10-10', 2),
(5, N'Đỗ Anh Tài', '1993-08-05', 3)
go

insert into Class (ClassId, ClassCode)
values 
(1, 'C1106KV'),
(2, 'C1108GV'),
(3, 'C1108IV'),
(4, 'C1108HV'),
(5, 'C1109GV')
go

insert into Subject (SubjectId, SubjectName, SessionCount)
values
(1, 'C Programming', 22),
(2, 'Web Design', 18),
(3, 'Database Management', 23)
go

insert into Result (StudentId, SubjectId, Mark)
values
(1, 1, 8),
(1, 2, 7),
(2, 3, 5),
(3, 2, 6),
(4, 3, 9),
(5, 2, 8)
go

select * from Student
select * from Class
select * from Subject
select * from Result

---Search student birthdate
select StudentId, StudentName, BirthDate 'DateOfBirth'
from Student
where BirthDate between '1992-10-10' and '1993-10-10'
go

--Count Student in each Class

select Class.ClassId, Class.ClassCode, count(Student.StudentId) 'Si so'
from  Class left join Student on Class.ClassId = Student.ClassId
group by  Class.ClassId, Class.ClassCode
go

--Sum up mark all subject >10

select Student.StudentId, Student.StudentName, SUM(Result.Mark) 'Total Mark'
from Student, Result
where Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName
having SUM(Result.Mark) > 10
go

--. view sum mark
create view view_Total_mark_OfStudentName
as
select Student.StudentId, Student.StudentName, SUM(Result.Mark) 'Total Mark'
from Student, Result
where Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName
having SUM(Result.Mark) > 10
go

select * from view_Total_mark_OfStudentName

--7. view

create view view_StudentSubjectMark 
as
select Student.StudentId, Student.StudentName, Subject.SubjectName, Result.Mark
from Student, Subject, Result
where Result.StudentId = Student.StudentId and Result.SubjectId = Subject.SubjectId
go

select * from view_StudentSubjectMark

select top 3 *from view_StudentSubjectMark
order by Mark desc


--Procedures 
create proc up_IncreaseMark
@SubjectId int
as
begin
	select Student.StudentId, Student.StudentName, Subject.SubjectName, Result.Mark
	from Student, Subject, Result
	where Result.StudentId = Student.StudentId and Result.SubjectId = Subject.SubjectId and Subject.SubjectId = @SubjectId
end
go

exec  up_IncreaseMark 2
go
	

--Trigger

create trigger TG_Result_Insert
on Result
for insert
as 
	begin
		if(select Mark  from inserted ) < 0
		begin
			print N'Cannot insert mark less than zero'
			rollback transaction
		end
	end
go


create trigger TG_Result_update
on Result
after update  --for /after
as 
	begin
		if(select Mark  from inserted ) < 0
		begin
			print N'Cannot insert mark less than zero'
			rollback transaction
		end
	end
go

create trigger TG_Result_update
on Result
after update  --for /after
as 
	begin
		if(select count( Mark)  from inserted  where  Mark < 0) > 0
		begin
			print N'Cannot insert mark less than zero'
			rollback transaction
		end
	end
go
---de update duo toan bo bang
drop trigger TG_Result_update

update Result set Mark = -1 where StudentId =4
update Result set Mark = -1 
select * from Result

--trigger update Subjectname
create trigger trigger_no_update_Subject_Name
on Subject
after update 
as
begin
	if update (SubjectName)
	begin
		print N'You do not update this column'
		rollback transaction
	end
end
go

update Subject set SubjectName = 'C1111K' where SubjectId = 1
