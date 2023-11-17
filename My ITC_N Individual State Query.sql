use Marketing
go
Select sum(won) as win, COUNT(ToTPREM) as quote, sum(TotPREM) as TotPREM
, vehcnt2 as VEHCNT
, YYYYMM
, CO_Name
, RiskArea
, P_LEVEL
, POP
, Profile
, rate
, DR_MIX
, City
, Gender
, MARITALNI
, DRCNT
,  Bridged
, HO
, LAPSE
, COMP_CNT
, GAINSCO
From (
	SELECT
	case when vehcnt = 1 then '1' 
		when vehcnt = 2 then '2'
		when vehcnt = 3 then '3'
		else '4+'
		end as vehcnt2 ,
	*, 
		(Rate_Yr*100+Rate_Mo) as yyyymm
	FROM [Marketing].[dbo].[ok_ITC_N]
	where (rate_yr*100+Rate_Mo) >= 201910 ) as a

	group by 
	vehcnt2 
, YYYYMM
, CO_Name
, RiskArea
, P_LEVEL
, POP
, Profile
, rate
, DR_MIX
, City
, Gender
, MARITALNI
, DRCNT
, Bridged
, HO
, LAPSE
, COMP_CNT
, GAINSCO
      ,[SR22]
      ,[Model]
	  ,YEAR