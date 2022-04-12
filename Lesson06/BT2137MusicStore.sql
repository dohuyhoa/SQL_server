create database BT2137_Musicstrore
go

use BT2137_Musicstrore
go

create table MusicType (
	TypeId int primary key identity(1,1),
	Name nvarchar(50) not null,
	Description nvarchar(100)
)
go

create table Album (
	AlbumID varchar(20) primary key,
	Title nvarchar(100) not null,
	TypeId int references MusicType (TypeId),
	Artists nvarchar(100),
	Rate int default 0,
	check ( Rate <= 5)
)
go

create table Song(
	SongID int primary key identity(1,1),
	AlbumID varchar(20) references Album (AlbumID),
	SongTitle nvarchar(200) not null,
	Artists nvarchar(50),
	Author nvarchar(50),
	Hits int,
	check (Hits >= 0)
)
go

create index IX_SongTitle 
on Song (SongTitle);

create index IX_Artists on Album (Artists);
go

--insert data
insert into MusicType(Name, Description)
values
('Pop', 'genre of popular music that produces the most hits'),
('EDM', 'EDM is also known as dance music'),
('House', 'genre of electronic music characterized by repetitive beat')

go


drop table MusicType
drop table Album
drop table Song

insert into Album (AlbumID,Title, TypeId, Artists, Rate)
values
('1', 'MomentEP', 1, 'Peggy Gou', 4),
('2', 'Justice', 2, 'Justin Bieber', 2),
('3', 'Motion', 3, 'Calvin Harris', 3),
('4', 'Night', 1, 'G-Dragonh', 5),
('5', 'Goodbye Swallow', 2, 'Tran Tien', 4)
go

insert into Album (AlbumID,Title, TypeId, Artists, Rate)
values
('6', 'To do do ', 1, 'Black Pink', 5),
('7', 'Baby', 3, 'Justin Bieber',5 )
go

insert into Song(AlbumID, SongTitle, Artists, Author, Hits)
values 
('1', 'Peaches', 'Justin Bieber', 'Michelle', 10000),
('2', 'Han Pan', 'Peggy Gou', 'Peggy Gou', 434847),
('3', 'Summer', 'Calvin Harris', 'Calvin Harris', 4447),
('4', 'Random', 'Duc Anh', 'Chris', 12),
('5', 'Chim Bo Cau', 'Dong Nhi', 'Tran Tien', 334),
('5', 'Mat Nai', 'O Cao Thang', 'Tran Tien', 12)
go


select * from MusicType
select * from Album
select * from Song

select AlbumID, Title, TypeId, Artists, Rate 
from Album where Rate =5
go

select Album.title, Song.SongID, Song.SongTitle 
from Song, Album
where Song.AlbumID = Album.AlbumID and Album.title = 'Night'
go

--create view
create view v_Albums 
as
select Album.AlbumID, Album.Title, MusicType.Name, Album.Rate
from Album, MusicType
where Album.TypeId = MusicType.TypeId
go

select * from v_Albums

create view v_TopSong_hits
as
select top 3 Album.AlbumID, Album.Title, MusicType.Name, Album.Rate, Song.Hits
from Album, MusicType,Song
where Album.TypeId = MusicType.TypeId and Song.AlbumID = Album.AlbumID
Order by Song.Hits desc
go

select * from v_TopSong_hits
go
---tao proc 
create proc sp_ChangeHits
@SongArtsts  nvarchar(200)
as
begin
	select Song.SongTitle, Album.Title, MusicType.Name, Song.Artists
	from Album, MusicType, Song
	where Album.TypeId = MusicType.TypeId and Song.AlbumID = Album.AlbumID and Song.Artists = @SongArtsts
end
go

exec sp_ChangeHits 'Duc Anh'
go

create proc sp_changeHits
@SongTitle nvarchar(200),
@Hits int
as
begin
	select Song.SongTitle, Album.Title, MusicType.Name, Song.Artists, Song.Hits
	from Album, MusicType, Song
	where Album.TypeId = MusicType.TypeId and Song.AlbumID = Album.AlbumID and Song.Artists = @SongTitle and Song.Hits = @Hits
end
go

exec sp_changeHits 'Duc Anh', 12

--proc update
create proc sp_changeHits_update
@SongID nvarchar(200),
@Hits int
as
begin
	select  * from Song 
	where Song.SongID = @SongID and Song.Hits  = @Hits
end
go

exec sp_changeHits_update 4, 12