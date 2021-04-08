-- This script reports the days in quebec when the number of recoveries were at least twice as much as the number of cases reported on that day

--load the data from HDFS and define the schema
coviddata = LOAD '/data/Covid19Canada.csv' USING PigStorage(',') AS (prname:CHARARRAY, idate:CHARARRAY, newcases:INT, newdeaths:INT, tests:INT, recoveries:INT);

-- 
QuebecCases = FILTER coviddata BY prname == 'Quebec' AND newcases > 50 AND recoveries > 100;

-- 
res = FOREACH QuebecCases GENERATE idate, newcases, recoveries, ((float) recoveries / (float) newcases) AS ratio;

--
filt = FILTER res BY ratio > 2.0;

--
orderidates = ORDER filt BY idate;

--
DUMP orderidates;
