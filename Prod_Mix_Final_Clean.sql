DECLARE @StartDate date = ''

--End Date (not inclusive)
--Defaults to beginning of current week
DECLARE @EndDate date = ''

/*********************************************************/
--Variable Declaration
--***Remember*** start date is inclusive, end date is not
SET NOCOUNT ON;
DECLARE @ED date = '2025-03-03' --CASE WHEN @EndDate = '' THEN DATEADD(dd,-1,DATEADD(ww,DATEDIFF(ww,0,GETDATE()),0)) ELSE @EndDate END
DECLARE @SD date = '2021-01-01' /*DATEADD(yy,-1,@ED)*/
SET @EndDate = '2025-03-03'	--CASE WHEN @EndDate = '' THEN DATEADD(dd,-1,DATEADD(ww,DATEDIFF(ww,0,GETDATE()),0)) ELSE @EndDate END
SET @StartDate = '2021-01-01' /*CASE WHEN @StartDate = '' THEN DATEADD(ww,-1,@ED) WHEN @StartDate = '2015-06-01' THEN '2015-05-31' ELSE @StartDate END*/

IF object_ID('tempDB.dbo.#transactions') IS NOT NULL DROP TABLE #transactions
IF object_ID('tempDB.dbo.#new_PolicyList') IS NOT NULL DROP TABLE #new_PolicyList
IF object_ID('tempDB.dbo.#if_PolicyList') IS NOT NULL DROP TABLE #if_PolicyList
IF object_ID('tempDB.dbo.#List') IS NOT NULL DROP TABLE #List
IF object_ID('tempDB.dbo.#driverInfo') IS NOT NULL DROP TABLE #driverInfo
IF object_ID('tempDB.dbo.#vehicleLimitDeductible') IS NOT NULL DROP TABLE #vehicleLimitDeductible
IF object_ID('tempDB.dbo.#vehicleInfo') IS NOT NULL DROP TABLE #vehicleInfo
IF object_ID('tempDB.dbo.#vehicledriver') IS NOT NULL DROP TABLE #vehicledriver
IF object_ID('tempDB.dbo.#ftp') IS NOT NULL DROP TABLE #ftp
IF object_ID('tempDB.dbo.#final') IS NOT NULL DROP TABLE #final
IF object_ID('tempDB.dbo.#final_inforce') IS NOT NULL DROP TABLE #final_inforce
IF object_ID('tempDB.dbo.#final_new') IS NOT NULL DROP TABLE #final_new
IF object_ID('tempDB.dbo.#final_prep') IS NOT NULL DROP TABLE #final_prep
IF object_ID('tempDB.dbo.#policyholder_info') IS NOT NULL DROP TABLE #policyholder_info


--Table Creation
CREATE TABLE #final_inforce(
	[runType] varchar(20),
	[Year] int,
	[Month] int,
	[Week] int,
	[YM] int,
	[YW] int,
	[YMW] int,
	[State] varchar(2),
	[Product_Territory] varchar(250),
	[Product_County] varchar(250),
	[Product_City] varchar(250),
	[Zip] varchar(250),
	[Agency_Name] varchar(250),
	[Agency_Code] varchar(250),
	[Term] int,
	[Credit_Score] varchar(250),
	[Policy_Count] int,
	[Prior_Insurance_Policy_Count] int,
	[Homeownership_Policy_Count] int,
	[Recurring_Payment_Policy_Count] int,
	[Paid_in_full_Policy_Count] int,
	[In-Agency_Transfer_Policy_Count] int,
	[Prior_Hallmark_Insurance_Policy_Count] int,
	[MultiPolicy_Policy_Count] int,
	[Advance_Quote_Policy_Count] int,
	[MultiCar_Policy_Count] int,
	[Excluded_Driver_Policy_Count] int,
	[FDL_Policy_Count] int,
	[YD_Policy_Count] int,
	[Married_Insured_Policy_Count] int,
	[Married_Driver_Policy_Count] int,
	[All_LO_Policy_Count] int,
	[All_FC_Policy_Count] int,
	[Some_FC_Policy_Count] int,
	[Limited_Policy_Count] int,
	[NonOwner_Policy_Count] int,
	[Standard_Policy_Count] int,
	[Equal_Vehicle_Driver_Policy_Count] int,
	[Excess_Vehicle_Policy_Count] int,
	[Excess_Driver_Policy_Count] int,
	[Vehicle_Count] int,
	[Liability_Only_Vehicle_Count] int,
	[Full_Coverage_Vehicle_Count] int,
	[Driver_Count] int,
	[Rated_Driver_Count] int,
	[Excluded_Driver_Count] int,
	[Excluded_Spouse_Driver_Count] int,
	[FDL_Driver_Count] int,
	[YD_Driver_Count] int,
	[Married_Insured_Count] int,
	[Married_Driver_Count] int,
	[Fullterm_Premium] float
)

CREATE TABLE #final_new(
	[runType] varchar(20),
	[Year] int,
	[Month] int,
	[Week] int,
	[YM] int,
	[YW] int,
	[YMW] int,
	[State] varchar(2),
	[Product_Territory] varchar(250),
	[Product_County] varchar(250),
	[Product_City] varchar(250),
	[Zip] varchar(250),
	[Agency_Name] varchar(250),
	[Agency_Code] varchar(250),
	[Term] int,
	[Credit_Score] varchar(250),
	[Policy_Count] int,
	[Prior_Insurance_Policy_Count] int,
	[Homeownership_Policy_Count] int,
	[Recurring_Payment_Policy_Count] int,
	[Paid_in_full_Policy_Count] int,
	[In-Agency_Transfer_Policy_Count] int,
	[Prior_Hallmark_Insurance_Policy_Count] int,
	[MultiPolicy_Policy_Count] int,
	[Advance_Quote_Policy_Count] int,
	--[MultiCar_Policy_Count] int,
	[Excluded_Driver_Policy_Count] int,
	[FDL_Policy_Count] int,
	[YD_Policy_Count] int,
	[Married_Insured_Policy_Count] int,
	[Married_Driver_Policy_Count] int,
	[All_LO_Policy_Count] int,
	[All_FC_Policy_Count] int,
	[Some_FC_Policy_Count] int,
	[Limited_Policy_Count] int,
	[NonOwner_Policy_Count] int,
	[Standard_Policy_Count] int,
	[Equal_Vehicle_Driver_Policy_Count] int,
	[Excess_Vehicle_Policy_Count] int,
	[Excess_Driver_Policy_Count] int,
	[Vehicle_Count] int,
	[Liability_Only_Vehicle_Count] int,
	[Full_Coverage_Vehicle_Count] int,
	[Driver_Count] int,
	[Rated_Driver_Count] int,
	[Excluded_Driver_Count] int,
	[Excluded_Spouse_Driver_Count] int,
	[FDL_Driver_Count] int,
	[YD_Driver_Count] int,
	[Married_Insured_Count] int,
	[Married_Driver_Count] int,
	[Fullterm_Premium] float
)

CREATE TABLE #transactions (
	[Year] int,
	[Month] int,
	[Week] int,
	[Day] int, 
	[Weekday] varchar(20),
	[lob_id] int,
	[state] varchar(2),
	[policy] varchar(20),
	[policy_id] int,
	[policyimage_num] int,
	[renewal_ver] int,
	[teff_date] date,
	[texp_date] date,
	[trans_date] datetime,
	[new_count] int,
	[renewal_count] int,
	[rewrite_count] int,
	[reinstate_count] int,
	[cancel_count] int,
	[endorsement_count] int,
	[expire_count] int,
	[net_change] int
)

CREATE TABLE #new_PolicyList (
	policy_id int,
	policyimage_num int,
	teff_date date,
	texp_date date
)

CREATE TABLE #if_PolicyList (
	policy_id int,
	policyimage_num int
)

CREATE TABLE #List (
	policy_id int,
	policyimage_num int,
	teff_date date,
	texp_date date
)

--select teff_date, count(policy_id) from #new_PolicyList 
----where teff_date = '2024-06-12'
--group by teff_date
--order by teff_date

--Executes Transactions stored procedure for entire time period to reduce number of runs
INSERT INTO #transactions
EXEC [Construct].[dbo].[Transactions_sp] @SD,@ED,'',1

--New App list
INSERT INTO #new_PolicyList
SELECT
	[policy_id],
	[policyimage_num],
	teff_date,
	texp_date
FROM
	#transactions
WHERE
	new_count = 1
	and lob_id = 1
	and teff_date >= @SD
	and teff_date < @ED

--New App list for later
INSERT INTO #List
	SELECT * FROM #new_PolicyList

--Driver Information
SELECT
	pl.policy_id,
	pl.policyimage_num,
	pl.teff_date,
	pl.texp_date,
	vd.driver_num,
	CASE vd.driverexcludetype_id WHEN 1 THEN 1 ELSE 0 END rated,
	CASE vd.driverexcludetype_id WHEN 3 THEN 1 ELSE 0 END excluded,
	CASE
		WHEN vd.driverexcludetype_id = 3 and der.dscr <> 'Not in Household' THEN 1
		ELSE 0
		END excluded_driver_surcharge,
	rt.relationshiptype_id,
	rt.dscr Relationship,
	vd.driverexcludetype_id,
	det.dscr driverexcludetype_dscr,
	vd.driverexcludereason_id,
	der.dscr driverexcludereason_dscr,
	vd.maritalstatus_id,
	CASE
		WHEN vp.eff_date > vd.eff_date THEN vp.eff_date
		ELSE vd.eff_date
		END eff_date,
	ISNULL(NULLIF(vd.class_code,''),
		CASE
			WHEN vd.sex_id = 1 THEN 'M'
			ELSE 'F'
			END  
			+
		CASE
			WHEN vd.maritalstatus_id = 2 THEN 'M'
			ELSE 'S'
			END
			+
		CAST(CASE
			WHEN 100 * DATEPART(mm,vp.eff_date) + DATEPART(dd,vp.eff_date) >= 100 * DATEPART(mm,vd.birth_date) + DATEPART(dd,vd.birth_date)
				THEN (CASE
					WHEN DATEPART(yy,vp.eff_date) - DATEPART(yy,vd.birth_date) > 85
						THEN 85
					ELSE DATEPART(yy,vp.eff_date) - DATEPART(yy,vd.birth_date)
					END)
			ELSE (CASE
				WHEN DATEPART(yy,vp.eff_date) - DATEPART(yy,vd.birth_date) - 1 > 85
					THEN 85
				ELSE DATEPART(yy,vp.eff_date) - DATEPART(yy,vd.birth_date) - 1
				END)
			END as varchar(2))
			) class_code,
	CASE 
		WHEN vd.licensestatus_id in (6,11) THEN 1
		ELSE 0
		END FDL
INTO #driverInfo
FROM
	#List pl
	LEFT JOIN diamond.dbo.vpolicyimagexml vp on pl.policy_id = vp.policy_id and pl.policyimage_num = vp.policyimage_num
	LEFT JOIN diamond.dbo.vDriver vd on pl.policy_id = vd.policy_id and pl.policyimage_num = vd.policyimage_num
	LEFT JOIN diamond.dbo.driverexcludetype det on det.driverexcludetype_id = vd.driverexcludetype_id
	LEFT JOIN diamond.dbo.driverexcludereason der on der.driverexcludereason_id = vd.driverexcludereason_id
	LEFT JOIN diamond.dbo.RelationshipType rt on vd.relationshiptype_id = rt.relationshiptype_id
	LEFT JOIN diamond.dbo.LicenseStatus ls on ls.licensestatus_id = vd.licensestatus_id
WHERE
	vd.detailstatuscode_id = 1
--	year(vp.eff_date) >= 2022

--Preliminary Vehicle Coverage Information
SELECT
	policy_id,
	policyimage_num,
	teff_date,
	texp_date,
	vehicle_num,
	ISNULL([BI],'0') [BI_PP_Limit],
	ISNULL([COMP],'0') [COMP_Deductible]
INTO #vehicleLimitDeductible
FROM(
	SELECT
		pl.policy_id,
		pl.policyimage_num,
		pl.teff_date,
		pl.texp_date,
		vv.vehicle_num,
		cc.coveragecode,
		CASE
			WHEN cc.coveragecode = 'BI' THEN CAST(CAST(cl.perperson_limit as int)/1000 as varchar(5)) + '/' + CAST(CAST(cl.peroccur_limit as int)/1000 as varchar(5))
			WHEN cc.coveragecode = 'COMP' THEN CAST(CAST(cl.deductible as int) as varchar(20))
			ELSE '0'
			END [Limit_Deductible]
	FROM
		#List pl
		LEFT JOIN diamond.dbo.vVehicle vv on pl.policy_id = vv.policy_id and pl.policyimage_num = vv.policyimage_num
		LEFT JOIN diamond.dbo.coverage c on vv.policy_id = c.policy_id and vv.policyimage_num = c.policyimage_num and vv.vehicle_num = c.unit_num
		LEFT JOIN diamond.dbo.coveragecode cc on cc.coveragecode_id = c.coveragecode_id
		LEFT JOIN diamond.dbo.coveragelimit cl on c.coveragelimit_id = cl.coveragelimit_id
	WHERE
		vv.detailstatuscode_id = 1
		and c.detailstatuscode_id = 1
		and cc.coveragecode_id in (1,3)
	)a
	PIVOT(
		MAX([Limit_Deductible])
		FOR coveragecode in (
			[BI],
			[COMP])) pvt

--select * from #vehicleLimitDeductible

--Vehicle Information
SELECT
	pl.policy_id,
	pl.policyimage_num,
	pl.teff_date,
	pl.texp_date,
	vv.vehicle_num,
	CASE vv.VIN
		WHEN 'NON OWNED' THEN 1
		ELSE 0
		END [Non_Owned],
	CASE 
		WHEN vld.[COMP_Deductible] = '0' THEN 0
		ELSE 1
		END [Full_Coverage]
INTO #vehicleInfo
FROM
	#List pl
	LEFT JOIN diamond.dbo.vVehicle vv on pl.policy_id = vv.policy_id and pl.policyimage_num = vv.policyimage_num
	LEFT JOIN #vehicleLimitDeductible vld on vld.policy_id = pl.policy_id and vld.policyimage_num = pl.policyimage_num and vld.vehicle_num = vv.vehicle_num
WHERE
	vv.detailstatuscode_id = 1

--select * from #vehicleInfo

--Policyholder Info
SELECT
	DI.policy_id,
	DI.policyimage_num, 
	DI.teff_date,
	DI.texp_date,
	DI.class_code,
	DI.FDL,
	count(drive.driver_num) as [Driver_Sum],
	CASE
		WHEN RIGHT(DI.class_code,1) = '*' THEN 'No Age'
		WHEN CAST(RIGHT(DI.class_code,2) as int) < 25 THEN '<25'
		WHEN CAST(RIGHT(DI.class_code,2) as int) <= 35 THEN '25-35'
		WHEN CAST(RIGHT(DI.class_code,2) as int) <= 45 THEN '36-45'
		WHEN CAST(RIGHT(DI.class_code,2) as int) <= 65 THEN '46-65'
		WHEN CAST(RIGHT(DI.class_code,2) as int) > 65 THEN '66+'
		ELSE 'No Age'
		END [Primary_Insured_Age]
INTO #policyholder_info
FROM (
	select 
		policy_id,
		policyimage_num,
		teff_date,
		texp_date,
		class_code,
		FDL
	from #driverInfo
	where driver_num = 1
	group by 
		policy_id,
		policyimage_num,
		teff_date,
		texp_date,
		class_code,
		FDL
)DI
left join #driverInfo drive on DI.policy_id = drive.policy_id and DI.policyimage_num = drive.policyimage_num
where drive.rated = 1
group by 
	DI.policy_id,
	DI.policyimage_num,
	DI.teff_date,
	DI.texp_date,
	DI.class_code,
	DI.FDL

order by 
	policy_id,
	policyimage_num,
	DI.teff_date,
	DI.texp_date,
	class_code,
	FDL

--Preliminary policy level vehicle-driver and excluded driver surcharge table
SELECT
	b.policy_id,
	b.policyimage_num,
	b.teff_date,
	b.texp_date,
	pol.class_code,
	pol.Primary_Insured_Age,
	SUM(b.[Vehicle_Count]) as [Vehicle_Count_Sum],
	sum(b.[Full_Coverage_Vehicle_Count]) as [Full_Coverage_Vehicle_Sum],
	sum(b.[Vehicle_Count]) - sum(b.[Full_Coverage_Vehicle_Count]) as [Liability_Only_Vehicle_Count],
	CASE 
		WHEN sum(b.[Full_Coverage_Vehicle_Count]) = sum(b.[Vehicle_Count]) THEN 'FC'
		WHEN sum(b.[Full_Coverage_Vehicle_Count]) = 0 THEN 'LO'
		ELSE 'Mixed'
		END [Vehicle_Profile],
	sum(b.Driver_Count) as [Driver_Sum],
	SUM(b.[Rated_Driver_Count]) as [Rated_Driver_Sum],
	CASE 
		WHEN SUM(b.[Vehicle_Count]) > 1 THEN 'Multi-Car'
		ELSE 'Single-Car'
		END [Multi_Car],
	CASE 
		WHEN sum(b.[NonOwner_Vehicle_Count]) > 0 THEN 1
		ELSE 0
		END [NonOwner_Policy_Count],
	CASE 
		WHEN sum(b.[NonOwner_Vehicle_Count]) = 0 THEN 'N'
		ELSE 'Y'
		END [NonOwner],
	CASE
        WHEN SUM(b.[Vehicle_Count]) not in (1,2,3) THEN '4+'
        ELSE CAST(SUM(b.[Vehicle_Count]) as varchar(2))
		END
		+
		'_'
		+
		CASE
			WHEN SUM(b.[Rated_Driver_Count]) not in (1,2,3) THEN '4+'
			ELSE CAST(SUM(b.[Rated_Driver_Count]) as varchar(2))
		END AS
		[Vehicle_Driver],
	CASE
		WHEN sum(b.[Vehicle_Count]) = sum(b.[Rated_Driver_Count]) THEN 'Equal'
		WHEN sum(b.[Vehicle_Count]) > sum(b.[Rated_Driver_Count]) THEN 'Excess Vehicle'
		WHEN sum(b.[Vehicle_Count]) < sum(b.[Rated_Driver_Count]) THEN 'Excess Driver'
		END [Macro_Vehicle_Driver],
	CASE
		WHEN sum(b.[Vehicle_Count]) = sum(b.[Rated_Driver_Count]) THEN 1
		ELSE 0
		END [Equal_Vehicle_Driver_Policy_Count],
	CASE
		WHEN sum(b.[Vehicle_Count]) > sum(b.[Rated_Driver_Count]) THEN 1
		ELSE 0
		END [Excess_Vehicle_Policy_Count],
	CASE
		WHEN sum(b.[Vehicle_Count]) < sum(b.[Rated_Driver_Count]) THEN 1
		ELSE 0
		END [Excess_Driver_Policy_Count],
	sum([Excluded_Driver_Count]) as [Sum_Excluded_Driver_Count],
	CASE 
		WHEN sum([Excluded_Driver_Count]) = 0 THEN 0
		ELSE 1
		END [Excluded_Driver_Policy_Count],
	CASE 
		WHEN sum([Excluded_Spouse_Driver_Count]) = 0 THEN 0
		ELSE 1
		END [Excluded_Spouse_Driver_Sum],
	CASE 
		WHEN sum([YD_Driver_Count]) = 0 THEN 0
		ELSE 1
		END [YD_Policy_Sum],
	Sum([YD_Driver_Count]) as [YD_Driver_Sum],
	CASE 
		WHEN sum([FDL_Driver_Count]) = 0 THEN 'Domestic'
		WHEN sum([FDL_Driver_Count]) = sum(Driver_Count) THEN 'Foreign'
		ELSE 'Mixed'
		END [License_Type],
	sum([FDL_Driver_Count]) as [FDL_Driver_Sum],
	CASE 
		WHEN sum([Married_Insured_Count]) = 0 THEN 'N'
		ELSE 'Y'
		END [Married],
	sum([Married_Driver_Count]) as [Married_Driver_Policy_Count],
	sum([Married_Driver_Count]) as [Married_Driver_Count]
INTO #vehicleDriver
FROM
	(SELECT
		a.policy_id,
		a.policyimage_num,
		a.teff_date,
		a.texp_date,
		SUM(a.[Vehicle_Count]) [Vehicle_Count],
		SUM(a.[Full_Coverage_Vehicle_Count]) [Full_Coverage_Vehicle_Count],
		SUM(a.[NonOwner_Vehicle_Count]) [NonOwner_Vehicle_Count],
		SUM(a.[Driver_Count]) [Driver_Count],
		SUM(a.[Rated_Driver_Count]) [Rated_Driver_Count],
		SUM(a.[Excluded_Spouse_Driver_Count]) [Excluded_Spouse_Driver_Count],
		SUM(a.[Excluded_Driver_Count]) [Excluded_Driver_Count],
		SUM(a.[YD_Driver_Count]) [YD_Driver_Count],
		SUM(a.[FDL_Driver_Count]) [FDL_Driver_Count],
		SUM(a.[Married_Insured_Count]) [Married_Insured_Count],
		SUM(a.[Married_Driver_Count]) [Married_Driver_Count]

	FROM
		(SELECT
			v.policy_id,
			v.policyimage_num,
			v.teff_date,
			v.texp_date,
			COUNT(v.vehicle_num) [Vehicle_Count],
			SUM([Full_Coverage]) [Full_Coverage_Vehicle_Count],
			SUM([Non_Owned]) [NonOwner_Vehicle_Count],
			0 [Driver_Count],
			0 [Rated_Driver_Count],
			0 [Excluded_Spouse_Driver_Count],
			0 [Excluded_Driver_Count],
			0 [YD_Driver_Count],
			0 [FDL_Driver_Count],
			0 [Married_Insured_Count],
			0 [Married_Driver_Count]
		FROM
			#vehicleInfo v
		--where policy_id = 47994777
		GROUP BY
			v.policy_id,
			v.policyimage_num,
			v.teff_date,
			v.texp_date
	
		UNION

		SELECT
			d.policy_id,
			d.policyimage_num,
			d.teff_date,
			d.texp_date,
			0 [Vehicle_Count],
			--d.class_code,
			0 [Full_Coverage_Vehicle_Count],
			0 [NonOwner_Vehicle_Count],
			COUNT(d.driver_num) [Driver_Count],
			SUM(d.rated) [Rated_Driver_Count],
			SUM(CASE
				WHEN d.excluded_driver_surcharge = 1 and d.Relationship = 'Spouse' THEN 1
				ELSE 0
				END) [Excluded_Spouse_Driver_Count],
			SUM(d.excluded_driver_surcharge) [Excluded_Driver_Count],
			--Fix for Class Code Error on '*'
			SUM(CASE
				WHEN RIGHT(d.class_code,1) = '*' THEN 0
				WHEN d.rated = 1 and CAST(RIGHT(d.class_code,2) as int) <= 25 THEN 1
				ELSE 0
				END) [YD_Driver_Count],
			
			SUM(CASE
				WHEN d.rated = 1 and d.FDL = 1 THEN 1
				ELSE 0
				END) [FDL_Driver_Count],
				
			SUM(CASE
				WHEN d.relationshiptype_id = 8 and d.maritalstatus_id = 2 THEN 1
				ELSE 0
				END) [Married_Insured_Count],
			SUM(CASE
				WHEN d.maritalstatus_id = 2 THEN 1
				ELSE 0
				END) [Married_Driver_Count]
			

		FROM
			#driverInfo d
		--where policy_id = 47994777
		GROUP BY
			d.policy_id,
			d.policyimage_num,
			d.teff_date,
			d.texp_date
			
		)a
	GROUP BY
		a.policy_id,
		a.policyimage_num,
		a.teff_date,
		a.texp_date
	) b
	left join #policyholder_info pol ON pol.policy_id = b.policy_id AND pol.policyimage_num = b.policyimage_num and b.teff_date = pol.teff_date and b.texp_date = pol.texp_date
	GROUP BY 
		b.policy_id,
		b.policyimage_num,
		b.teff_date,
		b.texp_date,
		pol.class_code,
		pol.Primary_Insured_Age
	ORDER BY
		b.policy_id,
		b.policyimage_num,
		b.teff_date,
		b.texp_date

--select * from #vehicledriver

--Fullterm Premium table
SELECT
	pl.policy_id,
	pl.policyimage_num,
	pl.teff_date,
	pl.texp_date,
	SUM(vp2.premium_chg_written) fullterm_premium
INTO #ftp
FROM
	#List pl
	LEFT JOIN diamond.dbo.vpolicyimagexml vp on pl.policy_id = vp.policy_id and pl.policyimage_num = vp.policyimage_num
	LEFT JOIN diamond.dbo.vpolicyimagexml vp2 on vp.policy_id = vp2.policy_id and vp.renewal_ver = vp2.renewal_ver
	LEFT JOIN Product_DSQL2.dbo.Test_Agency_Index tax on vp.agency_id = tax.Agency_ID
WHERE
	vp2.policy not like 'Q%'
	and tax.Agency_ID is null
	--and vp2.teff_date <  @ED
	--and vp2.accounting_date <  @ED
	and vp2.policystatuscode_id not in (4, 5, 8, 9, 10, 11, 12, 13, 14) --Pending P, Renewal Offer O, Pending OOS Q, Reapplied R, Void Due to OOS Cancel X, Offset Due to OOS Cancel Z, Quote QT, Archived Quote AQ, Renewal Underwriting U
GROUP BY
	pl.policy_id,
	pl.policyimage_num,
	pl.teff_date,
	pl.texp_date
ORDER BY 
	pl.policy_id,
	pl.policyimage_num,
	pl.teff_date,
	pl.texp_date

--Final policyInfo
SELECT
	'New App' as [RunType],
	vp.teff_date,
	year(vp.teff_date) [Year],
	month(vp.teff_date) [Month],
	datepart(week,vp.teff_date) [Week],
	day(vp.teff_date) [Day],
	year(vp.teff_date)*100 + month(vp.teff_date) [YM],
	year(vp.teff_date)*100 + datepart(week,vp.teff_date) [YW],
	year(vp.teff_date)*10000 + month(vp.teff_date)*100 + datepart(week,vp.teff_date) [YMW],
	year(vp.teff_date)*10000 + month(vp.teff_date)*100 + day(vp.teff_date) [YMD],
	csl.[State],
	ht.[Sales Territory] [Product_Territory],
	ht.COUNTY [Product_County],
	ht.CITY [Product_City],
	LEFT(ad.zip,5) [Zip],
	a.commercial_name1 [Agency_Name],
	a.code [Agency_Code],
	pt.months [Term],
	vd.class_code,
	vd.Married,
	vd.Vehicle_Driver,
	sum(vd.[Vehicle_Count_Sum]) [Vehicle_Count],
	sum(vd.Driver_Sum) [Driver_Count],
	vd.Primary_Insured_Age,
	ist.dscr [Credit_Score],
	vd.License_Type,
	vd.Vehicle_Profile,
	vd.NonOwner,
	vd.Multi_Car,
	CASE WHEN c.Homeownership = 1 THEN 'Y' ELSE 'N' END as [Homeowner],
	CASE 
		WHEN vd.Primary_Insured_Age = '<25' THEN 'Young Driver' 
		ELSE 'Not YD' END as [Young Driver],
	CASE 
		WHEN c.[Prior Hallmark Insurance] = 1 THEN 'Prior Hallmark' 
		WHEN c.[In-Agency Transfer] = 1 THEN 'In Agency Transfer'
		WHEN c.[Prior Insurance] = 1 THEN 'Prior Insurance'
		ELSE 'No POP' END as [POP],
	CASE
		WHEN pt.months not in (6,12) THEN 'N'
		WHEN ISNULL([Advanced Quote Override],0) = 2 THEN 'N'
		WHEN ISNULL([Advanced Quote Override],0) = 0 and ISNULL([Advanced Quote],0) = 0 THEN 'N'
		WHEN (ISNULL([Advanced Quote Override],0) = 1 or ISNULL([Advanced Quote],0) = 1) THEN 'Y'
		ELSE 'Check Me [e.2]'
		END as 'Advanced Quote',
	CASE 
		WHEN c.[Paid in full] = 1 THEN 'Paid-in-Full' 
		WHEN c.[Recurring Payment] = 1 THEN 'Recurring Payment'
		ELSE 'No Info' END as [Payment_Type],
	vp.current_payplan_dscr [Pay Plan],
	count(vp.policy) [Policy_Count],
	SUM(fullterm_premium) [Fullterm_Premium]
INTO #final
FROM
	(SELECT
		a.policy_id,
		a.policyimage_num,
		a.teff_date,
		a.texp_date,
		a.modifiertype_dscr,
		a.checkboxselected,
		tl.tierlevel_id [Tier],
		tl.dscr [Tier_Dscr]
		--,Level
	FROM
		(SELECT DISTINCT --policy level only
			pl.policy_id,
			pl.policyimage_num,
			pl.teff_date,
			pl.texp_date,
			m.unit_num,
			CASE m.modifiertype_id
				WHEN 2 THEN mo.dscr		--Prior Insurance
				WHEN 28 THEN mo.dscr	--Policy Type
				ELSE mt.dscr
				END modifiertype_dscr,
			CASE
				WHEN m.modifiertype_id = 2 and mo.dscr IS NOT NULL THEN 1	--Prior Insurance has a dscr
				WHEN m.modifiertype_id = 18 and m.checkboxselected = 1 THEN m.modifier_amount	--Rate Capping
				WHEN m.modifiertype_id = 19 and m.checkboxselected = 1 THEN m.checkboxselected	--Rate Capping Override
				WHEN m.modifiertype_id = 19 and m.checkboxselected = 0 THEN NULL	--Rate Capping Override
				WHEN m.modifiertype_id = 21 and m.modifieroption_id = 87 THEN 1	--Multi-Policy Override 'Add Discount'
				WHEN m.modifiertype_id = 21 and m.modifieroption_id = 88 THEN 2	--Multi-Policy Override 'Remove Discount'
				WHEN m.modifiertype_id = 28 and mo.dscr IS NOT NULL THEN 1	--Policy Type has dscr
				WHEN m.modifiertype_id = 13 and m.modifieroption_id not in (-1,0) THEN 1 --Unacceptable Policies with drop down selections
				WHEN m.modifiertype_id = 32 and m.modifieroption_id = 87 THEN 1 --Advance Quote Override 'Add Discount'
				WHEN m.modifiertype_id = 32 and m.modifieroption_id = 88 THEN 2 --Advance Quote Override 'Remove Discount'
				ELSE m.checkboxselected
				END checkboxselected
			,'policy-level' as [Level]
		FROM
			#List pl
			LEFT JOIN diamond.dbo.Modifier m ON m.policy_id = pl.policy_id and m.policyimage_num = pl.policyimage_num and m.detailstatuscode_id = 1
			LEFT JOIN diamond.dbo.ModifierType mt ON m.modifiertype_id = mt.modifiertype_id
			LEFT JOIN diamond.dbo.ModifierOption mo ON m.modifieroption_id = mo.modifieroption_id
		WHERE
			m.modifiertype_id not in (8,11,12)
			--and pl.policy_id = '46821117'
		UNION ALL

		SELECT DISTINCT --vehicle level only
			pl.policy_id,
			pl.policyimage_num,
			pl.teff_date,
			pl.texp_date,
			mv.unit_num,
			CASE mv.modifiertype_id
				WHEN 2 THEN mov.dscr		--Prior Insurance
				WHEN 28 THEN mov.dscr	--Policy Type
				ELSE mtv.dscr
				END modifiertype_dscr,
			CASE
				WHEN mv.modifiertype_id = 11 and mv.modifieroption_id = 50 THEN 1 --Unacceptable Vehicle Auto with drop down 'All Coverage'
				WHEN mv.modifiertype_id = 11 and mv.modifieroption_id = 51 THEN 2 --Unacceptable Vehicle Auto with drop down 'Physical Damage'
				WHEN mv.modifiertype_id = 12 and mv.modifieroption_id = 50 THEN 1 --Unacceptable Vehicle Manual with drop down 'All Coverage'
				WHEN mv.modifiertype_id = 12 and mv.modifieroption_id = 51 THEN 2 --Unacceptable Vehicle Manual with drop down 'Physical Damage'
				WHEN mv.modifiertype_id = 12 and mv.modifieroption_id = 52 THEN 3 --Unacceptable Vehicle Manual with drop down 'No Surcharge'
				ELSE mv.checkboxselected
				END checkboxselected
				,'vehicle-level' as [Level]
		FROM
			#List pl
			LEFT JOIN #vehicleInfo v on pl.policy_id = v.policy_id and pl.policyimage_num = v.policyimage_num
			LEFT JOIN diamond.dbo.Modifier mv ON mv.policy_id = v.policy_id and mv.policyimage_num = v.policyimage_num and mv.detailstatuscode_id = 1 and v.vehicle_num = mv.unit_num
			LEFT JOIN diamond.dbo.ModifierType mtv ON mv.modifiertype_id = mtv.modifiertype_id
			LEFT JOIN diamond.dbo.ModifierOption mov ON mv.modifieroption_id = mov.modifieroption_id
		WHERE
			mv.modifiertype_id in (11,12)

		UNION ALL

		SELECT DISTINCT --driver level only
			pl.policy_id,
			pl.policyimage_num,
			pl.teff_date,
			pl.texp_date,
			md.unit_num,
			CASE md.modifiertype_id
				WHEN 2 THEN mod.dscr		--Prior Insurance
				WHEN 28 THEN mod.dscr	--Policy Type
				ELSE mtd.dscr
				END modifiertype_dscr,
			CASE
				WHEN md.modifiertype_id = 8 and md.modifieroption_id not in (-1,0) THEN 1 --Unacceptable Driver Auto with drop down selections
				ELSE md.checkboxselected
				END checkboxselected
			,'driver-level' as [Level]
		FROM
			#List pl
			LEFT JOIN #driverInfo d on pl.policy_id = d.policy_id and pl.policyimage_num = d.policyimage_num
			LEFT JOIN diamond.dbo.Modifier md ON md.policy_id = d.policy_id and md.policyimage_num = d.policyimage_num and md.detailstatuscode_id = 1 and d.driver_num = md.unit_num
			LEFT JOIN diamond.dbo.ModifierType mtd ON md.modifiertype_id = mtd.modifiertype_id
			LEFT JOIN diamond.dbo.ModifierOption mod ON md.modifieroption_id = mod.modifieroption_id
		WHERE
			md.modifiertype_id in (8)
		)a
		LEFT JOIN diamond.dbo.TieringInfo ti on a.policy_id = ti.policy_id and a.policyimage_num = ti.policyimage_num and ti.detailstatuscode_id = 1
		LEFT JOIN diamond.dbo.TierLevel tl on ti.tierlevel_id = tl.tierlevel_id
	)b
PIVOT
	(
	MAX([checkboxselected])
	for b.[modifiertype_dscr]
	in (
		[Limited],
		[Prior Insurance],	
		[Homeownership],
		[Recurring Payment],
		[Paid in full],
		[In-Agency Transfer],
		[Prior Hallmark Insurance],
		[Multi-Policy],
		[Multi-Policy Override],
		[Advanced Quote],
		[Advanced Quote Override],
		[Unacceptable Policy],
		[Unacceptable Vehicle Auto],
		[Unacceptable Vehicle Manual],
		[Unacceptable Driver Auto],
		[Unacceptable Driver Manual],
		[Rate Capping],
		[Rate Capping Override]
		)
	) c
	LEFT JOIN diamond.dbo.vpolicyimagexml vp on c.policy_id = vp.policy_id and c.policyimage_num = vp.policyimage_num
	LEFT JOIN diamond.dbo.policyterm pt on vp.policyterm_id = pt.policyterm_id
	LEFT JOIN #vehicleDriver vd on c.policy_id = vd.policy_id and c.policyimage_num = vd.policyimage_num
	LEFT JOIN Product_DSQL2.dbo.rate_InsuranceScoreTiering_TX ist on c.Tier = ist.Tier and ist.RVID = 91
	LEFT JOIN diamond.dbo.vAgency a on vp.agency_id = a.agency_id 
	LEFT JOIN diamond.dbo.version v on vp.version_id = v.version_id
	LEFT JOIN diamond.dbo.vCompanyStateLOB csl on v.companystatelob_id = csl.companystatelob_id
	LEFT JOIN diamond.dbo.PolicyImageAddressLink pial on c.policy_id = pial.policy_id and c.policyimage_num = pial.policyimage_num and pial.nameaddresssource_id = 3
	LEFT JOIN diamond.dbo.address ad on pial.address_id = ad.address_id and ad.detailstatuscode_id = 1
	LEFT JOIN Product_DSQL2.dbo.HallmarkTerritories ht on left(ad.zip,5) = ht.ZIP
	LEFT JOIN #ftp f on f.policy_id = c.policy_id and f.policyimage_num = c.policyimage_num

	
WHERE
	ad.address_id is not null
GROUP BY
	vp.teff_date,
	csl.[State],
	ht.[Sales Territory],
	ht.COUNTY,
	ht.CITY,
	c.Homeownership,
	LEFT(ad.zip,5),
	a.commercial_name1,
	a.code,
	pt.months,
	ist.dscr,
	vd.class_code,
	vd.Married,
	vd.Vehicle_Driver,
	vd.Primary_Insured_Age,
	ist.dscr,
	vd.License_Type,
	vd.Vehicle_Profile,
	vd.NonOwner,
	--vd.Macro_Vehicle_Driver,
	vd.Multi_Car,
	case when vd.Primary_Insured_Age = '<25' THEN 'Young Driver' ELSE 'Not YD' END,
	CASE 
		WHEN c.[Prior Hallmark Insurance] = 1 THEN 'Prior Hallmark' 
		WHEN c.[In-Agency Transfer] = 1 THEN 'In Agency Transfer'
		WHEN c.[Prior Insurance] = 1 THEN 'Prior Insurance'
		ELSE 'No POP' END,
	CASE
		WHEN pt.months not in (6,12) THEN 'N'
		WHEN ISNULL([Advanced Quote Override],0) = 2 THEN 'N'
		WHEN ISNULL([Advanced Quote Override],0) = 0 and ISNULL([Advanced Quote],0) = 0 THEN 'N'
		WHEN (ISNULL([Advanced Quote Override],0) = 1 or ISNULL([Advanced Quote],0) = 1) THEN 'Y'
		ELSE 'Check Me [e.2]'
		END,
	CASE 
		WHEN c.[Paid in full] = 1 THEN 'Paid-in-Full' 
		WHEN c.[Recurring Payment] = 1 THEN 'Recurring Payment'
		ELSE 'No Info' END,
	vp.current_payplan_dscr

--Final_Prep Table
SELECT 
	fin.*,
	[KMA ALL],
	[KMA BI],
	[KMA CL],
	[KMA CP],
	[KMA PD],
	[KMA MP],
	[KMA PP]
INTO #final_prep
FROM #final fin	
left join Product_DSQl2.dbo.KMA_ALL kma on fin.Zip = kma.Zip

--Insert into benchmark_mix
INSERT INTO Product_DSQl2.dbo.benchmark_mix
	SELECT * FROM #final_prep 
