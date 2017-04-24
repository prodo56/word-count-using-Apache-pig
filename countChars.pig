lines = LOAD '/dbhw/*.txt' AS (line:chararray);
newlines = FOREACH lines GENERATE FLATTEN(LOWER(line)) as line;
letters = FOREACH newlines GENERATE FLATTEN(TOKENIZE(REPLACE((chararray)$0,'','|'), '|')) as letter;
E = group letters by letter;
F = foreach E generate COUNT(letters), group;
STORE F into '/dbhw/output';