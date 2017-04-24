lines = LOAD '/dbhw/*.txt' AS (line:chararray);
newlines = FOREACH lines GENERATE FLATTEN(LOWER(line)) as line;
letters = FOREACH newlines GENERATE FLATTEN(TOKENIZE(REPLACE((chararray)$0,'','|'), '|')) as letter;
regex = filter letters by letter matches '[aeiou]';
E = group regex by letter;
F = foreach E generate COUNT(regex), group;
STORE F into '/dbhw/bonus1';