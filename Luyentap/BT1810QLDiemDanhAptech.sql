create database BT1810QLdiemdanhAptech
go

use BT1810QLdiemdanhAptech
go

create table Student(
	rollNo nvarchar(5) primary key,
	fullName nvarchar(50),
	gender nvarchar(5),
	birthDate smalldatetime,
	nativeLand nvarchar(100),
	email nvarchar(200),
	phoneNumber nvarchar(20)
)
go

create table Teacher(
	teacher_no nvarchar(10) primary key,
	teacherName nvarchar(100),
	gender nvarchar(10),
	birthDate smalldatetime
)
go

create table Subject(
	subject_no nvarchar(10) primary key,
	subjectName nvarchar(50),
	totalSession int
)
go

create table Class(
	class_no nvarchar(10) primary key,
	className nvarchar(50),
	note nvarchar(500)
)
go

create table ClassMember(
	rollNo nvarchar(5) references Student (rollNo),
	class_no  nvarchar(10) references Class (class_no) ,
	JoinedDate smalldatetime,
	OutedDate smalldatetime
)
go

create table Schedule(
	id int primary key identity(1,1),
	teacher_no nvarchar(10) references Teacher (teacher_no),
	subject_no nvarchar(10) references Subject (subject_no),
	class_no nvarchar(10) references Class (class_no),
	startDate smalldatetime,
	endDate  smalldatetime
)
go


create table Attendance(
	id int primary key identity(1,1),
	schedule_no int references Schedule (id),
	rollNo nvarchar(5) references Student (rollNo),
	attendanceDate1 smalldatetime,
	attendance_no1 nvarchar(5),
	attendanceDate2 smalldatetime,
	attendance_no2 nvarchar(5),
	note  nvarchar(300)
)
go


---insert data for table each table 5 record
insert into Student(rollNo,fullName, gender,birthDate, nativeLand, email, phoneNumber)
	values
	('R001' , ' Sinhvien 1' , 'Nam', '2000-01-01' , 'Ha Noi', 'sinhvien1@email.com', '0988881111'),
	('R002' , ' Sinhvien 2' , 'Nu', '2000-01-02' , 'Ha Nam', 'sinhvien2@email.com', '098888222'),
	('R003' , ' Sinhvien 3' , 'Nam', '2000-01-03' , 'Ha Tinh', 'sinhvien3@email.com', '098888333'),
	('R004' , ' Sinhvien 4' , 'Nu', '2000-01-04', 'Hai Phong', 'sinhvien4@email.com', '0988881444'),
	('R005' , ' Sinhvien 5' , 'Nam', '2000-01-05' , 'Nam Dinh', 'sinhvien5@email.com', '0988885555'),
	('R006' , ' Sinhvien 6' , 'Nu', '2000-01-06' , 'Ben Tre', 'sinhvien6@mail.com', '098888666'),
	('R007' , ' Sinhvien 7' , 'Nu', '2000-01-07' , 'Dak Lak', 'sinhvien7@email.com', '0988887771'),
	('R008' , ' Sinhvien 8' , 'Nam', '2000-01-8' , 'Lao', 'sinhvien8@email.com', '098888888')
go

insert into Teacher(teacher_no, teacherName, gender, birthDate)
values
('GV01', 'Tran Bui 02', 'Nam', '1981-01-07'),
('GV05', 'Le Nguyen 03', 'Nu', '1981-02-09'),
('GV02', 'Tran Bui 01', 'Nam', '1981-03-03'),
('GV03', 'Tran Bui 05', 'Nu', '1981-04-04'),
('GV04', 'Tran Bui 06', 'Nam', '1981-08-02'),
('GV06', 'Tran Bui 07', 'Nu', '1981-08-01')
go

insert into Subject(subject_no, subjectName, totalSession)
values
('sub 01' , 'Toan', 10),
('sub 02' , 'Van', 200),
('sub 03' , 'Ly', 15),
('sub 04' , 'Hoa', 25),
('sub 05' , 'Sinh', 30)
go

insert into Class( class_no, className)
values
( 'Cl001' , 'Class nme 1' ),
( 'Cl002' , 'Class nme 2' ),
( 'Cl003' , 'Class nme 3' ),
( 'Cl004' , 'Class nme 4' ),
('Cl005' , 'Class nme 5' )
go

insert into ClassMember(rollNo, class_no, JoinedDate, OutedDate)
values
('R001', 'Cl001', ' 2020-01-01', '2022-02-02'),
('R002', 'Cl001', ' 2020-01-01', '2022-02-02'),
('R003', 'Cl002', ' 2020-01-01', '2022-02-02'),
('R004', 'Cl002', ' 2020-01-01', '2022-02-02'),
('R005', 'Cl003', ' 2020-01-01', '2022-02-02'),
('R006', 'Cl003', ' 2020-01-01', '2022-02-02'),
('R007', 'Cl004', ' 2020-01-01', '2022-02-02'),
('R008', 'Cl005', ' 2020-01-01', '2022-03-03')
go

insert Schedule(teacher_no, subject_no, class_no, startDate, endDate)
values
('GV01','sub 01', 'Cl001', '2021-12-12', '2022-02-02'),
('GV02','sub 02', 'Cl001', '2021-12-12', '2022-02-02'),
('GV03','sub 03', 'Cl002', '2021-12-12', '2022-02-02'),
('GV04','sub 04', 'Cl003', '2021-12-12', '2022-02-02'),
('GV05','sub 05', 'Cl004', '2021-12-12', '2022-02-02'),
('GV06','sub 04', 'Cl005', '2021-12-12', '2022-02-02'),
('GV05','sub 01', 'Cl005', '2021-12-12', '2022-02-02')
go


insert into Attendance(schedule_no, rollNo, attendanceDate1, attendance_no1, attendanceDate2, attendance_no2)
values
(1, 'R001',  '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(2, 'R002', '2021-02-02 18:30:00 ', 'PA' ,  '2021-02-02 22:00:00 ', 'P' ),
(3 , 'R003', '2021-02-02 18:30:00 ', 'PE' ,  '2021-02-02 22:00:00 ', 'Pe' ),
(4, 'R004', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(5, 'R005', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(6, 'R006', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(7, 'R007', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(1, 'R008', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(2, 'R003', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' ),
(3, 'R005', '2021-02-02 18:30:00 ', 'P' ,  '2021-02-02 22:00:00 ', 'P' )
go

--Tạo procedure để xem thông tin học viên trong một lớp học - đầu vào là tên lớp
create proc proc_thongtinhocvien_class
@classID nvarchar(10)
as 
begin
	select Class.class_no, Class.className, ClassMember.rollNo, Student.fullName
	from Class, ClassMember, Student
	where ClassMember.class_no =  Class.class_no  and ClassMember.rollNo = Student.rollNo  and Class.class_no = @classID
end
go

--dung left join
create proc proc_thongtinhocvien_class_join
@classID nvarchar(10)
as 
begin
	select Class.class_no, Class.className, ClassMember.rollNo, Student.fullName
	from Class left join  ClassMember on ClassMember.class_no =  Class.class_no  
		   left join Student on ClassMember.rollNo = Student.rollNo
	where Class.class_no = @classID
end
go

exec proc_thongtinhocvien_class  'Cl002'
exec proc_thongtinhocvien_class_join  'Cl002'

-- Tạo procedure để xem danh sách điểm danh của lớp học, của môn môn học cụ thể. - đầu vào là mã lớp học và môn học

create proc proc_dsdiemdanh_lophoc_monhoc
@classID nvarchar(10),
@subjectID nvarchar(10),
@rollNo nvarchar(5)
as 
begin

	select Student.fullName, Subject.subjectName SubjectName, Class.className ClassName, Student.rollNo, Attendance.attendanceDate1, Attendance.attendance_no1, Attendance.attendanceDate2 ,   Attendance.attendance_no2
	from  Attendance,Teacher, Class, Student, Subject,Schedule

	where Class.class_no = Schedule.class_no 
				and Subject.subject_no = Schedule.subject_no
				and Student.rollNo = Attendance.rollNo
				and Schedule.id = Attendance.schedule_no
				and Class.class_no = @classID
				and Subject.subject_no = @subjectID
				and Student.rollNo = @rollNo

	group by Student.fullName, Subject.subjectName, Class.className, Student.rollNo, Attendance.attendanceDate1, Attendance.attendance_no1, Attendance.attendanceDate2 ,   Attendance.attendance_no2
end
go

exec proc_dsdiemdanh_lophoc_monhoc  N'Cl001', N'sub 01' , 'R001'






select * from  Student
go

select * from  Teacher
select * from  Student
select * from  Attendance
select * from  Class
select * from  ClassMember
select * from  Schedule
select * from  Subject

drop table Student
drop table Teacher
drop table Class
drop table ClassMember
drop table Schedule
drop table Attendance
drop table Subject



create proc proc_test
@classID nvarchar(10),
@subjectID nvarchar(10),
@rollNo nvarchar(5)
as 
begin

	select Student.fullName, Subject.subjectName SubjectName, Class.className ClassName, Student.rollNo, Attendance.attendanceDate1, Attendance.attendance_no1, Attendance.attendanceDate2 ,   Attendance.attendance_no2
	from  Attendance,Teacher, Class, Student, Subject,Schedule

	where Class.class_no = Schedule.class_no 
				and Subject.subject_no = Schedule.subject_no
				and Student.rollNo = Attendance.rollNo
				and Schedule.id = Attendance.schedule_no
				and Class.class_no = @classID
				and Subject.subject_no = @subjectID
				and Student.rollNo = @rollNo

end
go

exec proc_test  N'Cl001', N'sub 01' , 'R001'


select * from Student

-- Trigger khong cho phep sua RollNo
create trigger trigger_no_update_rollno_student on Student
for update
as
begin
	if update(rollNo)
	begin
		print N'Khong cho phep update rollno'
		rollback transaction
	end
end



update Student set rollNo = 'R0010' where rollNo = 'R001'
go

-- Trigger check Gender
select * from Student
update Student set gender = '123', nativeLand = 'Thanh Hoa' where rollno = 'R001'
update Student set fullname = 'TRAN VAN KHaccccc' where rollno = 'R007'
update Student set gender = '123' where rollno = 'R007'

select * from Student

create trigger trigger_check_update_gender_student on Student
for update
as
begin
	if (select count(gender) from inserted where gender not in ('Nam', 'Nu', 'Khac')) > 0
	begin
		print N'Yeu cau gioi tinh phai nhan 1 trong cac gia tri sau Nam, Nu, Khac'
		rollback transaction
	end
end

alter trigger trigger_check_update_gender_student on Student
for update
as
begin
	-- update Student set fullname = 'TRAN VAN X' where rollno = 'R007'
	-- gender => khong ton tai query tren => inserted
	if (select count(gender) from inserted where gender in ('Nam', 'Nu', 'Khac')) = 0
	begin
		print N'Yeu cau gioi tinh phai nhan 1 trong cac gia tri sau Nam, Nu, Khac'
		rollback transaction
	end
end

-- Trigger cho phép xoá sinh viên theo rollno
----- rollno trong bang Student => tao khoa ngoai (foreign key) tren nhung bang nao
-------- ClassMember, Attendance => Neu xoa ban nghi tren ClassMember & Attendance => thi co
----------------- bi error khong??? Khong co foreign key toi cac bang khac
create trigger InsteadOf_Delete_Rollno_Student on Student
instead of delete
as
begin
	delete from ClassMember where rollno in (select rollno from deleted)
	delete from Attendences where rollno in (select rollno from deleted)
	delete from Student where rollno in (select rollno from deleted)
end

select * from Student

delete from Student where rollno = 'R005'
