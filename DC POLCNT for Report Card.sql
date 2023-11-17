use [DuckCreek_DataMart]

DECLARE @DATE_FILT AS DATETIME
SET @DATE_FILT = CONVERT(VARCHAR(10),GETDATE(),110)

--SELECT LATEST QUOTE RECORDS--
IF OBJECT_ID('TEMPDB..#MAXQUOTE') IS NOT NULL 
BEGIN 
    DROP TABLE #MAXQUOTE
END


SELECT PK_COMPOSITE, INHERITANCE, record_type
INTO #MAXQUOTE
FROM (
		SELECT *, 
				ROW_NUMBER() OVER (PARTITION BY INHERITANCE ORDER BY START_DATE DESC) AS X
		FROM DBO.RECORD
		WHERE CONVERT(VARCHAR(10),[START_DATE],110) <= @DATE_FILT AND RECORD_TYPE = 'Q'
	) AS A
WHERE X = 1 

CREATE CLUSTERED INDEX DUMDUM
ON #MAXQUOTE (PK_COMPOSITE, INHERITANCE)

--CREATE BEFORE EARLIEST POLICY RECORD--

IF OBJECT_ID('TEMPDB..#MINPOL0') IS NOT NULL 
BEGIN 
    DROP TABLE #MINPOL0
END


SELECT PK_COMPOSITE, 
		INHERITANCE,RECORD_TYPE, policy_number
INTO #MINPOL0
FROM (
		SELECT *,
				ROW_NUMBER() OVER (PARTITION BY POLICY_NUMBER ORDER BY START_DATE ASC) AS X, 'P' AS RECORD_TYPE
		FROM DBO.Policy
		
	) AS A
WHERE X = 1 AND CONVERT(VARCHAR(10),[START_DATE],126) <= @DATE_FILT 

CREATE CLUSTERED INDEX DUMMY
ON #MINPOL0 (PK_COMPOSITE, INHERITANCE)


---GET AGENCY CODE FROM POL-----------
IF OBJECT_ID('TEMPDB..#AGPOL') IS NOT NULL 
BEGIN 
    DROP TABLE #AGPOL
END


SELECT PK_COMPOSITE, 
		INHERITANCE,RECORD_TYPE, agency_code, policy_number
INTO #AGPOL
FROM (
		SELECT *,
				ROW_NUMBER() OVER (PARTITION BY POLICY_NUMBER ORDER BY START_DATE ASC) AS X, 'P' AS RECORD_TYPE
		FROM DBO.Policy WHERE agency_code <>''
		
	) AS A
 WHERE X=1 AND CONVERT(VARCHAR(10),[START_DATE],126) <= @DATE_FILT 

CREATE CLUSTERED INDEX DUMMY1
ON #AGPOL (PK_COMPOSITE, INHERITANCE)

--CREATE EARLIEST POLICY TABLE ---

IF OBJECT_ID('TEMPDB..#MINPOL') IS NOT NULL 
BEGIN 
    DROP TABLE #MINPOL
END


SELECT A.*, B.agency_code INTO #MINPOL
FROM #MINPOL0 AS A LEFT JOIN #AGPOL AS B ON A.policy_number =B.policy_number



CREATE CLUSTERED INDEX DRUM2
ON #MINPOL (PK_COMPOSITE, INHERITANCE)

--CREATE THE QUOTE TABLE--

IF OBJECT_ID('TEMPDB..#QUOTE') IS NOT NULL 
BEGIN 
    DROP TABLE #QUOTE
END


SELECT *
INTO #QUOTE
FROM #MAXQUOTE
WHERE INHERITANCE 
			NOT IN (
					 SELECT INHERITANCE
					 FROM #MINPOL
					 )
UNION ALL
SELECT PK_composite,  inheritance, RECORD_TYPE
FROM DBO.#MINPOL


CREATE CLUSTERED INDEX DRUM
ON #QUOTE (PK_COMPOSITE, INHERITANCE)

-- BRING IT ALL TOGETHER--
--JOIN AGENTCODE FOR RECORD_TYPE = P--
SELECT
T2.STATECODE
,T2.AGENTCODE
,T2.COVERAGE
,MAX(CASE WHEN T2.ACT_YYYYMM =202101 THEN POL_CNT ELSE 0 END) AS P202101
,MAX(CASE WHEN T2.ACT_YYYYMM =202102 THEN POL_CNT ELSE 0 END) AS P202102
,MAX(CASE WHEN T2.ACT_YYYYMM =202103 THEN POL_CNT ELSE 0 END) AS P202103
,MAX(CASE WHEN T2.ACT_YYYYMM =202104 THEN POL_CNT ELSE 0 END) AS P202104
,MAX(CASE WHEN T2.ACT_YYYYMM =202105 THEN POL_CNT ELSE 0 END) AS P202105
,MAX(CASE WHEN T2.ACT_YYYYMM =202106 THEN POL_CNT ELSE 0 END) AS P202106
,MAX(CASE WHEN T2.ACT_YYYYMM =202107 THEN POL_CNT ELSE 0 END) AS P202107
,MAX(CASE WHEN T2.ACT_YYYYMM =202107 THEN POL_CNT ELSE 0 END) AS P202108
,MAX(CASE WHEN T2.ACT_YYYYMM =202107 THEN POL_CNT ELSE 0 END) AS P202109
,MAX(CASE WHEN T2.ACT_YYYYMM =202107 THEN POL_CNT ELSE 0 END) AS P202110
,MAX(CASE WHEN T2.ACT_YYYYMM =202107 THEN POL_CNT ELSE 0 END) AS P202111
,MAX(CASE WHEN T2.ACT_YYYYMM =202107 THEN POL_CNT ELSE 0 END) AS P202112



FROM
(
SELECT
T1.STATECODE
,T1.AGENTCODE
,T1.COVERAGE
,YEAR(ACTIVITYDATE)*100+MONTH(ACTIVITYDATE) AS ACT_YYYYMM
,COUNT(*) AS POL_CNT
FROM(

SELECT  NULL AS QUOTEID, 
		A.[START_DATE] AS ACTIVITYDATE, 
		C.agency_code AS AGENTCODE, 
		CASE WHEN B.record_type = 'P' THEN A.RECORD_NUMBER + '-00' ELSE '0' END AS FULLPOLICYNUMBER, 
		CASE WHEN B.record_type = 'P' THEN 'Y' ELSE 'N' END AS BOUND, 
		CASE WHEN A.STATUS = 'RW' THEN 'R' ELSE 'N' END AS NBRW, 
		CASE WHEN B.record_type = 'Q' THEN record_number ELSE '0' END AS QUOTENUMBER,
		A.premium AS TOTALPREMIUM, 
		A.[PROFILE] AS COVERAGELINEOFBUSINESS, 
		A.[PROFILE] AS COVERAGE,
		A.RISK_STATE AS STATECODE, 
		'DBA' AS AGENCY,
		'MK' AS MARKET, 
		'TM' AS TERRITORYMANAGER, 
		'Y' AS SCORED,
		A.POSTAL_CODE_BASE AS ZIPCODE, 
		CASE WHEN A.PAYMENT_PLAN = 'EFT' THEN 'Y' ELSE 'N' END AS ISENROLLEDINAUTOPAY,
		A.PROVIDER_CODE AS PROVIDERCODE, 
		A.SALES_CHANNEL AS CHANNELCODE,
		A.user_id, a.inheritance, tier
FROM #QUOTE AS B INNER JOIN DBO.Record AS A ON B.PK_composite =A.PK_composite
				INNER JOIN #MINPOL AS C ON B.PK_composite = C.PK_composite
	WHERE B.record_type = 'P'

UNION ALL
--JOIN AGENTCODE FOR RECORD_TYPE = Q--
SELECT  NULL AS QUOTEID, 
		A.[START_DATE] AS ACTIVITYDATE, 
		C.agency_code AS AGENTCODE, 
		CASE WHEN B.record_type = 'P' THEN A.RECORD_NUMBER + '-00' ELSE '0' END AS FULLPOLICYNUMBER, 
		CASE WHEN B.record_type = 'P' THEN 'Y' ELSE 'N' END AS BOUND, 
		CASE WHEN A.STATUS = 'RW' THEN 'R' ELSE 'N' END AS NBRW, 
		CASE WHEN B.record_type = 'Q' THEN A.record_number ELSE '0' END AS QUOTENUMBER,
		A.premium AS TOTALPREMIUM, 
		A.[PROFILE] AS COVERAGELINEOFBUSINESS, 
		A.[PROFILE] AS COVERAGE,
		A.RISK_STATE AS STATECODE, 
		'DBA' AS AGENCY,
		'MK' AS MARKET, 
		'TM' AS TERRITORYMANAGER, 
		'Y' AS SCORED,
		A.POSTAL_CODE_BASE AS ZIPCODE, 
		CASE WHEN A.PAYMENT_PLAN = 'EFT' THEN 'Y' ELSE 'N' END AS ISENROLLEDINAUTOPAY,
		A.PROVIDER_CODE AS PROVIDERCODE, 
		A.SALES_CHANNEL AS CHANNELCODE,
		A.user_id, a.inheritance, tier
FROM #QUOTE AS B INNER JOIN DBO.Record AS A ON B.PK_composite =A.PK_composite
				INNER JOIN DBO.AGENCY AS C ON B.PK_COMPOSITE = C.FK_RECORD 
	WHERE B.record_type = 'Q'
	
	) T1
GROUP BY
	
T1.STATECODE
,T1.AGENTCODE
,T1.COVERAGE
,YEAR(ACTIVITYDATE)*100+MONTH(ACTIVITYDATE)


) T2
GROUP BY
T2.STATECODE
,T2.AGENTCODE
,T2.COVERAGE

ORDER BY 
T2.STATECODE
,T2.AGENTCODE
,T2.COVERAGE