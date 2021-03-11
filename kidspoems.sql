-- 1: What grades are stored in the database?
select grade.Name
from grade

--2: What emotions may be associated with a poem?
select emotion.Name
from Emotion

--3:How many poems are in the database?
SELECT COUNT(p.Id) FROM Poem p

--4:Sort authors alphabetically by name. What are the names of the top 76 authors?
select top 76 Author.Name
from Author
group by Author.Name

-- 5: Starting with the above query, add the grade of each of the authors.
-- Order of Operations: from & join goes and gets the tables then looks at where/ having etc, then orders the info then selects the columns to display, then top
select top 76 Author.Name, Grade.Name, Grade.Id, Author.GradeId
from Author
join Grade on Author.GradeId = Grade.Id
where Grade.Id = Author.GradeId
order by Author.Name

-- 6: Starting with the above query, add the recorded gender of each of the authors.
select top 76 Author.Name, Grade.Name as Grade, Gender.Name as Gender
from Author
join Grade on Author.GradeId = Grade.Id
join Gender on Author.GenderId = Gender.Id
where Grade.Id = Author.GradeId
order by Author.Name

--7: What is the total number of words in all poems in the database?
SELECT COUNT(p.WordCount)as totalWords FROM Poem p

--8: Which poem has the fewest characters?
Select *
from Poem 
order by Poem.CharCount

--9: How many authors are in the third grade?
Select count(Author.GradeId) as AuthorGradeId, Grade.Name
from Author
join Grade on author.GradeId = Grade.Id
group by Author.GradeId, Grade.Id, Grade.Name
having Grade.Id = author.GradeId

--How many authors are in the first, second or third grades?
Select count(Author.GradeId) as AuthorGradeId, Grade.Name
from Author
join Grade on author.GradeId = Grade.Id
where Grade.Id < 4
group by Author.GradeId, Grade.Id, Grade.Name

--11:What is the total number of poems written by fourth graders?
Select count(Poem.Id) as Numberof4thGradePoems
from Poem
join Author on Poem.AuthorId = Author.Id
join Grade on Author.GradeId = Grade.Id
where  Grade.Name = '4th Grade'

-- this group by on 11 will make it not be able to filter the single line
-- group by poem.AuthorId, Grade.Id, Grade.Name, Author.GradeId

--12: How many poems are there per grade?
Select count(Poem.Id) as NumberofPoemsPerGrade, Grade.Name
from Poem
join Author on Poem.AuthorId = Author.Id
join Grade on Author.GradeId = Grade.Id
group by grade.Name


--13: How many authors are in each grade? (Order your results by grade starting with 1st Grade)
Select count(Author.Id) as NumberofAuthPerGrade, Grade.Name
from Author
join Grade on Author.GradeId = Grade.Id
group by grade.Name

--14: What is the title of the poem that has the most words?
Select top 1 poem.WordCount, Poem.Title
from Poem
order by poem.WordCount desc 

--15: Which author(s) have the most poems? (Remember authors can have the same name.)
Select top 5
count(poem.AuthorId), Author.Name, AuthorId
from Author
join poem on AuthorId = Poem.AuthorId
where poem.AuthorId = Author.Id
--group by Author.Name
--order by poem.AuthorId desc , Author.Name, Author.Id


--16:How many poems have an emotion of sadness?
select Emotion.Name, count (Emotion.Id) as sadEmoPoems
from PoemEmotion
join Emotion on PoemEmotion.EmotionId = Emotion.Id
where Emotion.Id = 3 
group by Emotion.Name

-- 17: How many poems are not associated with any emotion? 
-- I THINK ITS ZERO BC NULL NOT ALLOWED--- CHECK FOR NULL?
-- is the answer zero or would you count the number of poems and compare it to the number of poem ids on Poem emotions
select count (PoemEmotion.PoemId)poemsWEmotion
from PoemEmotion
select count (Poem.Id)
from Poem



--18: Which emotion is associated with the least number of poems?
--19: Which grade has the largest number of poems with an emotion of joy?
--20: Which gender has the least number of poems with an emotion of fear?