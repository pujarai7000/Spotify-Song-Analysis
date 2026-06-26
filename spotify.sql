
--checked  the data type of imported table 

PRAGMA table_info(data);



--How many songs are in the dataset ?
Select COUNT(*)
From data;

--How many songs were liked?
---sum approach 
Select SUM(c14) as liked_song
From data;

--count approach 
Select count(*) 
From data
WHERE c14=1;

--How many songs were not liked?
Select count(*) 
From data
WHERE c14=0;

--what is the average danceability of all songs?
Select AVG(c1) 
From data;

--what is the average energy of all songs ?
Select AVG(c2) 
From data;

--How many songs exists for each musical key ?
Select CAST(c3 as integer) as musical_key,
       COUNT(*) as no_of_song
From data
Group By CAST( c3 as integer) ;

--What is the average danceability for liked vs disliked songs?
DELETE FROM data
WHERE c14='liked';
Select  c14 as liked_status,
       AVG(CAST (c1 as real) )as avg_danceability
From data 
GROUP BY c14;

--What is the average energy for liked vs disliked songs?DELETE FROM data
DELETE FROM data
WHERE c14='liked';
SELECT AVG(c2) as avg_energy ,c14 as liked_status
From data
GROUP by c14;

--Which time signature appears most frequently?
SELECT COUNT (* ) as frequency,c13 as time_signature
From data
GROUP by c13
ORDER BY frequency DESC
LIMIT 1;


--Which key has the highest average energy?
SELECT AVG(c2) as avg_energy, c3 as keys
From data
GROUP BY c3
ORDER BY  avg_energy DESC
LIMIT 1;

--Top 10 highest energy values in the dataset
SELECT CAST( c2 AS REAL) as energy
From data
ORDER BY CAST( c2 AS REAL)  DESC
LIMIT 10;

--Show 10 slowest songs by tempo
SELECT CAST(c11 as real) as tempo
From data
ORDER BY tempo asc
LIMIT 10;

--Classify songs as High energy, Medium energy and Low energy where high energy (>0.7),Medium energy (0.4-0.7) and low energy (<0.4)
SElECT
 CASE 
    WHEN CAST(C2 AS Real) > 0.7 THEN 'High_energy'
    WHEN CAST(c2 AS Real) >0.4 and CAST(C2 AS REAL)<=0.7 THEN '	Medium_energy'
    ELSE 'Low_Energy'
    END AS Energy_status 
 FROM data;
 
 --Count how many songs belong to each energy category 
 SElECT CAST(C2 AS REAL) AS energy_value,
CASE 
    WHEN CAST(C2 AS Real) > 0.7 THEN 'High_energy'
    WHEN CAST(c2 AS Real) >0.4 AND CAST(C2 AS REAL)<=0.7 THEN '	Medium_energy'
    ELSE 'Low_Energy'
    END AS Energy_status ,
    COUNT(*) AS TOTAL_SONGS 
 FROM data
 group By Energy_status;
 
 --classify song as tempo 
SELECT cast(c11 as Real) as tempo ,
CASE
    when CAST(C11 AS real)> 100 THEN 'fast_song'
    WHEN CAST(C11 AS REAL) >=80 and CAST (C11 AS real) <100 THEN 'medium_song'
    ELSE 'slow_song '
    END AS song_type
From data;

--Show keys that have more than 10 songs 
SELECt CAST(c3 AS REAL) as keys,
       COUNT(*) AS Total_songs
FROM data
GROUP BY keys
HAVING COUNT(*)>10

--Show keys whose average danceability is above 0.70
SELECt c3  as keys,AVG(CAST(c1 AS REAL))as avg_danceability 
 FROM data 
 GROUP BY keys
 HAVING  AVG(CAST(c1 AS REAL)) > 0.70;
 
 --Find songs with energy higher than the dataset average
 SELECT CAST(c2 as REAL) as energy 
FROM data 
WHERE CAST(c2 AS REAL) > 
(
  SELECT AVG(CAST(C2 as REAL)) as avg_energy 
  FROM data 
  );
  
--Find songs with tempo higher than average
SELECT CAST(c11 as REAL) as tempo
FROM data 
WHERE CAST(c11 AS REAL) > 
(
  SELECT AVG(CAST(C11 as REAL)) as avg_temp0
  FROM data 
  );
  
--Show songs and classify them as Above average energy  and below Average Energy 
SELECT CAST(c2 as REAL) AS energy ,
CASE WHEN  CAST(C2 as REAL) > 
(
  SELECT AVG(CAST(C2 AS REAL)) 
  FROM data
  
 )
 THEN 'Above_avg_energy'
 ELSE 'Below_avg_energy'
 END AS energy_status
 FROM data;
 
-- Window Function 

-- Show each song's energy along with the oevrall average energy 
SELECT c2  ,AVG(CAST (c2 AS REAL)) OVER() as avg_energy
FROM data;