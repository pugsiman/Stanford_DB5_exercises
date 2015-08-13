--Q1
select H2.name
from Highschooler H1, Highschooler H2, Friend
where H1.ID = Friend.ID1 and H1.name = 'Gabriel' and H2.ID = Friend.ID2;

--Q2
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Highschooler H2, Likes
where H1.ID = Likes.ID1 and H1.grade >= (H2.grade + 2) and H2.ID =  Likes.ID2;

--Q3
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Highschooler H2, (select L1.ID1, L1.ID2
    from Likes L1, Likes L2 
    where L1.ID1 = L2.ID2 and L1.ID2 = L2.ID1) P
where H1.ID = P.ID1 and H2.ID = P.ID2 and H1.name < H2.name;

--Q4
select name, grade
from Highschooler, Likes
where Highschooler.ID not in (select Likes.ID1 from Likes union select Likes.ID2 from Likes)
group by name
order by grade, name;

--Q5
select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Highschooler H2, Likes
where H1.ID = Likes.ID1 and H2.ID = Likes.ID2 and H2.ID not in (select ID1 from Likes);


--Q6
select name, grade
from Highschooler
where ID not in (
  select ID1 from Highschooler H1, Friend, Highschooler H2
  where H1.ID = Friend.ID1 and Friend.ID2 = H2.ID and H1.grade <> H2.grade)
order by grade, name;


--Q7
select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Highschooler H2, Highschooler H3, Friend F1, Friend F2, Likes
where H1.ID = Likes.ID1 and H2.ID = Likes.ID2 and H2.ID not in 
(select ID2 from Friend where H1.ID = ID1)
and H3.ID = F1.ID1 and H1.ID = F1.ID2
and H3.ID = F2.ID1 and H2.ID = F2.ID2;

--Q8
select stdnt.num-names.num from 
(select count(*) as num from Highschooler) as stdnt,
(select count(distinct name) as num from Highschooler) as names;

--Q9
select name, grade
from (select ID2, count(ID2) as numLiked from Likes group by ID2), Highschooler
where numLiked > 1 and ID2 = ID;
