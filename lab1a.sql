N1

select *
from Movie
where director='Steven Spielberg'

N2

select rating.stars, movie.year
from rating, movie
where rating.mID=movie.mID
and rating.stars=4 or rating.stars=5 
order by movie.year asc

N3

select title
from Movie
where mID not in (select mID from rating )