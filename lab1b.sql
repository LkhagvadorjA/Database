N1

select reviewer.name, movie.title, rating.stars, rating.RatingDate
from reviewer, movie, rating
where reviewer.rID=rating.rID
and rating.mID=movie.mID

N2

select re.name, mo.title, r2.rID, r1.stars
from reviewer re, movie mo, rating r1, rating r2
where r1.mID=mo.mID and r1.rID=re.rID and r1.mID=r2.mID

group by r1.rID, r1.mID

and r1.ratingDate>r2.ratingDate and r1.stars=r2.stars


(select Reviewer.name, Movie.title
from rating
inner join Movie on Movie.mID=Rating.mID
inner join Reviewer on Reviewer.rID=Rating.rID
group by rating.mid,rating.rid,Reviewer.name, Movie.title
having count(rating.mid)>=2 and count(rating.rid)>=2 and rating.mid in
(select r1.mid
from rating r1, rating r2
where r1.mid>=2 and r1.mid=r2.mid and 
R1.ratingDate<r2.ratingDate and r1.stars<r2.stars));


N3

select movie.title, max(rating.stars)
from movie, rating
where movie.mID=rating.mID
and movie.mID in(select mID from rating)
group by movie.title
order by movie.title

N4

select movie.title, max(rating.stars)-min(rating.stars) as tarhalt
from movie, rating
where movie.mID=rating.mID
group by movie.title
order by movie.title desc, tarhalt

N5

select avg(rating.stars)
from rating, movie
where rating.mID=movie.mID
and year>1980

select avg(rating.stars)
from rating, movie
where rating.mID=movie.mID
and year<1980


select (select avg(rating.stars)
from rating, movie
where rating.mID=movie.mID
and year<1980)-(select avg(rating.stars)
from rating, movie
where rating.mID=movie.mID
and year>1980)