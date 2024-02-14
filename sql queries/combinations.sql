-- Selecting the combination of Half-Time Result (HTR) and Full-Time Result (FTR) 
-- Concatenating them with a space in between to create a single combination
SELECT HTR + ' ' + FTR AS Combination, 

-- Counting the number of occurrences of each combination 
COUNT(*) AS Count

-- From the EnglishPremierLeague table
FROM EnglishPremierLeague

-- Grouping the rows by HTR and FTR, so that we can count occurrences of each combination
GROUP BY HTR, FTR;