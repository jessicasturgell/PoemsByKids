--Query the PoKi database using SQL SELECT statements to answer the following questions.

--What grades are stored in the database?
SELECT *
FROM Grade;

--What emotions may be associated with a poem?
SELECT *
FROM Emotion;

--How many poems are in the database?
SELECT COUNT(p.Id) AS 'Number of Poems'
FROM Poem p;

--Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 a.Name
FROM Author a
ORDER BY Name;

--Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 a.Name, g.Name
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
ORDER BY a.Name;

--Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 a.Name, g.Name, gn.Name
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
JOIN Gender gn
ON a.GenderId = gn.Id
ORDER BY a.Name;

--What is the total number of words in all poems in the database?
SELECT SUM(p.WordCount) AS 'Number of Total Words'
FROM Poem p;

--Which poem has the fewest characters?
SELECT TOP 1 p.Title, p.CharCount
FROM Poem p
ORDER BY p.CharCount;

--How many authors are in the third grade?
SELECT a.Name, g.Name
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Id = 3
ORDER BY a.Name;

--How many total authors are in the first through third grades?
SELECT COUNT(a.Id) AS 'Total Authors in Grades 1-3'
FROM Author a
WHERE a.GradeId = 1 OR a.GradeId = 2 OR a.GradeId = 3;

--What is the total number of poems written by fourth graders?
SELECT COUNT(p.Id) AS 'Total Poems Written By Fourth Graders'
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE a.GradeId = 4;

--How many poems are there per grade?
SELECT g.Name, COUNT(p.Id) AS 'Poems Per Grade'
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
LEFT JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name;

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT g.Name, COUNT(a.Id) AS 'Authors Per Grade'
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name;

--What is the title of the poem that has the most words?
SELECT TOP 1 p.Title, p.WordCount
FROM Poem p
ORDER BY p.WordCount DESC;

--Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT a.Id, a.Name, COUNT(p.Id) AS 'Poems By Author'
FROM Poem p
JOIN Author a
ON p.AuthorId = a.Id
WHERE p.AuthorId = a.Id
GROUP BY a.Id, a.Name
ORDER BY COUNT(p.Id) DESC;

--How many poems have an emotion of sadness?
SELECT COUNT(e.Id) AS 'Poems Associated With Sadness'
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
WHERE e.Name = 'Sadness';

--How many poems are not associated with any emotion?
SELECT COUNT(*) AS NoEmotionPoemCount
FROM Poem p
LEFT JOIN PoemEmotion pe
ON p.Id = pe.PoemId
WHERE pe.PoemId IS NULL;

--Which emotion is associated with the least number of poems?
SELECT e.Name, COUNT(*) AS 'Poems Associated With Each Emotion'
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
GROUP BY e.Name;

--Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1 g.Name, COUNT(e.Id) AS 'Poems Associated With Joy'
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
JOIN Author a
ON p.AuthorId = a.Id
JOIN Grade g
ON g.Id = a.GradeId
WHERE e.Name = 'Joy'
GROUP BY g.Name
ORDER BY COUNT(e.Id) DESC;

--Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1 g.Name, COUNT(e.Id) AS 'Poems Associated With Fear'
FROM Poem p
JOIN PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON pe.EmotionId = e.Id
JOIN Author a
ON p.AuthorId = a.Id
JOIN Grade g
ON g.Id = a.GradeId
WHERE e.Name = 'Fear'
GROUP BY g.Name
ORDER BY COUNT(e.Id);