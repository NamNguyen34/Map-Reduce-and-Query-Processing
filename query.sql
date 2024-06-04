--Formatting output 
SET PAGESIZE 1000
SET LINESIZE 200
SET HEADING ON
SET UNDERLINE '-'
SET ECHO ON

--Redirect output to a specific file
SPOOL top_movies_output.txt

--Retrieve movie titles from the imdb00.TITLE_BASICS table (alias as tb) and their average ratings from the imdb00.TITLE_RATINGS table (alias as tr)
SELECT tb.PRIMARYTITLE AS "Movie Title", tr.AVERAGERATING AS "Average Rating"
FROM imdb00.TITLE_BASICS tb
--Join the two tables (based on their shared attribute) where the title type is 'movie', the release year is between 2001 and 2010,
--the number of votes is at least 150000, the genre combination is 'Action' and 'Thriller'
JOIN imdb00.TITLE_RATINGS tr ON tb.TCONST = tr.TCONST
WHERE tb.TITLETYPE = 'movie'
AND tb.STARTYEAR BETWEEN '2001' AND '2010'
AND tr.NUMVOTES >= 150000
AND tb.GENRES LIKE '%Action%'
AND tb.GENRES LIKE '%Thriller%'
--Order the results retrieved by the average rating in a descending order
ORDER BY tr.AVERAGERATING DESC
--Fetch only the top 5 results 
FETCH FIRST 5 ROWS ONLY;

--EXPLAIN statement to explain the query plan
EXPLAIN PLAN
FOR
SELECT tb.PRIMARYTITLE AS "Movie Title", tr.AVERAGERATING AS "Average Rating"
FROM imdb00.TITLE_BASICS tb
JOIN imdb00.TITLE_RATINGS tr ON tb.TCONST = tr.TCONST
WHERE tb.TITLETYPE = 'movie'
AND tb.STARTYEAR BETWEEN '2001' AND '2010'
AND tr.NUMVOTES >= 150000
AND tb.GENRES LIKE '%Action%'
AND tb.GENRES LIKE '%Thriller%'
ORDER BY tr.AVERAGERATING DESC
FETCH FIRST 5 ROWS ONLY;

--Display the query plan
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SPOOL OFF