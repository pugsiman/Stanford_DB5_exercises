--Q1
-- Find the titles of all movies directed by Steven Spielberg
select title
from Movie
where director = 'Steven Spielberg';

--Q2
-- Find all years that have a movie that received a rating of 4 or 5, 
-- and sort them in increasing order. 
select distinct year
from Movie, Rating
where Movie.mID = Rating.mID and stars >= '4';

--Q3
-- Find the titles of all movies that have no ratings.
select title
from Movie
where mID not in (select mID from Rating);

--Q4
-- Find the names of all reviewers who have ratings with a NULL value for the date. 
select name
from Reviewer, Rating
where Reviewer.rID = Rating.rID and ratingDate is null;

--Q5
-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
select name, title, stars, ratingDate
from Movie, Rating, Reviewer
where Movie.mID = Rating.mID and Reviewer.rID = Rating.rID
order by name, title, stars;

--Q6
-- For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
select name, title
from Movie, Reviewer, (select R1.rID, R1.mID from Rating R1, Rating R2 where
R1.rID = R2.rID
 and R1.mID = R2.mID
 and R1.stars < R2.stars
 and R1.ratingDate < R2.ratingDate) N
where Movie.mID = N.mID and Reviewer.rID = N.rID;

--Q7
--For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. 
select title, MAX(stars)
from (select * from Movie join Rating on Movie.mID = Rating.mID)
group by mID
order by title;

--Q8
--For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 
select title, mx-mn
from (select title, max(stars) as mx, min(stars) as mn from Movie, Rating 
where Movie.mID = Rating.mID group by title) N
order by mx-mn desc;

--Q9
--Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) 

--Using absolute here in case the averages spread is a negative number
select abs(aftr - bfr)
--Differing between two tables with single value which will represent each the average rating of movies (in which each one of them is the average of couple of ratings) before and after 1980.
from(
	--Creating the table that has the average rating of average ratings of movies before 1980.
	select avg(avgRating) as bfr 
	from(
	--Creating the table that has the average ratings before 1980.
	select avg(stars) as avgRating
	from Rating, Movie
	where Movie.mID = Rating.mID and year < 1980
	group by title)
)
,
(
	--Creating the table that has the average rating of average ratings of movies after 1980.
	select avg(avgRating) as aftr
	from(
	--Creating the table that has the average ratings of movies after 1980.
	select avg(stars) as avgRating
	from Rating, Movie
	where Movie.mID = Rating.mID and year > 1980
	group by title)
)

