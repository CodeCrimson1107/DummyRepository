use [Marketing]
go
declare @yyyy as integer, @CurDt as date, @PastDt as date, @state as char(2)
set @CurDt=GETDATE()
set @PastDt=DATEADD(MONTH,-3,@CurDt)
set @yyyy= YEAR(@PastDt)*100+MONTH(@PastDt)
set @state='OK'

Select sum(Quotes) as Quote, Company, sum(TOTAL_PREMIUM) as Total_Premium,RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,[Profile],HO,POP,County,VEHCNT,DRCNT,MAKER,MODEL,Won,TERM,[State],maritalni,RANK1CO,RANK2CO,RANK3CO,RANK4CO,RANK5CO,
              CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label, ZipCode, yyyymm1

From (SELECT COUNT(TOTPREM) AS QUOTES, CO_Name as Company, SUM(TOTPREM) AS TOTAL_PREMIUM, RiskArea AS RISKAREA, P_Level AS P_LEVEL,MARITALNI,RANK1CO,RANK2CO,RANK3CO,RANK4CO,RANK5CO,
              Rate_Yr AS QUOTE_YEAR, Rate_Mo AS QUOTE_MM,  [Profile],HO,POP,County,VEHCNT,DRCNT,MAKER,MODEL,TERM, @state AS [STATE],  (Rate_Yr*100+Rate_Mo) as yyyymm1,ZipCode,Won,
                     CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff
  FROM [MARKETING].[DBO].[OK_ITC_N]
  WHERE (Rate_Yr*100+Rate_Mo) >= @yyyy and LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 
  GROUP BY CO_Name, TOTPREM, RiskArea, P_Level, Rate_Yr , Rate_Mo, [Profile],HO,POP,County,VEHCNT,DRCNT,MAKER ,MODEL,Term, ZipCode,Won,MARITALNI,RANK1CO,RANK2CO,RANK3CO,RANK4CO,RANK5CO,
               DRCNT, VEHCNT, CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end  
              ) AS A
	
Group by Company,RISKAREA, P_LEVEL, QUOTE_YEAR, QUOTE_MM,  [Profile],HO,POP,County,VEHCNT,DRCNT,MAKER, MODEL,TERM, [State], doldiff, yyyymm1, ZipCode, Won,MARITALNI,RANK1CO,RANK2CO,RANK3CO,RANK4CO,RANK5CO