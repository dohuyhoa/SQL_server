create database Quanlygiaovu
go

use Quanlygiaovu
go

create table HOCVIEN (
	MAHV nvarchar(5) primary key,
	HO nvarchar(40),
	TEN nvarchar(10),
	NGSINH smalldatetime,
	GIOITINH nvarchar(4),
	NOISINH nvarchar(50),
	MALOP nvarchar(3),
)
go

alter table HOCVIEN
add constraint fk_MALOP_HOCVIEN foreign key (MALOP) references LOP (MALOP)
go

create table GIAOVIEN(
	MAGV nvarchar(4) primary key,
	HOTEN nvarchar(40),
	HOCVI nvarchar(10),
	HOCHAM nvarchar(10),
	GIOITINH nvarchar(4),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA  nvarchar(4) references  KHOA(MAKHOA)
)
go

create table LOP(
	MALOP  nvarchar(3) primary key,
	TENLOP  nvarchar(40),
	TRGLOP  nvarchar(5),
	SISO tinyint,
	MAGVCN  nvarchar(4)
	)
go

alter table LOP
add constraint fk_GVCN_MAGV foreign key (MAGVCN) references GIAOVIEN (MAGV)
go

create table KHOA(
	MAKHOA nvarchar(4) primary key,
	TENKHOA  nvarchar(40),
	NGTLAP smalldatetime,
	TRGKHOA  nvarchar(4)
)
go


alter table KHOA
add constraint fk_KHOA_MAGV foreign key (TRGKHOA) references GIAOVIEN (MAGV)
go

create table MONHOC(
	MAMH  nvarchar(10) not null primary key,
	TENMH  nvarchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA nvarchar(4)
)
go


alter table KHOA
add constraint fk_KHOA_MONHOC foreign key (MAKHOA) references KHOA (MAKHOA)
go


create table DIEUKIEN(
	MAMH nvarchar(10) references MONHOC(MAMH),
	MAMH_TRUOC nvarchar(10) references MONHOC(MAMH)
)
go


create table GIANGDAY(
	MALOP  nvarchar(3) references LOP (MALOP),
	MAMH  nvarchar(10) references MONHOC (MAMH),
	MAGV  nvarchar(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime
)
go

create table KETQUATHI(
	MAHV nvarchar(5) references HOCVIEN (MAHV),
	MAMH nvarchar(10) references MONHOC (MAMH),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(1,0),
	KQUA nvarchar(5)
	constraint Pk_KQTHI PRIMARY KEY  (MAHV,MAMH,LANTHI)
)
go

---Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ
--HOCVIEN.
alter table HOCVIEN
add GHICHU nvarchar(300)
go

alter table HOCVIEN
add DIEMTB numeric(2,2)
go

alter table HOCVIEN
add XEPLOAI NVARCHAR(20)
go


---Mãhọcviênlàmộtchuỗi5kýtự,3kýtựđầulàmãlớp,2kýtựcuốicùnglàsốthứtựhọc
--viên trong lớp. VD: “K1101”
alter table HOCVIEN 
add constraint CK_MHV check (substring(MAHV,1,3) = MALOP)
go


--Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
alter table HOCVIEN
add constraint check_gioitinh check (GIOITINH in ('Nam', 'Nu'))
go

alter table GIAOVIEN
add constraint check_gioitinh_GIAOVIEN check (GIOITINH in ('Nam', 'Nu'))
go

--  Điểmsốcủamộtlầnthicógiátrịtừ0đến10vàcầnlưuđến2sốlẽ(VD:6.22).
alter table KETQUATHI
add constraint check_kqthi check (DIEM between 0 and 10)
go

---Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “Khong dat” nếu điểm nhỏ hơn 5.
alter table KETQUATHI
add constraint check_ketqua check (KQUA  = 'Dat' and (DIEM >=5 and DIEM <=10) or KQUA = 'khong dat' and (DIEM <5) )
go

--Học viên thi một môn tối đa 3 lần.
alter table KETQUATHI
add constraint check_lanthi check (LANTHI <=3 )
go


---7. Họckỳchỉcógiátrịtừ1đến3.
alter table GIANGDAY
add constraint check_hocky_max check (HOCKY  between 1 and 3)
go

--8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”.

alter table GIAOVIEN
add constraint check_hocvi_GIAOVIEN check (HOCVI IN ('CN' ,  'KS' , 'Ths' , 'TS', 'PTS'))
go

---9. Lớp trưởng của một lớp phải là học viên của lớp đó.

--10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.


--11. Học viên ít nhất là 18 tuổi.
alter table HOCVIEN
add constraint check_HOCVIEN_MINAGE check ((getdate() - NGSINH)  >=18 )
go

---12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY)..
alter table GIANGDAY
add constraint check_GIANGDAY check (TUNGAY < DENNGAY )
go

--13. Giáo viên khi vào làm ít nhất là 22 tuổi.
alter table GIAOVIEN
add constraint check_GIAOVIEN_MINAGE check (year(NGVL) - year(NGSINH)  >= 22 )
go

--14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
alter table MONHOC
add constraint check_MONHOC check (abs(TCLT-TCTH) >= 3 )
go

--15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.
--16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và
MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và
cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”).
19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương
bằng nhau.
20. Học viên chỉ được thi lại (lần thi &gt;1) khi điểm của lần thi trước đó
dưới 5.
21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng
học viên, cùng môn học).
22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học
xong.
23. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước
sau giữa các môn học (sau khi học xong những môn học phải học trước
mới được học những môn liền sau).
24. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên
đó phụ trách.

select * from KHOA
select * from LOP
select * from MONHOC
select * from GIANGDAY
select * from GIAOVIEN
select * from DIEUKIEN
select * from KETQUATHI
select * from HOCVIEN
