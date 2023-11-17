use [Marketing]
go
select Date_Data,count(*) as CNT
from dbo.MB_AGG_FL
group by Date_Data
order by Date_Data desc

