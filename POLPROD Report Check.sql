use [Product]
go

SELECT 
sum(polcnt) as polcnt
,T1.AGENCY
,T2.Codes
,T2.Dba
,T2.Accounts
,T1.CALLYY
,T1.CALLMM
,T1.CALLDD
,T1.STATE
,T1.profilep

FROM [daldbrt01].[Product].[dbo].[POLPROD] as T1

left join [daldbcp06\reporting].[Marketing].[dbo].[Code_Acc] as T2 on T1.AGENCY = T2.Codes

where T1.BUSINESS = 'N' and T1.CALLYY >=2021

group by 
AGENCY
,CALLYY
,CALLMM
,STATE
,CALLDD
,profilep
,T2.Codes
,T2.Accounts
,T2.Dba