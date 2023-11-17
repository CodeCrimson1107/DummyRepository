use [Marketing]
go
select (Q_YEAR*100+Q_MONTH) as YYYYMM,count (*) as CNT
from dbo.UT_MB
group by Q_YEAR*100+Q_MONTH
order by Q_YEAR*100+Q_MONTH