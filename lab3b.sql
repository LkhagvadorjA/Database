delete from Highschooler;
/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);


/*1.'Friendly'нэртэй шинэ сурагч нэмэгдвэл түүнийг ангийнхаа бүх сурагчдад дуртай болгох.*/
create trigger trigger_1 on highschooler
for insert
as begin
        if exists(select * from inserted where name='Friendly')
		insert into likes select i.ID, h.ID from inserted i, Highschooler h where i.grade=h.grade and i.ID!=h.ID
end

drop trigger trigger_1
insert into Highschooler values(1111,'Friendly','9');
select* from likes where id1=1111
delete from Highschooler where name='Friendly'
delete from Likes where id1=1111

/*2. Сурагчдын ангийн мэдээллийн зохицуулдаг 2 триггер бич. Хэрвээ шинээр нэмэгдсэн мөрийн анги нь 9-с бага эсвэл 12-с 
их байвал ангийг NULL утгатай болгох. Хэрвээ нэмэгдэж орсон мөрийнанги нь NULL байвал түүнийг 9 болох.*/

create trigger t2 on highschooler 
after insert
as begin
   if exists(select * from inserted where grade not between 9 and 12)
   update Highschooler set grade=null where grade not between 9 and 12
   else if exists (select * from inserted where grade is null)
   update Highschooler set grade=9 where grade is null
end

drop trigger t2

select * from Highschooler where id=9999
insert into Highschooler values(7777,'hoho',null); 
insert into Highschooler values(9999,'haha',8);   
insert into Highschooler values(8888,'hehe',13);   


 delete from Highschooler where id=9999
 delete from Highschooler where id=8888
 delete from Highschooler where id=7777


 /*3. Сурагчдын анги 12-с их болж өөрчлөгдөхөд HIghschooler-с устгаж
Highschooler_history хүснэгтэд нэмэх. Хэрвээ нэг сурагч анги дэвшвэл түүний найзуудыг ч мөн дэвшүүлэх.*/
select * from highschooler
create table highschooler_history (id int, name varchar(40),grade int);
drop table highschooler_history

create trigger t3 on highschooler
after update
as begin
   if exists(select * from Highschooler where grade>12)
   insert into highschooler_history select * from Highschooler where grade>13
   delete from Highschooler where grade>13
   if exists(   select * from Highschooler where id in  (select id2 from Friend where id1 in (select id1 from Highschooler where grade>13)  )   )
   insert into highschooler_history select * from Highschooler where grade>13
   delete from Highschooler where grade>13
end

drop trigger t3
select * from Highschooler    select * from highschooler_history     select * from friend
insert into Highschooler values(1111, 'Boldoo', 12)
insert into highschooler values(2222, 'Tsetsgee', 12);
insert into Friend values(1111, 2222);

update Highschooler set grade=grade+1 where id=1111;

delete from highschooler_history
delete from Highschooler where id=1111
delete from Highschooler where id=2222
delete from Friend where id1=1111
delete from Friend where id2=2222
/*4. Найзын харьцааны тэгш хэмтэй байдлыг хадгалах триггерүүдийг бичнэ үү. Жишээлбэл, хэрвээ(A,
B) Friend-с хасагдвал (B,A) ч мөн хасагдах, шинээр нэмэгдэх үед мөн адил. Найзын харьцаанд
Update хийгдэхгүй гэж үзнэ.*/

create trigger t4 on friend
for insert, delete
as begin
   if exists(select * from deleted where id1 in (select id2 from Friend))
   delete from Friend where id1 in (select id2 from deleted)
   else if exists(select * from inserted where id1 in (select id1 from Friend))
   insert into Friend values((select id2 from Friend where id1 = (select id1 from inserted)),
    (select id1 from Friend where id1 = (select id1 from inserted)))
end

drop t4
select * from Friend
insert into Friend values (1111, 2222);
delete from Friend where id1=1111 or id1=2222