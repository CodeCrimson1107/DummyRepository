use Marketing
go
Select sum(won) as win, sum(quote) as quote, sum(TotPREM) as TotPREM, vehcnt2 as vehcnt , yyyymm, 
CO_Name, RiskArea, P_LEVEL, POP, profile, rate, dr_mix, city, gender, 
marital, DRCNT,  Bridged, ho, lapse, COMP_CNT, GAINSCO, LABELS
From (
	SELECT case when LABELS = 'WIN' then 1 else 0 end as won, 1 as quote,

	case when vehcnt = 1 then '1' 
		when vehcnt = 2 then '2'
		when vehcnt = 3 then '3'
		else '4+'
		end as vehcnt2 ,

	*, 
		(Rate_Yr*100+Rate_Mo) as yyyymm
	FROM [Marketing].[dbo].[TX_MB]
	where (rate_yr*100+Rate_Mo) >= 201911 ) as a 

	group by vehcnt2, yyyymm, CO_Name, RiskArea, P_LEVEL, POP, 
			profile, rate, dr_mix, city, gender, marital, DRCNT, Bridged, ho, 
			lapse, COMP_CNT, GAINSCO, LABELS