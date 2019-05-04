﻿/*7. А, В сурагчид өөр хоорондоо найз биш хэдийч А сурагч В сурагчид дуртай 
бөгөөд тэд 2-уул С сурагчтай найз бол А,В,С гурвалын нэр ангийг харуул.*/

SELECT DISTINCT hs1.name, hs1.grade, hs2.name, hs2.grade, hs3.name, hs3.grade
FROM highschooler AS hs1, highschooler AS hs2, highschooler AS hs3, friend AS f, likes AS l
WHERE hs1.id = l.id1 AND hs2.id = l.id2
AND hs1.id NOT IN (SELECT friend.id2 FROM friend WHERE friend.id1 = hs2.id)
AND hs3.id IN (SELECT friend.id2 FROM friend WHERE friend.id1 = hs1.id)
AND hs3.id IN (SELECT friend.id2 FROM friend WHERE friend.id1 = hs2.id);


select DISTINCT  h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from Highschooler h1, Highschooler h2, Highschooler h3, Friend f, Likes l
where h1.ID=l.ID1 and h2.ID=l.ID2
and h2.ID not in (select id2 from Friend where id1=h1.ID)
and h3.ID in (select id2 from Friend where id1=h1.ID)
and h3.ID in (select id2 from Friend where id1=h2.ID)

--8. Уг сургуулийн хүүхдүүдийн тоо болон ялгаатай нэрний тооны зөрүүг ол.


select count(id)-(select count(name)
from (select name
from Highschooler
group by name) as h
)
from highschooler

--9. Хэрвээ тухайн нэг сурагчид нэгээс олон сурагч дуртай бол уг сурагчийн нэр ангийг харуул.

select name, count(name)
from Highschooler h1, likes l
where h1.id=l.ID2
group by name
having count(name)>1

/*10. Хэрвээ сурагч А нь сурагч В-д дуртай, 
харин Сурагч В сургагч С-д дуртай бол эдгээр сурагчдын анги нэрийг харуул.*/

 
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Highschooler H1, Highschooler H2, Highschooler H3, Likes L1, Likes L2
WHERE H1.ID = L1.ID1 AND H2.ID = L1.ID2 AND H2.ID = L2.ID1 AND H3.ID = L2.ID2 AND H3.ID != H1.ID

 --11. Бүх найзууд нь өөр ангид суралцдаг сурагчдын нэр ангийг харуул. !!!!!!!!!!!!!

select name, grade
from Highschooler
where id  not in (select ID1
from Highschooler h1, Highschooler h2, Friend f 
where h1.ID=f.ID1 and h2.ID=f.ID2
and h1.grade=h2.grade )

--12. Оюутануудын найзуудын дундаж хэд вэ? Хариулт нэг тоо гарна.

select avg(friend.total) as average_number_of_friend
from ( select count(id1) as total
from Friend
group by id1) as friend

--Cassandra-н найзууд, мөн түүний найзуудтай найз байх оюутнуудын тоог олно уу. Cassandra -г энэ тоонд оруулахгүй.

 select count(id2)
 from (select id2
from friend
where id1 in (select id from Highschooler where name='Cassandra')
union 
select id2
from friend
where id1 in (select id2
from friend
where id1 in (select id from Highschooler where name='Cassandra')
 )
 and id2 not in (select id from Highschooler where name='Cassandra')) as total

 --14. Хамгийн олон найзтай оюутанг олно уу.







select h1.name, h1.grade, COUNT(f.ID2)
from Highschooler h1, Friend f
where h1.ID=f.ID1
group by h1.name, h1.grade
having COUNT(f.ID2) = (
select max(counted)
from (select ID1, COUNT(ID2) as counted
from Friend 
group by ID1) as f)