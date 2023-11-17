use [Policy_DataMart]
go
Declare @yyyy as  int = 2022
Declare @state as varchar(2) = 'AL'
Declare @source as varchar(10) = 'AS400'

with CTE (risk_state,source_system_name,as_of_date,[Month],[Year],[YYYYMM],[Quarter],lob,mpc,business,MTD_WP,MTD_EP,MTD_E_EXP,MTD_W_EXP)
(
	select 
		risk_state,
		source_system_name,
		as_of_date,
		MONTH([as_of_date]) as [Month],
		year([as_of_date]) as [Year],
		year([as_of_date])*100+month([as_of_date]) as [YYYYMM],
		DATEPART(quarter, as_of_date) AS [Quarter],
		lob,
		mpc,
		business,
		sum(premium_written_gross_mtd) as MTD_WP,
		sum(premium_earned_gross_mtd) as MTD_EP,
		sum(exposure_earned_mtd) as MTD_E_EXP,
		sum(exposure_written_mtd) as MTD_W_EXP
	from dbo.calculation_premium_and_exposure_aggregate
	where
		risk_state = @state
		and source_system_name = @source
		and year([as_of_date]) > @yyyy
	group by 
		source_system_name,
		as_of_date,
		risk_state,
		mpc,
		lob,
		business
	order by 
		risk_state,
		YYYYMM desc,
		source_system_name,
		as_of_date,
		mpc,
		business
)
select 
	sum(MTD_WP) as WP,
	sum(MTD_EP) as EP,
	sum(MTD_W_EXP) as W_EXP,
	sum(MTD_E_EXP) as E_EXP
from CTE