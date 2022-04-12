create database BT1793QLSV
go 

use BT1793QLSV
go

CREATE TABLE class(
classId int not null,
classCode nvarchar(50)
)
go

create table Student(
StudentId int not null,
StudentName nvarcHAR(50),
BirthDate datetime,
classId int
)
go

create table Subject(
SubjectId int not null,
subjectName nvarchar(100),
SessionCount int
)
go

create table Result(
StudentId int not null,
SubjectId int not null,
Mark int
)
go
--mark -&gt; float
alter table Result
alter column Mark float
go

--add primary key
alter table class
add CONSTRAINT PK_Class primary key (classId)
go

alter table Student
add CONSTRAINT PK_Student primary key (StudentId)
go

alter table Subject
add CONSTRAINT PK_Subject primary key (SubjectId)
go

alter table Result
add CONSTRAINT PK_Result primary key (StudentId,SubjectId)
go

--add foreign keyclass
alter table Student
add CONSTRAINT fk_Student_Class FOREIGN key (classId) references class (classId)
go

alter table Result
add CONSTRAINT fk_Student_Student FOREIGN key (StudentId) references Student (StudentId)
go

alter table Result
add CONSTRAINT fk_Student_Subject FOREIGN key (SubjectId) references Subject (SubjectId)
go

select * from class

select * from Result
select * from Student
select * from Subject

--insert data
insert into class(classID,classCode)
VALUES
(1,'C1106KV'),
(2,'C1108GV'),
(3,'C1108IV'),
(4,'C1108HV'),
(5,'C1109GV')
go

insert into Student(StudentId,StudentName,BirthDate,classId)
VALUES
(1,'PhamTuanAnh','1993-08-05',1),
(2,'PhanVanHuy','1992-06-10',1),
(3,'NguyenHoangMinh','1992-09-07',2),
(4,'TranTuanTu','1993-10-10',2),
(5,'DoAnhTai','1992-06-06',3)
go

insert into Subject(SubjectId,SubjectName,SessionCount)
VALUES
(1,'C Programming',22),
(2,'Web Design',18),
(3,'Database Management',23)
go

insert into Result(StudentId,SubjectId,Mark)
VALUES
(1,1,8),
(1,2,7),
(2,3,5),
(3,2,6),
(4,3,9),
(5,2,8)
go

--display

select StudentId 'MaSinhvien',StudentName 'TenSinhgVien',BirthDate 'Ngaysinh' from student
WHERE BirthDate BETWEEN '1992-10-10'and '1993-10-10'
go

--count student
SELECT class.classId 'MaLop',class.classCode 'TenLop',count(Student.classID) 'TotalStudent'
from Student,class
where Student.classId = class.classID
group BY class.classId, class.classCode
go

--sum mark
SELECT Student.StudentId 'MaSinhVien',Student.StudentName 'TenSinhVien',sum(Result.Mark)
'TotalStudent'
from Student,Result
where Student.StudentId = Result.StudentId
group BY Student.StudentId, Student.StudentName
having sum(Result.Mark)>10
go