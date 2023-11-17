use [Marketing]
go
Declare @yyyy int
Set @yyyy = 2020

Declare @mm int 
Set @mm = 05
/*THIS IS JONAH'S TABLES*/
Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM,[State],Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'AZ' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AZ_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Profile], Term,Zipcode,
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff, yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM,[State], Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'OH' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,Zipcode,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OH_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Profile], Term,Zipcode,
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff, yyyymm1,Zipcode
UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM,[State], Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'IL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[IL_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Profile], Term,Zipcode,
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff, yyyymm1,Zipcode
UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,  yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'NM' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[NM_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  [Profile], Term, Zipcode,
             CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile],  TERM, 'OK' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OK_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  [Profile], Term,Zipcode,
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,  yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'TN' AS [STATE], (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TN_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=15 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term, Zipcode,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  , [Profile]
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff,  yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State],  Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile], TERM, 'TX' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TX_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)  and LiabLimits301 >=25 AND LiabLimits301<=30 AND LIABLIMITS101=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, Term, Zipcode,
              CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  ,  [Profile]
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State],  Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,  yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'VA' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[VA_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)   and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=20 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term, Zipcode,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  ,  [Profile]
              ) AS A
			 
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff,  yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'AL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AL_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm) AND  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term, [Profile],Zipcode,
               CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end
              ) AS A

Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], doldiff, yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],  TERM, [State], Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,   [Profile],  TERM, 'FL' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[FL_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)   and  LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Year], Term,  [Profile],Zipcode,
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
			
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], doldiff,  yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State],Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM,  RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], TERM, 'SC' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[SC_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)   and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo,  Term,  [Profile],Zipcode,
                CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A

Group by Company, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff, yyyymm1,Zipcode

UNION ALL

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium, RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [STATE],Zipcode,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, 
		 yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,Zipcode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],  TERM, 'GA' AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1, 
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[GA_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) = (@yyyy*100+@mm)   and  LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=25 AND LiabLimits301<=30 AND CO_Name like ('GAINSCO%')
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, Term,  [Profile],Zipcode,
               DRCNT , VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
		
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile],  TERM, [State], doldiff,  yyyymm1,Zipcode

UNION All

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM, [Profile], TERM, [State],Zipcode, LABEL, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CARRIER AS COMPANY, SUM(TOTPREM) AS TOTAL_PREMIUM,  RISK_AREA AS RISKAREA, P_LEVEL,a.ZIP as Zipcode,
		Q_YEAR AS QUOTE_YEAR, Q_MONTH AS QUOTE_MM, 
		PROFILEP AS [PROFILE], '6' AS TERM, 'UT' AS [STATE], LABEL, Q_YEAR*100 + Q_MONTH AS yyyymm1 
  FROM [MARKETING].[DBO].[UT_MB_SUBSET] AS A LEFT JOIN DBO.TERRKEY AS B ON A.ZIP = B.ZIP
  where CARRIER like ('GAINSCO%') AND (Q_YEAR*100+Q_MONTH) = (@yyyy*100+@mm)
  GROUP BY CARRIER, TOTPREM,  RISK_AREA, P_LEVEL, Q_MONTH,
		PROFILEP, LABEL, Q_YEAR,a.ZIP
	) as a
Group by Company,  RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile], TERM, [State], LABEL, yyyymm1,Zipcode


