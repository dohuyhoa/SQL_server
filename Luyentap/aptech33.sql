create database aptech3_fis
go

use aptech3_fis
go

create table Student (
	RN nvarchar(5) not null,
	Name nvarchar(50)  not null,
	Age int,
	Gender int
)
go

create table Subject (
	sID int not null,
	sName nvarchar(50)  not null
)
go

create table StudentSubject (
	RN nvarchar(5) not null ,
	sID int not null,
	Mark float,
	Date date,
	primary key (RN,sID)
)
go

alter table Student
add constraint pk_student primary key (RN)

alter table Subject
add constraint pk_subject primary key (sID)

alter table StudentSubject
add constraint chec_mark check(Mark between 0 and 10)

alter table StudentSubject
add constraint fk_sID foreign key (sID) references Subject (sID)

alter table StudentSubject
add constraint fk_RN foreign key (RN) references Student (RN)

insert into Student (RN, Name,Age)
values
('R001', 'My Linh' , 20 ),
('R002', 'Dam Vinh Hung' , 22 ),
('R003', 'Kim Tu Long' , 25),
('R004', 'Tai Linh' , 27),
('R005', 'My Le' , 23),
('R006', 'Ngoc Oanh' , 20)
go

insert into Subject (sID, sName)
values
(1, 'SQL'),
(2, 'LGC'),
(3, 'HTML'),
(4, 'CD')
go

insert into StudentSubject(RN, sID, Mark, Date)
values
('R001', 1, 8, '2005-7-28'),
('R002', 2, 3, '2005-7-29'),
('R003', 3, 9, '2005-7-31'),
('R004', 1, 5, '2005-7-30'),
('R005', 4, 10, '2005-7-19'),
('R006', 1, 8, '2005-7-27')
go

insert into StudentSubject(RN, sID, Mark, Date)
values
('R003', 1, 10, '2005-7-28'),
('R002', 3, 7, '2005-7-29')
go


update Student set Gender = 0 where Name in ('My Linh', 'Tai Linh', 'My Le')
update Student set Gender = 1 where Name in ('Kim Tu Long')


insert into Subject (sID, sName)
values
(5, 'Core Java'),
(6, 'VB.Net')
go


--Hiển thị tất cả các môn học mà chưa có học viên nào nhận điểm.
select Subject.sID, Subject.sName 
from Subject left join StudentSubject
on Subject.sID = StudentSubject.sID
group by Subject.sID, Subject.sName 
having count(StudentSubject.Mark)=0


--Hiển thị danh sách tất cả các môn học, với điểm cao nhất mà học viên đạt được với môn học đó, môn nào chưa có điểm thì để trống (Null) phần điểm.
select Subject.sID, Subject.sName, max(StudentSubject.Mark)
from Subject left join StudentSubject
on Subject.sID = StudentSubject.sID
group by Subject.sID, Subject.sName 

--Hiển thị tên môn học mà có nhiều hơn một điểm
select Subject.sName ,count( StudentSubject.Mark) 'So Sv thi '
from Subject left join StudentSubject
on Subject.sID = StudentSubject.sID
group by sName 
having count( StudentSubject.Mark)  >0

--Tạo một view tên là StudentInfo để xem đầy đủ các thông tin về học viên gồm (RN,sID,Name, Age, Gender, sName, Mark, Date).
--Đối với trường Gender hiển thị Male thay cho 0, Female thay cho 1 và Unknow thay cho Null.


create view view_Student
as
	select Student.RN, Subject.sID, Student.Name, Student.Age, Student.Gender, Subject.sID, StudentSubject.Mark, StudentSubject.Date
	from Student, StudentSubject  Subject
	where Subject.sID = StudentSubject.sID and StudentSubject.sID = Subject.sID
	group by Student.RN, Subject.sID, Student.Name, Student.Age, Student.Gender, Subject.sID, StudentSubject.Mark, StudentSubject.Date




select * from Student
select * from StudentSubject
select * from Subject

drop table Student

drop table StudentSubject

drop table Subject