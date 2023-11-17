
%MACRO RANKING_DATA();
%macro formatkeep(); 
%mend formatkeep();

PROC SQL;
CREATE TABLE work.&state._Rate_Car02 AS SELECT * FROM work.&state._Rate_Car02 T1 ORDER BY RateLinkID, RateVehicleId
;QUIT;

PROC RANK DATA=work.&state._Rate_Car02 OUT= WORK.&state._Rate_Car03;
VAR RateVehicleId;
BY RateLinkID;
RANKS RANKING;
RUN;

PROC SQL;
CREATE TABLE work.&state._Rate_Driver01 AS SELECT * FROM work.&state._Rate_Driver01 ORDER BY RateLinkID, RateDriverId
;QUIT;

PROC RANK DATA=work.&state._Rate_Driver01 OUT= WORK.&state._Rate_Driver02;
VAR RateDriverId;
BY RateLinkID;
RANKS RANKING;
RUN;

PROC SQL;
CREATE TABLE work.&state._Rate_Violation01 AS SELECT * FROM work.&state._Rate_Violation01 T1
LEFT JOIN Points_Map T2 ON T1.VIOLCODE = T2.VIOLATIONCODE
ORDER BY RATEDRIVERLINKID, RATEVIOLATIONID
;QUIT;

PROC SQL;
CREATE TABLE work.&state._Rate_Violation01 AS SELECT * FROM work.&state._Rate_Violation01
WHERE BI_PTS_1 NE 0
;QUIT;


PROC RANK DATA=work.&state._Rate_Violation01 OUT= WORK.&state._Rate_Violation02;
VAR RATEVIOLATIONID;
BY RATEDRIVERLINKID;
RANKS RANKING;
RUN;

/*Unique Ranking Code for Rate Table to get Ranked Quote to accurately get DTL and Average Premiums. Handles Ties better than Proc Rank*/
PROC SQL;
CREATE TABLE  work.&state._Rate01 AS 
SELECT 
*
,CASE WHEN T2.Term NE T1.Term THEN TotalPremium*T2.Term/T1.Term ELSE TotalPremium END AS TotalPremium_Term_Adj
,T2.Term/T1.Term AS Term_Adj_Factor
,T2.Term AS RequestedTerm

FROM work.&state._Rate01 T1
LEFT JOIN (SELECT
	 RecordID AS RecordID
	,Term AS Term
FROM work.&state._Policy01 ) T2 ON
T1.PolicyLinkID = T2.RecordID
ORDER BY PolicyLinkID, RateIteration, TotalPremium_Term_Adj
;QUIT;


PROC SQL;
create table work.&state._COV_COUNT
AS
select
		RATELINKID
		,SUM(CASE WHEN LIABBIPREMIUM > 0 THEN 1 ELSE 0 END) as LIABBICNT
		,SUM(CASE WHEN LIABPDPREMIUM > 0 THEN 1 ELSE 0 END) as LIABPDCNT
		,SUM(CASE WHEN MEDPAYPREMIUM > 0 THEN 1 ELSE 0 END) as MEDPAYCNT
		,SUM(CASE WHEN PIPPREMIUM > 0 THEN 1 ELSE 0 END) as PIPCNT 
		,SUM(CASE WHEN RENTALPREMIUM > 0 THEN 1 ELSE 0 END) as RENTALCNT
		,SUM(CASE WHEN TOWINGPREMIUM > 0 THEN 1 ELSE 0 END) as TOWCNT
		,SUM(CASE WHEN UIMBIPREMIUM > 0 THEN 1 ELSE 0 END) as UIMBICNT
		,SUM(CASE WHEN UIMPDPREMIUM > 0 THEN 1 ELSE 0 END) as  UIMPDCNT
		,SUM(CASE WHEN UNINSBIPREMIUM > 0 THEN 1 ELSE 0 END) as UNINSBICNT
		,SUM(CASE WHEN UNINSPDPREMIUM > 0 THEN 1 ELSE 0 END) as UNINSPDCNT
		,SUM(CASE WHEN COMPPREMIUM > 0 THEN 1 ELSE 0 END) as COMPCNT
		,SUM(CASE WHEN COLLPREMIUM > 0 THEN 1 ELSE 0 END) as  COLLCNT
		from WORK.&state._Rate_Car03
GROUP BY RATELINKID
ORDER BY RATELINKID 
	;QUIT;



PROC SQL;
create table work.&state._TEMP01
as
select
T1.POLICYLINKID
,T1.RATEID
,T1.Rateiteration
,SUM(T2.LIABBICNT,
	T2.LIABPDCNT,
/*	T2.MEDPAYCNT,*/
	T2.PIPCNT,
/*	T2.RENTALCNT,*/
/*	T2.TOWCNT,*/
/*	T2.UIMBICNT,*/
/*	T2.UIMPDCNT,*/
	T2.UNINSBICNT,
/*	T2.UNINSPDCNT,*/
	T2.COMPCNT,
	T2.COLLCNT
	)
AS TOTALCOVERAGECOUNTER
FROM work.&state._RATE01 T1
LEFT JOIN (SELECT * FROM work.&state._COV_COUNT) T2 ON
T1.RATEID = T2.RATELINKID

;QUIT;

proc sql;
create table work.&state._BRIDGE01
as
select 
POLICYLINKID,
COMPANYID
/*,RATEID*/
,PURCHASED
FROM work.&state._RATE01
WHERE PURCHASED = 1
group by POLICYLINKID
ORDER BY POLICYLINKID

;QUIT;

proc means data=work.&state._TEMP01 mode nway noprint;
    class POLICYLINKID Rateiteration;
    var TOTALCOVERAGECOUNTER;
    output out=work.&state._MODE_POLICYLINKID mode=mode;
run;
;quit;

PROC SQL;
create table work.&state._RATE01
as
select 
*,
T1.RATELINKID,
SUM(T1.LIABBICNT,
	T1.LIABPDCNT,
/*	T1.MEDPAYCNT,*/
	T1.PIPCNT,
/*	T1.RENTALCNT,*/
/*	T1.TOWCNT,*/
/*	T1.UIMBICNT,*/
/*	T1.UIMPDCNT,*/
	T1.UNINSBICNT,
/*	T1.UNINSPDCNT,*/
	T1.COMPCNT,
	T1.COLLCNT
	)
AS TOTALCOVERAGECOUNTER
/*,MAX(TOTALCOVERAGECOUNTER) AS MODE*/
from work.&state._RATE01 T2
left join  
	(
		select
		*
		from work.&state._COV_COUNT
	) T1 ON
T2.RATEID = T1.RATELINKID
left join
	(
	select 
	POLICYLINKID,
	rateiteration,
	MODE
	from work.&state._MODE_POLICYLINKID
	) T3 on
T2.POLICYLINKID = T3.POLICYLINKID and T2.rateiteration = T3.rateiteration

/*left join */
/*	(select */
/*	POLICYLINKID*/
/*	,COMPANYID*/
/*	,PURCHASED AS BRIDGED*/
/*from work.&state._BRIDGE01) T4 on */
/*T2.POLICYLINKID = T4.POLICYLINKID AND T2.COMPANYID = T4.COMPANYID*/
/*AND T2.RATEID = T4.RATEID*/


GROUP BY T2.POLICYLINKID, T2.rateiteration, T2.RATEID
ORDER BY T2.POLICYLINKID, T2.rateiteration, T2.RATEID

;QUIT;


DATA work.&state._Rate01; 
SET work.&state._Rate01(where=(TOTALCOVERAGECOUNTER = MODE));
by POLICYLINKID RATEID;
run;

PROC SQL;
CREATE TABLE work.&state._Rate01 AS SELECT * FROM work.&state._Rate01
ORDER BY PolicyLinkID, RateIteration, TotalPremium_Term_Adj
;QUIT;

DATA work.&state._Rate_Metrics01;
 set work.&state._Rate01 (where=(TotalPremium NE 0));
by PolicyLinkID RateIteration;
if first.RateIteration then RANKING=0;
RANKING+1;
run;

PROC SQL;
CREATE TABLE work.&state._Rate_Metrics01 AS
SELECT
 PolicyLinkID
,RateId
,TotalPremium
,DownPayment
,PaymentAmount
,Term
,Purchased
,RatedDate
,Rate_Metrics01.CompanyId
,RateOption
,IsCreditRequired
,RateIteration
,PolicyFee
,NumOfPayments
,PercentDown
,PaymentTotal
,FinanceAmount
,ThirdPartyId
,Tier
,Program
,CompanyData1
,CompanyData2
,CompanyData3
,PerPaymentInstallmentFee
,TotalInstallmentFee
,ZipCode
,EnteredTerm
,EffectiveDate
,DateCreated
,PriorEffDate
,PriorInAgency
,NonOwner
,InsuredDeclinedCredit
,DateQuoted
,QuoteAgencyZipCode
,AssumedCredit
,Bound
,BinderDate
,SR22Fee
,ATPAFee
,FR44Fee
,FRBond
,ExpirationDate
,Broadform
,RecordID
,TotalPremium_Term_Adj
,Term_Adj_Factor
,RequestedTerm
,RateLinkID
,LIABBICNT
,LIABPDCNT
/*,MEDPAYCNT*/
,PIPCNT
/*,RENTALCNT*/
/*,TOWCNT*/
/*,UIMBICNT*/
/*,UIMPDCNT*/
,UNINSBICNT
/*,UNINSPDCNT*/
,COMPCNT
,COLLCNT
,mode
,TOTALCOVERAGECOUNTER
/*,BRIDGED*/
,RANKING
,State
,case when Company_Name = '' then put(Rate_Metrics01.CompanyID,20. -L) else Company_Name end as Company_Name
,Company_Group
,Codes_Last_Updated
FROM work.&state._Rate_Metrics01 Rate_Metrics01
LEFT JOIN work.Competitor_Codes Competitor_Codes ON
Rate_Metrics01.CompanyID = Competitor_Codes.CompanyID
and Competitor_Codes.State = "&state."
;quit;
%MEND RANKING_DATA();
%RANKING_DATA();
