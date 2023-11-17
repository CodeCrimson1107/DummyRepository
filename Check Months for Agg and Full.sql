use [Marketing]
go
select
	date_data,
	count(*) as QTECNT
from dbo.mb_agg_al_new
group by 
	date_data
order by 
	date_data desc
;
use [Marketing]
go
select
	yyyymm,
	count(*) as QTECNT
from dbo.mb_full_al_new
group by 
	yyyymm
order by 
	yyyymm desc