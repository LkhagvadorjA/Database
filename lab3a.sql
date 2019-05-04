/*Key Constraints*/
/*1.mID is a key for Movie*/
alter table movie alter column mID int not null

alter table movie
add constraint pk_movie primary key (mID)                                alter table rating drop constraint pk_movie



/*2.(title,year) is a key for Movie*/
alter table movie alter column title nvarchar(30) not null
alter table movie alter column year int not null

alter table movie
add constraint title_year_pk unique(title, year)                         alter table rating drop constraint title_year_pk

/*3.rID is a key for Reviewer*/
alter table reviewer alter column rID int not null

alter table reviewer
add constraint rID_pk primary key (rID)                                  alter table rating drop constraint rID_pk

/*4.(rID,mID,ratingDate) is a key for Rating but with null values allowed
*/
alter table rating alter column rID int null
alter table rating alter column mID int null
alter table rating alter column ratingDate date null

alter table rating
add constraint rID_mID_rD_rating unique (rid,mID,ratingDate)             alter table rating drop constraint rID_mID_rD_rating


alter table Rating
add constraint rating_foreign foreign key (mID) references Movie(mID)
   

                                                                          alter table rating drop constraint rating_foreign
/*Non-Null Constraints*/
/*5.Reviewer.name may not be NULL*/
alter table reviewer alter column name nvarchar(30) not null

/*6.Rating.stars may not be NULL*/
alter table rating alter column stars int not null

/*Attribute-Based Check Constraints*/
/*7.Movie.year must be after 1900*/
alter table movie add check (year>1900)

/*8.Rating.stars must be in {1,2,3,4,5}*/
alter table rating add check(stars between 1 and 5)

/*9.Rating.ratingDate must be after 2000*/
alter table rating add check(ratingDate>'2000')

/*Tuple-Based Check Constraints*/
/*10."Steven Spielberg" movies must be before 1990 and "James Cameron" movies must be after 1990*/
select * from movie

alter table movie add constraint check10 check( (year<1990 and director='Steven Spielberg') or (year>1990 and director='James Cameron') or (director!='James Cameron' and director!='Steven Spielberg'))

alter table rating drop constraint check10

/*Task 3*/


/*11*/ update Movie set mID = mID + 1;
/*12*/ insert into Movie values (109, 'Titanic', 1997, 'JC');
/*13*/ insert into Reviewer values (201, 'Ted Codd');
/*14*/ update Rating set rID = 205, mID = 104;
/*15*/ insert into Reviewer values (209, null);
/*16*/ update Rating set stars = null where rID = 208;
/*17*/ update Movie set year = year-40;
/*18*/ update Rating set stars = stars + 1;
/*19*/ insert into Rating values (201, 101, 1, '1999-01-01');
/*20*/ insert into Movie values (109, 'Jurassic Park', 1993, 'Steven Spielberg');
/*21*/ update Movie set year = year-10 where title = 'Titanic';

/*22*/ insert into Movie values (109, 'Titanic', 2001, null);     
/*23*/ update Rating set mID= 109;
/*24*/ update Movie set year = 1901 where director <> 'James Cameron';
/*25*/ update Rating set stars = stars-1;
/*26.Referential integrity from Rating.rID to Reviewer.rID
Reviewers updated: cascade
Reviewers deleted: set null
All others: error*/
alter table rating
add constraint fk_26 foreign key (rID) references Reviewer(rID)
On update cascade
On delete set null
                                                                       alter table rating drop constraint fk_26

alter table Rating
add constraint rating_foreign foreign key (mID) references Movie(mID)
on delete cascade
   

                                                                          alter table rating drop constraint rating_foreign
/*27*/insert into Rating values (209, 109, 3, '2001-01-01');
/*28*/update Rating set rID = 209 where rID = 208;
/*29*/update Rating set mID = mID + 1;
/*30*/update Movie set mID = 109 where mID = 108;

/*31*/ update Movie set mID = 109 where mID = 102;
/*32*/ update Reviewer set rID = rID + 10;
/*33*/ delete from Reviewer where rID > 215
/*34*/ delete from Movie where mID < 105;