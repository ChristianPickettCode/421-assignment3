coviddata = LOAD '/data/Covid19Canada.csv' USING PigStorage(',') AS (prname:CHARARRAY, idate:CHARARRAY, newcases:INT, newdeaths:INT, tests:INT, recoveries:INT);

Grpd = GROUP coviddata BY prname;

Smmd = FOREACH Grpd GENERATE group, SUM(coviddata.newdeaths) AS totaldeaths;

quebecdeaths = FILTER Smmd BY group == 'Quebec';

quebecdata = FILTER coviddata BY prname == 'Quebec';

joined = JOIN quebecdata BY prname, quebecdeaths BY group;

res = FOREACH joined GENERATE idate, newdeaths, ((float)newdeaths/ (float)totaldeaths)*100.0 AS percent;

oneperc = FILTER res BY percent >= 1.0;

DUMP oneperc;

