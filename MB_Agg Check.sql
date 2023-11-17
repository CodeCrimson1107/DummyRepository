use [Marketing]
go
select distinct(date_data),sum(quotecnt) as CNT
from dbo.MB_AGG_in
--where CompanyName_program = 'GAIN%'
group by date_data
order by date_data