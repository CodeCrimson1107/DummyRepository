use [Marketing]
go
select 
T1.AGENTCODE
,T2.Accounts
,T2.Codes
,T2.Accounts
,T1.RISKSTATE
,COUNT(*) as POLCNT
,YEAR(BOUND_DATE)*100+MONTH(bound_date) as YYYYMM

from dbo.NBPROFILE as T1

left join dbo.Code_Acc as T2 on T1.AGENTCODE = T2.Codes

where YEAR(BOUND_DATE)*100+MONTH(bound_date) >= 202001
group by 
T1.AGENTCODE
,T1.BOUND_DATE
,T1.AGENTCODE
,T2.Accounts
,T1.RISKSTATE
,T2.Codes
,T2.Accounts

union all

select
T1.AGENTCODE
,T2.Accounts
,T1.RISK_STATE
,T2.Codes
,T2.Accounts
,COUNT(*) as POLCNT
,YEAR(BOUND_DATE)*100+MONTH(bound_date) as YYYYMM

from dbo.NBPROFILE_DCDM as T1

left join dbo.Code_Acc as T2 on T1.AGENTCODE = T2.Codes

where YEAR(BOUND_DATE)*100+MONTH(bound_date) >= 202001


group by 
T1.AGENTCODE
,T1.BOUND_DATE
,T1.AGENTCODE
,T2.Accounts
,T1.RISK_STATE
,T2.Codes
,T2.Accounts

