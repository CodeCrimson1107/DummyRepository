use [Marketing]
go
Declare @yyyy int
Set @yyyy = 2020

Declare @mm int 
Set @mm = 02

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM,[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'AZ' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AZ_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Profile], Term, ZipCode,
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff, yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'NM' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[NM_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  [Profile], Term, ZipCode,
             CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile],  TERM, 'OK' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OK_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30  
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  [Profile], Term,ZipCode,
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],  
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'TN' AS [STATE], (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TN_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=15 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term, ZipCode,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  , [Profile]
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff,  yyyymm1,  ZipCode

UNION ALL
Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State],  
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile], TERM, 'TX' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TX_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and LiabLimits301 >=25 AND LiabLimits301<=30 AND LIABLIMITS101=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, Term, ZipCode,
              CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  ,  [Profile]
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1, ZipCode


UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],  
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'VA' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[VA_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=20 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term,  ZipCode,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  ,  [Profile]
              ) AS A
			 
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'AL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AL_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term,  ZipCode, [Profile],
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff, yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile],  TERM, 'FL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[FL_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and  LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Year], Term,  ZipCode, [Profile],
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
			
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff,  yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State],
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode,yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'SC' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[SC_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term,  ZipCode,[Profile],
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff, yyyymm1, ZipCode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [STATE],
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, 
		ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'GA' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1, ZipCode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[GA_ITC_N]
  WHERE CO_Name like '%GAIN%' and Rate_Mo = @mm and Rate_Yr= @yyyy and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, Term,  ZipCode,[Profile],
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
		
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff,  yyyymm1, ZipCode
