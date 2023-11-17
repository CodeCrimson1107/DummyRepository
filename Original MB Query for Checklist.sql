Declare @yyyy int
Set @yyyy = 2020

Declare @mm int 
Set @mm = 08

SELECT COUNT(TOTPREM) AS QUOTES, COMPANY, Zip as Zipcode, TRANSYY AS QUOTE_YEAR, TRANSMM AS QUOTE_MM,
		CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1 to 30'
			 WHEN RANK1DIFF <=60  THEN '31 to 60'
			 WHEN RANK1DIFF <=90  THEN '61 to 90'
			 WHEN RANK1DIFF <=120 THEN '91 to 120'
			 ELSE '=>121' END AS LABEL, Profile, 'FL' as [State], Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[FL_MB]
  Where Company like ('GAINSCO%') and TransMM = @mm and TransYY = @yyyy
  GROUP BY COMPANY, Zip, TRANSYY, TRANSMM, Rank1Diff, TotPrem, Profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, COMPANY, Zipcode, TRANSYY AS QUOTE_YEAR, TRANSMM AS QUOTE_MM,
		CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1 to 30'
			 WHEN RANK1DIFF <=60  THEN '31 to 60'
			 WHEN RANK1DIFF <=90  THEN '61 to 90'
			 WHEN RANK1DIFF <=120 THEN '91 to 120'
			 ELSE '=>121' END AS LABEL, Profile, 'GA' as [State], Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[GA_MB]
  Where Company like ('GAINSCO%') and TransMM = @mm and TransYY = @yyyy
  GROUP BY COMPANY, Zipcode, TRANSYY, TRANSMM, Rank1Diff, TotPrem, Profile

UNION ALL


SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, ZipCode,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,
		CASE WHEN (TOTPREM - RANK1PR) <=0  THEN 'WIN'
		     WHEN (TOTPREM - RANK1PR) <=30 THEN '1 to 30'
			 WHEN (TOTPREM - RANK1PR) <=60 THEN '31 to 60'
			 WHEN (TOTPREM - RANK1PR) <=90 THEN '61 to 90'
			 WHEN (TOTPREM - RANK1PR) <=120 THEN '91 to 120'
			 ELSE '=>121' END AS LABEL, profile, 'TN' as [State], Case when CO_Name like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[TN_MB]
  Where CO_Name like 'GAINSCO%' and Rate_Mo = @mm and Rate_Yr = @yyyy
  GROUP BY CO_NAME, ZipCode, RATE_YR, RATE_MO, Rank1PR, TotPREM, profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, COMPANY, Zip as Zipcode, TRANSYY AS QUOTE_YEAR, TRANSMM AS QUOTE_MM,
		CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1 to 30'
			 WHEN RANK1DIFF <=60  THEN '31 to 60'
			 WHEN RANK1DIFF <=90  THEN '61 to 90'
			 WHEN RANK1DIFF <=120 THEN '91 to 120'
			 ELSE '=>121' END AS LABEL, Profile, 'SC' as [State], Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[SC_MB]
  Where Company like ('GAINSCO%') and TransMM = @mm and TransYY = @yyyy
  GROUP BY COMPANY, zip, TRANSYY, TRANSMM, Rank1Diff, TotPrem, Profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, ZipCode,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,
		CASE WHEN (TOTPREM - RANK1PR) <=0  THEN 'WIN'
		     WHEN (TOTPREM - RANK1PR) <=30 THEN '1 to 30'
			 WHEN (TOTPREM - RANK1PR) <=60 THEN '31 to 60'
			 WHEN (TOTPREM - RANK1PR) <=90 THEN '61 to 90'
			 WHEN (TOTPREM - RANK1PR) <=120 THEN '91 to 120'
			 ELSE '=>121' END AS LABEL, profile, 'VA' as [State], Case when CO_Name like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[VA_MB]
  Where CO_Name like 'GAINSCO%' and Rate_Mo = @mm and Rate_Yr = @yyyy
  GROUP BY CO_NAME, ZipCode, RATE_YR, RATE_MO, Rank1PR, TotPREM, profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, ZipCode, 
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM, LABELS as LABEL, profile, 'NM' as [State], Case when CO_Name like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[NM_MB_VCP]
  Where CO_Name like ('GAINSCO%') and Rate_Mo = @mm  and Rate_Yr = @yyyy
  GROUP BY CO_NAME, ZipCode, Rate_Mo, Rate_Yr, LABELS, TotPREM, profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, ZipCode, 
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,LABELS AS LABEL, profile, 'OK' as [State], Case when CO_Name like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[OK_MB]
  Where CO_Name like ('GAINSCO%') and Rate_Mo = @mm  and Rate_Yr = @yyyy
  GROUP BY CO_NAME, ZipCode, Rate_Mo, Rate_Yr, LABELS, TotPREM, profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, ZipCode, 
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,LABELS AS LABEL, Profile, 'TX' as [State], Case when CO_Name like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[TX_MB]
  Where CO_Name like ('GAINSCO%') and Rate_Mo = @mm  and Rate_Yr = @yyyy
  GROUP BY CO_NAME, ZipCode, Rate_Mo, Rate_Yr, LABELS, TotPREM, profile

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, CARRIER AS COMPANY, a.ZIP as Zipcode, 
		Q_YEAR AS QUOTE_YEAR, Q_MONTH AS QUOTE_MM, 
		Case when LABEL = '1_30' then '1 to 30'
			 when label = '31_60' then '31 to 60'
			 when LABEL = '61_90' then '61 to 90'
			 when label = '91_120' then '91 to 120'
			 when label = 'GE_121' then '=>121'
			 else Label end as Label 
		, PROFILEP as Profile, 'UT' as [State], Case when CARRIER like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[UT_MB_Subset] AS A LEFT JOIN DBO.TERRKEY AS B ON A.ZIP = B.ZIP
  Where CARRIER like ('GAINSCO%') and Q_MONTH = @mm and Q_YEAR = @yyyy
  GROUP BY CARRIER, a.ZIP, Q_MONTH, LABEL, Q_YEAR, LABEL, TOTPREM, PROFILEP