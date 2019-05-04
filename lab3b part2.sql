create database scholarship_lab3bb
use scholarship_lab3bb 

create table application (studentid int, date date, state varchar(20) default null);
create table course (courseid int, title varchar(20), credits int);
create table ranking (studentid int, average int, credits int, rank int);
create table exam (courseid int, studentid int, date date, grade int);

drop table application
drop table course
drop table ranking
drop table exam

/*Нийт 50-с дээш кредитийн шалгалт өгсөн, 90% дээш дундаж дүнтэй оюутанд тэтгэглэг өгдөг.
Дараах триггерүүдийг бичнэ үү.*/

/*1.Хэрвээ шаардлага биелэхгүй бол хүсэлт (application)–г автоматаар цуцалдаг, бусад
тохиолдолд хүсэлтийг хүлээн авдаг. Аль ч тохиолдолд application-ны
stateбаганы утга(эхэндээ null байна)–г “rejected” эсвэл “accepted” болгон өөрчил.*/

create trigger tr1 on application
after insert
as begin
   if exists (select * from inserted where studentid in (select studentid from ranking where average>=90 and credits>=50) )
   update application set state='accepted' where studentid in (select studentid from ranking where average>=90 and credits>=50) 
   else if exists(select * from inserted where studentid in (select studentid from ranking where average<90 or credits<50)) 
   update application set state='rejected' where studentid in (select studentid from ranking where average<90 or credits<50) 
end

drop trigger tr1
select* from ranking       select* from application
insert into ranking values(1111,92,60,null);
insert into ranking values(2222,88,48,null);
insert into ranking values(3333,91,50,null);
insert into ranking values(4444,90,51,null);

insert into application values(1111,'01-01-2019',null);
insert into application values(2222,'11-11-2019',null);
insert into application values(3333,'03-21-2019',null);
insert into application values(4444,'02-12-2019',null);


delete from ranking
delete from application


/*2.Хүлээн авсан тохиолдолд тухайн оюутны дундаж оноонд тулгуурлан эрэмбэлж,
Ranking хүснэгтэд нэг байрлал онооно. Дундаж оноо тэнцсэн тохиолдолд цуглуулсан кредитын
тоогоор, энэ тоо тэнцвэл хүсэлт илгээсэн огноогоор эрэмбэлнэ.*/


drop trigger tr2



Create trigger tr2
on application
after update as
begin
update RANKING set Rank = Rank+1  where Rank >(select count(*) from RANKING where( Average > (select Average from inserted)) OR
 (Average = ( select Average from inserted) AND Credits > (select Credits from inserted)) OR
 (Average = (select Average from inserted) AND Credits = (select Credits from inserted))) ;
update RANKING set Rank = (select count(*) from RANKING where( Average > (select Average from inserted)) OR
 (Average = ( select Average from inserted) AND Credits > (select Credits from inserted)) OR
 (Average = (select Average from inserted) AND Credits = (select Credits from inserted))) + 1 where StudentID =(select StudentID from inserted);
end



