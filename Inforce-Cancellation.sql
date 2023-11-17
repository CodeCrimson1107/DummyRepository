/*
SQL query to get a list of policy-sequences that were in-force as of a certain date using AS400 data:

This is a direct translation of the Dragon queries: FLEPPIF1 and FLEPPIF2.  There also exists the Dragon query FLEPPIF3, but this seems to be used for getting in-force VEHICLES rather than policies.  I never wrote a translation which included that 3rd query because the process that I translated this to SQL for didn't need that.

It's helpful to declare 2 variables, since they will be used several times in the query

@IFWPupper is the as-of date for in-force, i.e. this example pulls a list of policies that were in-force on 9/30/2019

@IFWPlower should be one year behind @IFWPupper (same month, same day, but the previous year, so really a year and 1 day)



In our processes in actuarial, we then join this to some set of data to isolate data from policy-sequences that were in-force on the date in @IFWPupper by joining the two by:

Branch
Carrier
Program
Policy Number
Sequence

with an inner join.


More specifically, this example pulls a list of policy-sequences that were in-force in the Florida EP program on 9/30/2019

*/


DECLARE @IFWPlower As NUMERIC(8,0);
DECLARE @IFWPupper As NUMERIC(8,0);


SET @IFWPupper = 20190930;
SET @IFWPlower = 20180930;


SELECT T01.RA00PBRA, T01.RA00PCARR, T01.RA00PPROG, T01.RA00PNO, T01.RA00SEQ, T01.RA00PEND, T01.RA00PCAYY*10000+T01.RA00PCAMM*100+T01.RA00PCADD As CANDTE, T01.RA00PEFYY*10000+T01.RA00PEFMM*100+T01.RA00PEFDD As EFFDTE, RA00PEXYY*10000+RA00PEXMM*100+RA00PEXDD As EXPDTE
FROM
LDSNEWFIL.CHRAFI00 T01
INNER JOIN
(
	SELECT RA00PBRA, RA00PCARR, RA00PPROG, RA00PNO, RA00SEQ, MAX(RA00PEND)As RA00PEND
	FROM LDSNEWFIL.CHRAFI00
	WHERE RA00PBRA='12' AND RA00PCARR='MG' AND RA00PPROG IN ('EP','EN') AND
		RA00PEFYY*10000+RA00PEFMM*100+RA00PEFDD > @IFWPlower
		AND
		RA00PEFYY*10000+RA00PEFMM*100+RA00PEFDD <= @IFWPupper
		AND
		RA00PEXYY*10000+RA00PEXMM*100+RA00PEXDD > @IFWPupper
		AND
		RA00AYY*10000+RA00AMM*100+RA00ADD <= @IFWPupper
	GROUP BY RA00PBRA, RA00PCARR, RA00PPROG, RA00PNO, RA00SEQ
) T02
ON T01.RA00PBRA=T02.RA00PBRA AND T01.RA00PCARR=T02.RA00PCARR AND T01.RA00PPROG=T02.RA00PPROG AND T01.RA00PNO=T02.RA00PNO AND T01.RA00SEQ=T02.RA00SEQ AND T01.RA00PEND=T02.RA00PEND
WHERE T01.RA00PCAYY*10000+T01.RA00PCAMM*100+T01.RA00PCADD > @IFWPupper OR T01.RA00PCAYY*10000+T01.RA00PCAMM*100+T01.RA00PCADD = 0
