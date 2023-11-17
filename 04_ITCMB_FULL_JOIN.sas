/*Get to latest rate iteration where # of competitors > 1 or competing with only self (to avoid rate iteration +1 on bridge)*/
PROC SQL;
CREATE TABLE work.&state._Rate_Metrics03 AS
SELECT * 
FROM &state._Rate_Metrics01 T1
	INNER JOIN(
		SELECT 
			 POLICYLINKID
			,MAX(RATEITERATION) AS RATEITERATION
		FROM work.&state._RATE_METRICS02
		WHERE NumCompetitors > 3
		GROUP BY 1) IterationFilter ON
		T1.POLICYLINKID = IterationFilter.POLICYLINKID
	AND T1.RATEITERATION = IterationFilter.RATEITERATION
;QUIT;



/*05) Join All Aggregated data to Rate Table and reduce to latest rate iteration*/
%put Process Timestamp: %sysfunc(time(),timeampm.) on %sysfunc(date(),worddate.).;
/*libname output '\\dalgrp01\RiskManagementGrpshare\Product\ITC_MarketBasket\DATA\FULL_DATA\';*/
OPTIONS COMPRESS=YES;
PROC SQL;
CREATE TABLE output.&state._&itc_str_dt._&itc_end_dt._FULL AS 
/*CREATE TABLE work.FULLTESTING AS */
SELECT *
		,TRIMN(Rate_Metrics03.Company_Name)||COMPRESS(Rate_Metrics03.Program) as Company_Name_Program
		,CASE
		when TotalPremium_Term_Adj = TotalPremium_Term_Adj01 then 1 
		when substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name01,1,5) and TotalPremium_Term_Adj <= TotalPremium_Term_Adj02 then 1

		when substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name01,1,5) and
		substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name02,1,5)
		and TotalPremium_Term_Adj <= TotalPremium_Term_Adj03 then 1

		when substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name01,1,5) and
		substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name02,1,5) and
		substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name03,1,5)
		and TotalPremium_Term_Adj <= TotalPremium_Term_Adj04 then 1

		when substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name01,1,5) and
		substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name02,1,5) and
		substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name03,1,5) and
		substr(Rate_Metrics03.Company_Name,1,5) = substr(Company_Name04,1,5)
		and TotalPremium_Term_Adj <= TotalPremium_Term_Adj05 then 1
		ELSE 0 END AS Won
		,1 as Quote
	FROM work.&state._Rate_Metrics03 Rate_Metrics03

	LEFT JOIN work.&state._Policy01 Policy01 on
	Rate_Metrics03.PolicyLinkID = Policy01.RecordID

	LEFT JOIN work.&state._Rate_Car03 Rate_Car03 ON
	Rate_Metrics03.RateID = Rate_Car03.RateLinkID 

	LEFT JOIN work.&state._Rate_Driver03 Rate_Driver03 ON
	Rate_Metrics03.RateID = Rate_Driver03.RateLinkID 
	
	/*This only pulls in violations for the insured. Does not get violations for spouse/secondary/etc.*/
	LEFT JOIN WORK.&state._Rate_Violation03 Rate_Violation03 ON
	Rate_Driver03.RateDriverID01 = Rate_Violation03.RateDriverLinkID

	LEFT JOIN work.&state._Rate_Metrics02 Rate_Metrics02 ON
		Rate_Metrics03.PolicyLinkID = Rate_Metrics02.POLICYLINKID
	AND Rate_Metrics03.RateIteration  = Rate_Metrics02.RateIteration

	LEFT JOIN work.&state._COV_PREM01 COV_PREM01 ON
		Rate_Metrics03.PolicyLinkID = COV_PREM01.POLICYLINKID
	AND Rate_Metrics03.RateIteration  = COV_PREM01.RateIteration

	LEFT JOIN work.ZipMap ZipMap ON
		Rate_Metrics03.ZipCode = ZipMap.ZipCode
/*	AND ZipMap.State = "&State"*/

/*	LEFT JOIN work.Competitor_Codes Competitor_Codes ON*/
/*	Rate_Metrics03.CompanyID = Competitor_Codes.CompanyID*/
/*	and Competitor_Codes.State = "&state."*/

	ORDER BY 1,2
	

;QUIT;
