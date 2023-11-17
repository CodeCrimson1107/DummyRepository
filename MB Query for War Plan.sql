/*set yyyy as numberical date 3 mos before current date*/
use [Marketing]
go
declare @yyyy as integer, @CurDt as date, @PastDt as date
set @CurDt=GETDATE()
set @PastDt = DATEADD(month,-3,@curdt)
set @yyyy=YEAR(@PastDt)*100+MONTH(@PastDt)
select *,
  CASE when doldiff <= 0 then 'WIN'
                   when doldiff <= 30 then '1_30'
                     when doldiff <= 60 then '31_60'
                     when doldiff <= 90 then '61_90'
                     when doldiff <= 120 then '91_120'
                     else 'GE_121' end as Label
from (select *, 
 CASE WHEN ( left(rank1co,4) <> left(co_name,4) ) then (TOTPREM - RANK1PR)
                     WHEN ( left(RANK2CO,4) <> left(co_name,4) ) then (TOTPREM - RANK2PR)
                     WHEN ( left(RANK3CO,4) <> left(co_name,4) ) then (TOTPREM - RANK3PR)
                     WHEN ( left(RANK4CO,4) <> left(co_name,4) ) then (TOTPREM - RANK4PR)
                     else (TOTPREM - RANK5PR) end as doldiff

from dbo.GA_ITC_N) as a

 WHERE (Rate_Yr*100+Rate_Mo) >= @yyyy /*and LiabLimits101 >=25 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 