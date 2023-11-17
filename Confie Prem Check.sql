use [Marketing]
go

with PREMTABLE as

(select 
T2.[Agent Name]
,T2.[Group Code]
,sum(T1.WRITTENPREMIUM) as WP
, T1.SEQ
, T1.ACTDTE

from dbo.CURWP_TBL T1
left join dbo.Confie_Map T2 on T1.AGENTCODE = T2.Agency_Code

GROUP BY T2.[Agent Name], T2.[Group Code],SEQ, ACTDTE
) 
select 
sum(WP) as FinalWP
from PREMTABLE
where left(actdte,4) = 2021
and [Agent Name] is not null