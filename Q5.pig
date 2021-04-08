coviddata = LOAD '/data/Covid19Canada.csv' USING PigStorage(',') AS (prname:CHARARRAY, idate:CHARARRAY, newcases:INT, newdeaths:INT, tests:INT, recoveries:INT);

Grpd = GROUP coviddata BY prname;

Smmd = FOREACH Grpd GENERATE group, SUM(coviddata.newdeaths) AS deaths;

Filt = FILTER Smmd BY deaths > 100;

orderbydeaths = ORDER Filt BY deaths DESC;

DUMP orderbydeaths;
