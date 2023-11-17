use [Marketing]
go

/*THESE ARE JONAH'S TABLES*/
Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM,[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'AZ' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AZ_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Profile], Term,
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff, yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'NM' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[NM_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  [Profile], Term,
             CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile],  TERM, 'OK' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OK_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30  
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  [Profile], Term,
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],  
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'TN' AS [STATE], (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TN_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=15 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  , [Profile]
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff,  yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State],  
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile], TERM, 'TX' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TX_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and LiabLimits301 >=25 AND LiabLimits301<=30 AND LIABLIMITS101=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, Term,
              CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  ,  [Profile]
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],  
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'VA' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[VA_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=20 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  ,  [Profile]
              ) AS A
			 
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'AL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AL_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term, [Profile],
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff, yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile],  TERM, 'FL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[FL_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and  LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Year], Term, [Profile],
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
			
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff,  yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State],
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'SC' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[SC_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term, [Profile],
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff, yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [STATE],
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, 
	 yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'GA' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[GA_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= 202001 and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, Term, [Profile],
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
			  WHERE doldiff<=0
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff,  yyyymm1

UNION ALL
/***********************************************************************************************************************************************************************************************/
/*THIS IS OLD TABLES*/

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  AREA AS RISKAREA, PLEVEL AS P_LEVEL, TRANSYY AS QUOTE_YEAR, TRANSMM AS QUOTE_MM,TransYY*100+TransMM AS yyyymm1, 
		[PROFILE],  TERM, 'SC' AS [STATE],
		CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1_30'
			 WHEN RANK1DIFF <=60  THEN '31_60'
			 WHEN RANK1DIFF <=90  THEN '61_90'
			 WHEN RANK1DIFF <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL
  FROM [MARKETING].[DBO].[SC_MB]
  where TransYY*100 + TransMM <=201909
  GROUP BY COMPANY, TOTPREM, AREA, PLEVEL, TRANSYY , TransMM,
		[PROFILE],  CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1_30'
			 WHEN RANK1DIFF <=60  THEN '31_60'
			 WHEN RANK1DIFF <=90  THEN '61_90'
			 WHEN RANK1DIFF <=120 THEN '91_120'
			 ELSE 'GE_121' END, TERM
	) as a 

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL,  yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL,yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  AREA AS RISKAREA, PLEVEL AS P_LEVEL, TRANSYY AS QUOTE_YEAR, TRANSMM AS QUOTE_MM, 
		[PROFILE], TERM, 'FL' AS [STATE],
		CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1_30'
			 WHEN RANK1DIFF <=60  THEN '31_60'
			 WHEN RANK1DIFF <=90  THEN '61_90'
			 WHEN RANK1DIFF <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL,
			 TransYY*100+TransMM AS yyyymm1
  FROM [MARKETING].[DBO].[FL_MB]
  where TransYY*100+TransMM <=201909
  GROUP BY COMPANY, TOTPREM, AREA, PLEVEL, TRANSYY , TRANSMM, VYR,
		[PROFILE], NUMDRIV , NUMVEHL, CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1_30'
			 WHEN RANK1DIFF <=60  THEN '31_60'
			 WHEN RANK1DIFF <=90  THEN '61_90'
			 WHEN RANK1DIFF <=120 THEN '91_120'
			 ELSE 'GE_121' END, POP, TERM
		) as a
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile], TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM, MARKET AS RISKAREA, PLEVEL AS P_LEVEL, TRANSYY AS QUOTE_YEAR, TRANSMM AS QUOTE_MM, 
		[PROFILE], '6' AS TERM, 'GA' AS [STATE],
		CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1_30'
			 WHEN RANK1DIFF <=60  THEN '31_60'
			 WHEN RANK1DIFF <=90  THEN '61_90'
			 WHEN RANK1DIFF <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL,
TransYY*100 + TransMM as yyyymm1
  FROM [MARKETING].[DBO].[GA_MB]
  where EFFYY*100+EFFMM<=201910
  GROUP BY COMPANY, TOTPREM, MARKET, PLEVEL, TRANSYY , TRANSMM, 
		[PROFILE],  CASE WHEN RANK1DIFF <=0   THEN 'WIN'
			 WHEN RANK1DIFF <=30  THEN '1_30'
			 WHEN RANK1DIFF <=60  THEN '31_60'
			 WHEN RANK1DIFF <=90  THEN '61_90'
			 WHEN RANK1DIFF <=120 THEN '91_120'
			 ELSE 'GE_121' END
		) as a 
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL, yyyymm1

UNION All


Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL,yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISKAREA, P_LEVEL, 
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM, 
		[PROFILE],  TERM, 'TN' AS [STATE],
		CASE WHEN (TOTPREM - RANK1PR) <=0  THEN 'WIN'
		     WHEN (TOTPREM - RANK1PR) <=30 THEN '1_30'
			 WHEN (TOTPREM - RANK1PR) <=60 THEN '31_60'
			 WHEN (TOTPREM - RANK1PR) <=90 THEN '61_90'
			 WHEN (TOTPREM - RANK1PR) <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL,
	Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[TN_MB]
  where Rate_Yr*100 + Rate_Mo<=201912
  GROUP BY CO_NAME,  RISKAREA, P_LEVEL, RATE_YR , RATE_MO,
		[PROFILE], CASE WHEN (TOTPREM - RANK1PR) <=0  THEN 'WIN'
		     WHEN (TOTPREM - RANK1PR) <=30 THEN '1_30'
			 WHEN (TOTPREM - RANK1PR) <=60 THEN '31_60'
			 WHEN (TOTPREM - RANK1PR) <=90 THEN '61_90'
			 WHEN (TOTPREM - RANK1PR) <=120 THEN '91_120'
			 ELSE 'GE_121' END, TERM
		) as a 

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,  
		[PROFILE],  TERM, 'VA' AS [STATE],
		CASE WHEN (TOTPREM - RANK1PR) <=0  THEN 'WIN'
		     WHEN (TOTPREM - RANK1PR) <=30 THEN '1_30'
			 WHEN (TOTPREM - RANK1PR) <=60 THEN '31_60'
			 WHEN (TOTPREM - RANK1PR) <=90 THEN '61_90'
			 WHEN (TOTPREM - RANK1PR) <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL,
	Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[VA_MB]
  where Rate_Yr*100+Rate_Mo<=201912
  GROUP BY CO_NAME, CASE WHEN (TOTPREM - RANK1PR) <=0  THEN 'WIN'
		     WHEN (TOTPREM - RANK1PR) <=30 THEN '1_30'
			 WHEN (TOTPREM - RANK1PR) <=60 THEN '31_60'
			 WHEN (TOTPREM - RANK1PR) <=90 THEN '61_90'
			 WHEN (TOTPREM - RANK1PR) <=120 THEN '91_120'
			 ELSE 'GE_121' END,  RISKAREA, P_LEVEL, RATE_YR , RATE_MO,
		[PROFILE], TERM
		) as a 
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile], TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM, RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM, 
		[PROFILE],  '6' as TERM, 'AZ' AS [STATE], LABELS AS LABEL, Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[AZ_MB]
  GROUP BY CO_NAME, TOTPREM,  RISKAREA, P_LEVEL, RATE_YR, RATE_MO,
		[PROFILE],  LABELS
	) as a 

Group by Company,RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,[PROFILE] ,TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,  
		[PROFILE],  '6' as TERM, 'NM' AS [STATE], LABELS AS LABEL, Rate_Yr*100 + Rate_Mo as yyyymm1
  FROM [MARKETING].[DBO].[NM_MB_VCP]
  where (Rate_Yr*100+Rate_Mo)<=201912
  GROUP BY CO_NAME, TOTPREM, RISKAREA, P_LEVEL, RATE_YR, RATE_MO,
		[PROFILE],  LABELS
	) as a 
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,  
		[PROFILE],  '6' AS TERM, 'OK' AS [STATE], LABELS AS LABEL, Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[OK_MB]
  GROUP BY CO_NAME, TOTPREM,  RISKAREA, P_LEVEL, RATE_MO, 
		[PROFILE],  LABELS, RATE_YR
	) as a
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1
From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM, 
		[PROFILE],  '6' AS TERM, 'TX' AS [STATE], LABELS AS LABEL, Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[TX_MB]
  where (Rate_Yr*100+Rate_Mo)<=201912
  GROUP BY CO_NAME, TOTPREM, RISKAREA, P_LEVEL, RATE_MO, 
		[PROFILE], LABELS, RATE_YR
		) as a 

 Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile], TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CARRIER AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISK_AREA AS RISKAREA, P_LEVEL,
		Q_YEAR AS QUOTE_YEAR, Q_MONTH AS QUOTE_MM, 
		PROFILEP AS [PROFILE], '6' AS TERM, 'UT' AS [STATE], LABEL, Q_YEAR*100 + Q_MONTH AS yyyymm1 
  FROM [MARKETING].[DBO].[UT_MB_SUBSET] AS A LEFT JOIN DBO.TERRKEY AS B ON A.ZIP = B.ZIP
  GROUP BY CARRIER, TOTPREM,  RISK_AREA, P_LEVEL, Q_MONTH, 
		PROFILEP, LABEL, Q_YEAR
	) as a
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERMCO AS TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Lvl_tot AS P_LEVEL, Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM, 
		[PROFILE],  TERMCO, 'GA' AS [STATE],
		CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL, Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[GA_ITC]
  WHERE (Rate_Yr*100+Rate_Mo) >= 201911 and (Rate_Yr*100+Rate_Mo)<=201912
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Lvl_tot, Rate_Yr , Rate_Mo,
		[PROFILE],  CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END, TERMCO
		) as a
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERMCO, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL, Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM, 
		[PROFILE],  TERM, 'FL' AS [STATE],
		CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL, Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[FL_ITC]
  Where (Rate_Yr*100+Rate_Mo) >= 201910 AND (Rate_Yr*100+Rate_Mo)<=201912
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,
		[PROFILE], CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END,  TERM
		) as a
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL, Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM, 
		[PROFILE],  TERM, 'SC' AS [STATE],
		CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL, 
		Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[SC_ITC]
  WHERE (Rate_Yr*100+Rate_Mo) >= 201910 AND (Rate_Yr*100 + Rate_Mo)<=201912
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Year],
		[PROFILE],  CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END,  TERM
		) as a
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM, RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM,  
		[PROFILE],  '6' AS TERM, 'OK' AS [STATE], LABELS AS LABEL, Rate_Yr*100 + Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[OK_MB_VCP] 
  WHERE (Rate_Yr*100+Rate_Mo) = 201912
  GROUP BY CO_NAME, TOTPREM,  RISKAREA, P_LEVEL, RATE_MO, 
		[PROFILE],  LABELS, RATE_YR
	) as a
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1

UNION ALL
/*AL*/
Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], LABEL,yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  b.Risk_Area AS RISKAREA, b.P_LEVEL AS P_LEVEL, Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM, 
		[PROFILE],  TERM, 'AL' AS [STATE],
		CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END AS LABEL,
	Rate_Yr*100+Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[AL_ITC] as a left join dbo.[TerrKey] as b on a.ZipCode = b.ZIP
  WHERE (Rate_Yr*100+Rate_Mo) >= 201911 AND (Rate_Yr*100+Rate_Mo)<=201912
  GROUP BY CO_Name, TOTPREM, b.RISK_AREA, b.P_LEVEL, Rate_Yr , Rate_Mo, [Year],
		[PROFILE],CASE WHEN DOLDIFF1 <=0   THEN 'WIN'
			 WHEN DOLDIFF1 <=30  THEN '1_30'
			 WHEN DOLDIFF1 <=60  THEN '31_60'
			 WHEN DOLDIFF1 <=90  THEN '61_90'
			 WHEN DOLDIFF1 <=120 THEN '91_120'
			 ELSE 'GE_121' END, TERM, a.ZipCode
		) as a
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

UNION ALL
Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_NAME AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISKAREA, P_LEVEL,
		RATE_YR AS QUOTE_YEAR, RATE_MO AS QUOTE_MM, 
		[PROFILE],  '6' as TERM, 'AZ' AS [STATE], LABELS AS LABEL, Rate_Yr*100+Rate_Mo AS yyyymm1
  FROM [MARKETING].[DBO].[AZ_MB_VCP]
  where Rate_Yr*100+Rate_Mo=201912
  GROUP BY CO_NAME, TOTPREM,  RISKAREA, P_LEVEL, RATE_YR, RATE_MO,
		[PROFILE], LABELS
	) as a 

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1


