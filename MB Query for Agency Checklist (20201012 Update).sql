Declare @yyyy int
Set @yyyy = 2020

Declare @mm int 
Set @mm = 08
Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'AZ' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AZ_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'AL' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AL_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'AL' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[AR_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'FL' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[fl_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'GA' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[ga_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'IL' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[IL_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'IN' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[IN_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'OH' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OH_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'OK' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OK_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'NM' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[NM_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'SC' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[sc_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'TN' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TN_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'TX' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[TX_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

Select sum(Quotes) as Quote, Company,ZipCode,QUOTE_YEAR, QUOTE_MM,  [Profile],[State], 
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label,
			Case when Company like 'GAIN%' then 1 else 0 end as Prim_Co

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company,ZipCode,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile], 'VA' AS [STATE],
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[va_ITC_N]
  WHERE RATE_MO = @mm and RATE_YR = @yyyy and CO_Name like 'GAINSCO%'
  GROUP BY CO_Name, ZipCode, Rate_Yr , Rate_Mo, [Profile],
				 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by ZipCode,Company, QUOTE_YEAR, QUOTE_MM,  [Profile], [State], doldiff

UNION ALL

SELECT COUNT(TOTPREM) AS QUOTES, CARRIER AS COMPANY, a.ZIP as Zipcode, 
		Q_YEAR AS QUOTE_YEAR, Q_MONTH AS QUOTE_MM, PROFILEP as Profile,'UT' as [State],
		Case when LABEL = '1_30' then '1 to 30'
			 when label = '31_60' then '31 to 60'
			 when LABEL = '61_90' then '61 to 90'
			 when label = '91_120' then '91 to 120'
			 when label = 'GE_121' then '=>121'
			 else Label end as Label 
		, Case when CARRIER like '%EFT%' then 1 else 0 end as Prim_Co
  FROM [MARKETING].[DBO].[UT_MB_Subset] AS A LEFT JOIN DBO.TERRKEY AS B ON A.ZIP = B.ZIP
  Where CARRIER like ('GAINSCO%') and Q_MONTH = 10 and Q_YEAR = 2019
  GROUP BY CARRIER, a.ZIP, Q_MONTH, LABEL, Q_YEAR, LABEL, TOTPREM, PROFILEP