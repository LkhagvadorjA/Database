--1. Gabriel нэртэй сурагчтай найзын харицаатай бүх оюутнуудын нэрийг харуулна уу.
select name
from highschooler
where ID in (select id2 from friend where id1 in (
             select id from highschooler where name='Gabriel' )) 
             
--2. Өөрөөсөө 2-оос олон дүү хэн нэгэнд дуртай бүх сурагчдын нэр ангийг болон дуртай  сурагчийнх нь нэр ангийг харуул.

select h1.name, h1.grade, h2.name, h2.grade
from highschooler h1, highschooler h2, Likes l
where h1.ID=l.ID1 and h2.id=l.ID2
and h1.grade-h2.grade>=2      

/*3. Өөр хоорондоо дуртай сурагчдийн хосуудын нэр ангиудыг харуул.
 Нэг хос давхцаж болохгүй ба нэрсийг цагаан толгойн дарааллаар харуулна уу.*/

select h1.name, h1.grade, h2.name, h2.grade
from highschooler h1, highschooler h2, Likes l
where h1.ID=l.ID1 and h2.id=l.ID2 
and l.ID1 in (select ID2 from likes) 
and l.ID2 in (select ID1 from likes) 
and h1.id>h2.id /*h1.name>h2.name*/
order by h1.name asc

--4. Likes хүснэгтэд байхгүй бүх сурагчдын нэрсийг ангитай нь олж, анги, нэрээр эрэмбэлж харуулна уу. 

select name, grade
from Highschooler
where ID not in (select id1 from likes)
and ID not in (select id2 from likes)
order by name, grade

/*5. Сурагч А нь сурагч Б-д дуртай бөгөөд сурагч Б хэнд дуртай талаар мэдээлэл байхгүй 
(Б Likes хүснэгтэд id1 -р бичэгдээгүй) байх бүх тохиолдолыг олж, 
А болон Б-ийн нэр, ангийг нэрээр эрэмбэлж харуулна уу. */

select h1.name, h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2, Likes l
where h1.ID=l.ID1 and h2.ID=l.ID2
and h2.ID not in (select ID1 from Likes)
order by h1.name, h2.name
-- 6. Зөвхөн нэг ижил ангид л найзууд нь байдаг сурагчдын нэр ангийг олж, анги нэрээ эрэмбэлж харуулна уу.

select name,grade
from Highschooler
where id not in ( select id1 from friend, Highschooler h1, Highschooler h2
                 where h1.id=Friend.ID1 and h2.ID=friend.ID2 and h1.grade!=h2.grade)






