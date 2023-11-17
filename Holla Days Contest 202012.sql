use [Marketing]
go
select agentcode,POLICY,BOUND_DATE,CHANNEL,((YEAR(bound_date)*10000)+(MONTH(bound_date)*100)+DAY(bound_date)) as BNDDTE
from dbo.nbprofile
where ((YEAR(bound_date)*10000)+(MONTH(bound_date)*100)+DAY(bound_date)) > 20201206 and channel = 'INDPTAGENT'
group by AGENTCODE,POLICY,BOUND_DATE,CHANNEL