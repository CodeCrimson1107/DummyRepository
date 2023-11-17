use [DuckCreek_DataMart]
go 

--change dates in all the right spots down below--

;With TZ AS (

Select DATEFROMPARTS(2021,04,30) as Dt1_filt, 
	   DATEFROMPARTS(2020,5,31) as Dt2_filt,
	   datefromparts(2020,07,31) as Dt3_filt,
	   datefromparts(2020,5,31) as Dt4_filt,
	   datefromparts(2020,08,31) as Dt5_filt,
	   Datefromparts(2020,5,31) as Dt6_filt
),

T1 AS (

SELECT *, 
	   ROW_NUMBER() OVER (PARTITION BY POLICY_NUMBER ORDER BY START_DATE ASC) AS ENDO
FROM DuckCreek_DataMart.DBO.POLICY
WHERE EFFECTIVE_DATE > (Select Dt2_filt from TZ) AND EFFECTIVE_DATE <= (Select Dt1_filt from TZ) 
	  AND EXPIRATION_DATE > (Select Dt1_filt from TZ) AND START_DATE <= (Select Dt1_filt from TZ)

),

T2 AS (
		
--GET MAX ENDO, INFORCE POLICIES as of current-- 

SELECT A.POLICY_NUMBER, 
		A.RENEWAL, 
		A.ENDORSEMENT, 
		A.AGENCY_CODE, 
		A.START_DATE, 
		A.POSTAL_CODE_BASE * 1 as ZIP, 
		case when A.TERM = 'SIX' then 6 else 12 end as TERM,
		A.PROFILE,
		A.STATE_NAME as Statecode,
		1 as CURR_PIF
FROM T1 AS A INNER JOIN 
		 (SELECT MAX(ENDO) AS ENDO, 
					POLICY_NUMBER, 
					RENEWAL 
		  FROM 	T1
		  GROUP BY POLICY_NUMBER, RENEWAL) AS B 
	  
	  ON A.POLICY_NUMBER = B.POLICY_NUMBER AND B.RENEWAL = A.RENEWAL AND A.ENDO = B.ENDO
WHERE A.STATUS_KEY IN ('INFORCE', 'IN FORCE', 'Cancel-Pending', 'InForce')  or A.status_key is null

), 

T3 AS (
SELECT *, 
	   ROW_NUMBER() OVER (PARTITION BY POLICY_NUMBER ORDER BY START_DATE ASC) AS ENDO
FROM DuckCreek_DataMart.DBO.POLICY
WHERE EFFECTIVE_DATE > (Select Dt4_filt from TZ) AND EFFECTIVE_DATE <= (Select Dt3_filt from TZ) 
	  AND EXPIRATION_DATE > (Select Dt3_filt from TZ) AND START_DATE <= (Select Dt3_filt from TZ)

), 

--As of prior month pifs end--

T4 AS(
SELECT A.POLICY_NUMBER, 
		A.RENEWAL, 
		A.ENDORSEMENT, 
		A.AGENCY_CODE, 
		A.START_DATE, 
		A.POSTAL_CODE_BASE * 1 as ZIP, 
		case when A.TERM = 'SIX' then 6 else 12 end as TERM, 
		A.PROFILE,
		A.STATE_NAME as Statecode, 
		1 as PRIOR_PIF
FROM T3 AS A INNER JOIN 
		 (SELECT MAX(ENDO) AS ENDO, 
					POLICY_NUMBER, 
					RENEWAL 
		  FROM 	T3
		  GROUP BY POLICY_NUMBER, RENEWAL) AS B 
	  
	  ON A.POLICY_NUMBER = B.POLICY_NUMBER AND B.RENEWAL = A.RENEWAL AND A.ENDO = B.ENDO
WHERE A.STATUS_KEY IN ('INFORCE', 'IN FORCE', 'Cancel-Pending', 'InForce')  or A.status_key is null

), 

T5 AS (
SELECT *, 
	   ROW_NUMBER() OVER (PARTITION BY POLICY_NUMBER ORDER BY START_DATE ASC) AS ENDO
FROM DuckCreek_DataMart.DBO.POLICY
WHERE EFFECTIVE_DATE > (Select Dt6_filt from TZ) AND EFFECTIVE_DATE <= (Select Dt5_filt from TZ) 
		AND EXPIRATION_DATE > (Select Dt5_filt from TZ) AND START_DATE <= (Select Dt5_filt from TZ)

), 

--end of prior year pifs--

T6 AS (
SELECT A.POLICY_NUMBER, 
		A.RENEWAL, 
		A.ENDORSEMENT, 
		A.AGENCY_CODE, 
		A.START_DATE, 
		A.POSTAL_CODE_BASE * 1 as ZIP, 
		case when A.TERM = 'SIX' then 6 else 12 end as TERM, 
		A.PROFILE,
		A.STATE_NAME as Statecode,
		1 as PRIOR_YEAR_PIF
FROM T5 AS A INNER JOIN 
		 (SELECT MAX(ENDO) AS ENDO, 
					POLICY_NUMBER, 
					RENEWAL 
		  FROM 	T5
		  GROUP BY POLICY_NUMBER, RENEWAL) AS B 
	  
	  ON A.POLICY_NUMBER = B.POLICY_NUMBER AND B.RENEWAL = A.RENEWAL AND A.ENDO = B.ENDO
WHERE A.STATUS_KEY IN ('INFORCE', 'IN FORCE', 'Cancel-Pending', 'InForce')  or A.status_key is null

), 

T7 AS (

Select AGENCY_CODE AS AGENTCODE,
       STATECODE,
	   ZIP,
	   TERM,
	   PROFILE,
	   RENEWAL,
		SUM(CURR_PIF) AS CURR_PIF, 
		0 AS PRIOR_PIF, 
		0 AS PRIOR_YEAR_PIF
from T2
group by AGENCY_CODE, STATECODE,  RENEWAL, ZIP, TERM, PROFILE
union all 
Select AGENCY_CODE AS AGENTCODE,
       STATECODE,
	   ZIP,
	   TERM,
	   PROFILE,
	   RENEWAL,
		0 as CURR_PIF, 
		sum(PRIOR_PIF) as PRIOR_PIF, 
		0 as PRIOR_YEAR_PIF
from T4
group by AGENCY_CODE, STATECODE,  RENEWAL, ZIP, TERM, PROFILE
union all
Select AGENCY_CODE AS AGENTCODE,
       STATECODE,
	   ZIP,
	   TERM,
	   PROFILE,
	   RENEWAL, 
		0 as CURR_PIF, 
		0 as PRIOR_PIF, 
		sum(PRIOR_YEAR_PIF) as PRIOR_YEAR_PIF
from T6
group by AGENCY_CODE, STATECODE, POLICY_NUMBER, RENEWAL, ZIP, TERM, PROFILE

),

--bring together data --

T8 as (

Select AGENTCODE,
       STATECODE,
	   ZIP,
	   TERM,
	   PROFILE,
	   RENEWAL,
	   case when b.Accounts is null then 'IA' else b.Accounts end as Account,
	   sum(curr_pif) as '2021-04'
	 --, --comment out this and change
	  -- sum(PRIOR_PIF) as '2021-01', --comment out this and change
	  -- sum(prior_year_pif) as '2021-02' --comment out this and change
from T7 left join Marketing.dbo.Code_Acc as b on t7.AGENTCODE = b.Codes
Where AGENTCODE like 'A%'
Group by AGENTCODE, 
		 STATECODE,
		 ZIP,
		 TERM,
	     PROFILE,
		 RENEWAL,
		 Accounts
),

--Unpivot data --

T9 as (

Select AGENTCODE as Agent,
       Account,
	   Statecode as Riskstate,
	   Case when renewal = 0 then 'N' else 'R' end as Seq,
	   YYYYMM,
	   Pifs,
		TERM,
	    PROFILE,
		ZIP
from (
	Select AGENTCODE,
	       Account,
		   Statecode,
		   renewal,
		   TERM,
		   PROFILE,
		   ZIP,
		  -- [2021-01],
		  --- [2021-02],
		   [2021-04]
	from T8 ) as P
unpivot
(Pifs for YYYYMM in (
--[2021-01], [2021-02], --comment out this and change 2021-03 to 2021-04 to pull April PIFs
[2021-04]) ) as Unpivot_Pifs

)

-- (Agent, Account, Riskstate, Seq, YYYYMM, Pifs, TERM, PROFILE, ZIP)

/*
insert into marketing.dbo.PAS_PIFS_NA
Select * 
from T9;
*/
--delete from marketing.dbo.PAS_PIFS_NA where YYYYMM = '2021-02';



