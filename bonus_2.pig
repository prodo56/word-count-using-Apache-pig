ages = LOAD '/db-bonus/kids.txt' USING PigStorage(' ') AS (name:chararray,age:int);
purchases = LOAD '/db-bonus/purchases.txt' USING PigStorage(' ') AS (name:chararray,item:chararray);
tweens = FILTER ages BY (age > 9 and age < 13);
tablejoin = JOIN tweens BY (name),purchases by (name);
L = Group tablejoin by purchases::item;
counted = FOREACH L GENERATE group as purchases::item,COUNT(tablejoin) as cnt;
M = LIMIT (ORDER counted BY cnt DESC) 1;
STORE M into '/db-bonus/bonus_2';