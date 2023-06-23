
----1-----Retrieve the average ratings of the movies for each year from 2010 to 2015. Consider the movies having Drama, Horror, Sci-Fi or Thriller as one of their genres.

SELECT 
	tt_bs.STARTYEAR AS YEAR, 
	ROUND(AVG(tt_rt.AVERAGERATING),8) AS YEARLY_AVG
FROM TITLE_BASICS tt_bs 
	  JOIN TITLE_RATINGS tt_rt ON tt_bs.TCONST = tt_rt.TCONST 
WHERE TITLETYPE = 'movie'
		AND tt_bs.STARTYEAR > '2009' AND tt_bs.STARTYEAR < '2016' 
		AND (GENRES LIKE '%Drama%' OR GENRES LIKE '%Horror%' OR GENRES LIKE '%Sci-Fi%' OR GENRES LIKE '%Thriller%')
GROUP BY tt_bs.STARTYEAR ORDER BY tt_bs.STARTYEAR;



-----2-------Retrieve the average ratings of the movies by genre for each year during 2010 and 2015 for each genre, Drama, Horror, Sci-Fi and Thriller.


SELECT 	YEAR,	GENRE,	YEARLY_AVG
FROM (
	SELECT 		tt_bs.STARTYEAR AS YEAR, 'Drama' AS GENRE,AVG(tt_rt.AVERAGERATING) AS YEARLY_AVG
	FROM TITLE_BASICS tt_bs 
		JOIN TITLE_RATINGS tt_rt ON tt_bs.TCONST = tt_rt.TCONST 
	WHERE TITLETYPE = 'movie'
			AND tt_bs.STARTYEAR > '2009' AND tt_bs.STARTYEAR < '2016' 
			AND GENRES LIKE '%Drama%' 
	GROUP BY tt_bs.STARTYEAR
	UNION 
	SELECT 
		tt_bs.STARTYEAR AS YEAR,'Horror' AS GENRE,AVG(tt_rt.AVERAGERATING) AS YEARLY_AVG
	FROM TITLE_BASICS tt_bs JOIN TITLE_RATINGS tt_rt ON tt_bs.TCONST = tt_rt.TCONST 
	WHERE TITLETYPE = 'movie'
			AND tt_bs.STARTYEAR > '2009' AND tt_bs.STARTYEAR < '2016' 
			AND GENRES LIKE '%Horror%' 
	GROUP BY tt_bs.STARTYEAR
	UNION 
	SELECT 
		tt_bs.STARTYEAR AS YEAR, 'Sci-Fi' AS GENRE,	AVG(tt_rt.AVERAGERATING) AS YEARLY_AVG
	FROM TITLE_BASICS tt_bs JOIN TITLE_RATINGS tt_rt ON tt_bs.TCONST = tt_rt.TCONST 
	WHERE TITLETYPE = 'movie'
			AND tt_bs.STARTYEAR > '2009' AND tt_bs.STARTYEAR < '2016' 
			AND GENRES LIKE '%Sci-Fi%' 
	GROUP BY tt_bs.STARTYEAR
	UNION 
	SELECT 
		tt_bs.STARTYEAR AS YEAR, 'Thriller' AS GENRE,AVG(tt_rt.AVERAGERATING) AS YEARLY_AVG
	FROM TITLE_BASICS tt_bs JOIN TITLE_RATINGS tt_rt ON tt_bs.TCONST = tt_rt.TCONST 
	WHERE TITLETYPE = 'movie'
			AND tt_bs.STARTYEAR > '2009' AND tt_bs.STARTYEAR < '2016' 
			AND GENRES LIKE '%Thriller%' 
	GROUP BY tt_bs.STARTYEAR
) finalTable
ORDER BY YEAR, GENRE;