/*
Parking Fines Project, Part II - Query the database using SQLite3
David C. Wallace
Updated March 3rd, 2015.
*/

--open sqlite in the directory that contains the database bmorefines and issue the command ".open bmorefines"

--how many fines were issued, what was the total value of all fines, and what was the average fine?
SELECT COUNT(violFine), SUM(violFine), SUM(violFine)/COUNT(violFine) FROM fines;

/*Result:
#fines | Total Fine Revenue ($) | Average fine amount ($)
1032092 | 49431120.0 | 47.8941024637339
*/

--How many fines were issued to Chevrolet vehicles and what is the total?
SELECT COUNT(make), SUM(violFine), SUM(violFine)/COUNT(violFine) from `fines`
	WHERE (make LIKE 'CHEVY' );
--Result:
--n fines | Total Fine Revenue ($) | Average fine amount ($)
--51 | 2482.0 | 48.6666666666667


/*There is an obvious problem with this dataset, which is that the vehicle make is not standardized. Because of this, there are many different representations of the auto manufacturer "Chevrolet," and indeed many other vehicle manufacturers. A better way to group the vehicle make would be by the first three letters of the field, since different representations are likely to share the same first three letters.*/

SELECT COUNT(make) from fines
	WHERE SUBSTR(make, 1, 3) LIKE 'CHE';
--Result:
--n Chevrolet
--102078

/*Let's compare the number of distinct vehicle makes to the number of vehicle makes that do not share the same first three letters*/
SELECT COUNT(DISTINCT make) FROM fines
UNION
SELECT COUNT(DISTINCT SUBSTR(make, 1, 3)) FROM fines;
--Result:
--1113 (number of distinct vehicle makes)
--639 (number of distinct vehicle makes not sharing first three letters)

/*So using the first three letters of the vehicle make column cuts the number of distinct makes nearly in half.*/


--What are the top ten most cited vehicle makes?
SELECT DISTINCT(SUBSTR(make, 1, 3)), COUNT (violFine), SUM(violFine), 
	AVG(violFine) from `fines`
	GROUP BY SUBSTR(make, 1, 3) ORDER BY COUNT(violFine) DESC               
	LIMIT 10;  
--Result:
--Make | n fines | total revenue | average fine amount
/*
FOR|128300|6382292.0|49.7450662509743
CHE|102078|5023186.0|49.2092909343835
HON|100366|4586978.0|45.7025088177271
TOY|95159|4396658.0|46.2032808247249
NIS|70129|3258870.0|46.4696487900868
DOD|54615|2671595.0|48.9168726540328
VOL|40324|1866548.0|46.2887610356115
MER|38071|1791805.0|47.0648262456988
HYU|32705|1514020.0|46.2932273352698
CHR|32508|1557665.0|47.91635905008
*/

--Who got the most parking fines?
SELECT DISTINCT(tag), COUNT(tag), SUM(violFine) from `fines`
	GROUP BY tag ORDER BY COUNT(tag) DESC
	LIMIT 10;
--Result:
--tag | n fines | total revenue
/*
NOTAGSDI|636|21920.0
NOTAGS T|400|17135.0
WYC5371|128|5112.0
4AD8922|90|3775.0
7AD8145|77|2849.0
2AK6223|75|3494.0
25874M3|70|3037.0
1AZ2438|69|2293.0
NOTAG  T|69|2805.0
KPL292|68|2216.0
*/
--Whoever owns the vehicle with license plate WYC5371 is either very unlucky, or very lazy.

/*Let's make a histogram to see what time of day is most popular for issuing parking tickets.*/
SELECT ROUND(violTime, 0), COUNT(violFine) from fines
	GROUP BY ROUND(violTime, 0)
	ORDER BY ROUND(violTime, 0);
--Result:
--Time | n Fines
/*
0.0|16642
1.0|13101
2.0|8468
3.0|6820
4.0|7429
5.0|4101
6.0|10849
7.0|32625
8.0|71264
9.0|83014
10.0|79676
11.0|95111
12.0|99471
13.0|88258
14.0|62666
15.0|56531
16.0|64823
17.0|56574
18.0|43229
19.0|46045
20.0|29301
21.0|24233
22.0|16118
23.0|13334
24.0|2409
*/

--A plot of the histogram is attached. 5AM and 11PM seem to be the best times to park illegally, while 12PM is clearly the worst.
