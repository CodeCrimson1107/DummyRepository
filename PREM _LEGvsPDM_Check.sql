use [Policy_DataMart]
go
--Declare @yyyy as  int = 2021
--Declare @state as varchar(2) = 'AL'
--Declare @source as varchar(10) = 'AS400'

with CTE as 
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
		risk_state = 'AZ'
		and year([as_of_date])*100+month([as_of_date]) = 202301
		--and source_system_name = @source
		--and year([as_of_date]) > 2022
	group by 
		source_system_name,
		as_of_date,
		risk_state,
		mpc,
		lob,
		business
	--order by 
	--	risk_state,
	--	YYYYMM desc,
	--	source_system_name,
	--	as_of_date,
	--	mpc,
	--	business
)
select
	format(sum(MTD_WP),'#,#.##') as WRITTENPREM,
	format(sum(mtd_ep),'#,#.##') as EARNEDPREM,
	format(sum(mtd_W_EXP),'#,#.##') as WRITTENEXP,
	format(sum(mtd_e_exp),'#,#.##') as EARNEDEXP

from CTE
;
Select		--owner_nonowner,
			--case when owner_nonowner in ('EN') and MPC in ('ABI','APD') then 'NON' else LOB end as lob_incl_non, 
			--MPC, 
			format(Sum(Premium_change),'#,#.##') as WRITTEN_PREMIUM,
			format(sum(Premium_earned),'#,#.##') as EARNED_PREMIUM,
			format(sum(exposure_change),'#,#.##') as WRITEN_EXPOSURE,
			format(Sum(exposure_earned),'#,#.##') as EARNED_EXPOSURE
FROM		[DuckCreek_DataMart].[dbo].[EarnedCalculation_202301]
where		state_name in ('AZ')
--Group by	owner_nonowner, 
--			LOB, 
--			MPC
--order by	owner_nonowner desc, 
--			LOB, 
--			MPC