/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Input Format

The OCCUPATIONS table is described as follows:



Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Sample Input



Sample Output

Jenny    Ashley     Meera  Jane
Samantha Christeen  Priya  Julia
NULL     Ketty      NULL   Maria
Explanation

The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.
*/

WITH cte AS (
    SELECT 
        CASE WHEN Occupation='Doctor' THEN Name END AS doctor, 
        CASE WHEN Occupation='Actor' THEN Name END AS actor, 
        CASE WHEN Occupation='Singer' THEN Name END AS singer, 
        CASE WHEN Occupation='Professor' THEN Name END AS professor,     
        ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name) as rn 
    FROM OCCUPATIONS
)
SELECT MAX(doctor),MAX(professor),MAX(singer),MAX(actor)
FROM cte
GROUP BY rn 
order by rn;

SELECT 
MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor, 
MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor, 
MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer, 
MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor 
FROM ( 
		SELECT Name, Occupation, ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn 
		FROM OCCUPATIONS 
	) t GROUP BY rn ORDER BY rn;
