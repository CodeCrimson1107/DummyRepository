use [Marketing]
go
select Company_Name_Program,TotalPremium_Term_Adj,Company_Name01,TotalPremium_Term_Adj01,PRICE_DIFFERENCE,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_VA
group by Company_Name_Program,TotalPremium_Term_Adj,Company_Name01,TotalPremium_Term_Adj01,PRICE_DIFFERENCE