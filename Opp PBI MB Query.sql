select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_AL
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL 

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_AR
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL 

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_AZ
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_FL
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_GA
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_IL
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL 

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_IN
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_MO
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_NM
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL 

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_OH
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_OK
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_SC
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_TN
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

UNION ALL

select SUM(quote) as QuoteCNT,Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,
CASE when PRICE_DIFFERENCE <= 0 then 'WIN'
	 when PRICE_DIFFERENCE <= 30 then '1_30'
     when PRICE_DIFFERENCE <= 60 then '31_60'
     when PRICE_DIFFERENCE <= 90 then '61_90'
     when PRICE_DIFFERENCE <= 120 then '91_120'
     else 'GE_121' end as Label
from dbo.MB_FULL_VA
where Company_Name_Program like 'GAIN%'
group by Company_Name_Program,ZipCode,YYYYMM,PROFILE,State,PRICE_DIFFERENCE,LABEL

