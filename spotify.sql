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
SELECT c2 as energy
From data
ORDER BY energy DESC
LIMIT 10;

--Show 10 slowest songs by tempo
SELECT CAST(c11 as real) as tempo
From data
ORDER BY tempo asc
LIMIT 10;