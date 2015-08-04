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

--Q6

--Q7

--Q8

--Q9