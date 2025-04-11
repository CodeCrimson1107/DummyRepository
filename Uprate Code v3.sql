/************************************
** Uprate Report - v3
** Determines Uprate/Downrate/No Change based on change in written premium
************************************/
--Start date of transaction period
DECLARE @SD date = '2025-01-01'

--End date of transaction period; using last day of prior month
DECLARE @ED date = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))

--print(@SD)
--print(@ED)

if object_ID('#T1') is not null TRUNCATE TABLE #T1
--if object_ID('#T1v3') is not null TRUNCATE TABLE #T1v3
if object_ID('tempDB.dbo.#DriverStats') is not null drop table #DriverStats
if object_ID('tempDB.dbo.#PolicyDriverInfo') is not null drop table #PolicyDriverInfo
if object_ID('tempDB.dbo.#vehicleinfo') is not null drop table #vehicleinfo
if object_ID('tempDB.dbo.#policyvehinfo') is not null drop table #policyvehinfo
if object_ID('tempDB.dbo.#policydiscounts') is not null drop table #policydiscounts
if object_ID('tempDB.dbo.#bothimages') is not null drop table #bothimages 
if object_ID('tempDB.dbo.#allpriorimages') is not null drop table #allpriorimages
if object_ID('tempDB.dbo.#group4ormore') is not null drop table #group4ormore
if object_ID('tempDB.dbo.#finalchanges') is not null drop table #finalchanges
if object_ID('tempDB.dbo.#truefinal') is not null drop table #truefinal
if object_ID('tempDB.dbo.#allpriorimagesPI') is not null DROP TABLE #allpriorimagesPI
if object_ID('tempDB.dbo.#allpriorimagesRest') is not null DROP TABLE #allpriorimagesRest
if object_ID('tempDB.dbo.#allprior') is not null DROP TABLE #allprior
if object_ID('tempDB.dbo.#allLatest') is not null DROP TABLE #allLatest
if object_ID('tempDB.dbo.#bothimages') is not null DROP TABLE #bothimages
if object_ID('tempDB.dbo.#LatestImagePI') is not null DROP TABLE #LatestImagePI
if object_ID('tempDB.dbo.#LatestImageRest') is not null DROP TABLE #LatestImageRest
if object_ID('tempDB.dbo.#finalchanges') is not null DROP TABLE #finalchanges
if object_ID('tempDB.dbo.#truefinal') is not null DROP TABLE #truefinal


--INSERT into #T1
select vp.policy_id, vp.policyimage_num,vp.policy,			--Policy identifiers
	vp.agency_code,vp.agency_name,							--Agency info
	vp.premium_fullterm,vp.premium_chg_written,				--Premium info
	vp.transtype_dscr,vp.transreason_dscr, vp.trans_date,	--Transaction Type/date/etc.
	CASE WHEN vp.premium_chg_written > 0 THEN 'Uprate'
		WHEN vp.premium_chg_written < 0 THEN 'Downrate'
		WHEN vp.premium_chg_written = 0 THEN 'No Change'
		ELSE 'N/A' END [Rate Change],
	vp.policystatuscode_dscr,p.cancelled,p.cancelimage_num,
		CASE --WHEN P.cancelled = 1 and vp.policyimage_num +1 = p.cancelimage_num THEN 'Cancelled on Next Image'
			WHEN p.cancelled = 1 and DATEDIFF(dd,vp.trans_date,p.cancelledon_date) <= 30 THEN 'Cancelled within 30 Days'
			WHEN p.cancelled = 1 and DATEDIFF(dd,vp.trans_date,p.cancelledon_date) <= 60 THEN 'Cancelled within 60 Days'
			WHEN p.cancelled = 1 and DATEDIFF(dd,vp.trans_date,p.cancelledon_date) <= 90 THEN 'Cancelled within 90 Days'
			WHEN p.cancelled = 1 and DATEDIFF(dd,vp.trans_date,p.cancelledon_date) > 90 THEN 'Cancelled after over 90 Days'
			WHEN p.cancelled = 0 THEN 'Not Cancelled'
			ELSE 'Other' END [Cancelled Post-Transaction]
--into #T1
into #T1
from Diamond..vpolicyimagexml vp
left join diamond..policy p on p.policy_id = vp.policy_id-- and p.cancelimage_num = vp.policyimage_num
LEFT JOIN diamond.dbo.Version v on v.version_id=vp.version_id
LEFT JOIN diamond.dbo.vCompanyStateLOB csl on csl.companystatelob_id=v.companystatelob_id
--left join Product_DSQl2..RINReport_Datesv2 r on r.policy_id = vp.policy_id --and DATEADD(dd,30,r.respond_by_date) <= vp.trans_date and r.respond_by_date >= vp.trans_date
where-- r.policy_id in (16407444,16076101,16082764,16389909,16090372,16091583,665,15698943,16095152,120757,151263,10496907,16103787,16440664,16470598) and--(24338996,4117567,23909716)-- like 'TXA%' and eff_date like '2020%'
	((vp.transreason_id in (10040,10044) and vp.transtype_id = 3) or (vp.transreason_id in (10063) and vp.transtype_id = 8))
	and vp.policystatuscode_id in (1,3)
	and (vp.trans_date >= @SD and vp.trans_date <= @ED)
	AND csl.lob_id not in (30,31) --remove aviation



/*
*  Driver Stats
*/
SELECT
		vp.policy,
		pl.policy_id,
		pl.policyimage_num,
		--pl.rate_group,
		vd.driver_num,
		CASE vd.driverexcludetype_id WHEN 1 THEN 1 ELSE 0 END rated,
		CASE vd.driverexcludetype_id WHEN 3 THEN 1 ELSE 0 END excluded,
		CASE
			WHEN vd.sex_id = 1 THEN 'Male'
			ELSE 'Female'
			END Gender,
		CASE
				WHEN vd.maritalstatus_id = 2 THEN 'Married'
				ELSE 'Single'
				END MaritalStatus,
		CASE
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
				END) End Age,
		vd.points,
		
		CASE 
			WHEN vd.licensestatus_id in (6,11) THEN 1
			ELSE 0
			END FDL
		
	INTO #DriverStats
	FROM
		Product_DSQl2.dbo.#T1 pl
		LEFT JOIN diamond.dbo.vpolicyimagexml vp on pl.policy_id = vp.policy_id and pl.policyimage_num = vp.policyimage_num
		LEFT JOIN diamond.dbo.vDriver vd on pl.policy_id = vd.policy_id and pl.policyimage_num = vd.policyimage_num
		LEFT JOIN diamond.dbo.driverexcludetype det on det.driverexcludetype_id = vd.driverexcludetype_id
		LEFT JOIN diamond.dbo.driverexcludereason der on der.driverexcludereason_id = vd.driverexcludereason_id
		LEFT JOIN diamond.dbo.RelationshipType rt on vd.relationshiptype_id = rt.relationshiptype_id
		LEFT JOIN diamond.dbo.LicenseStatus ls on ls.licensestatus_id = vd.licensestatus_id
		LEFT JOIN diamond.dbo.Violation v on pl.policy_id = v.policy_id and pl.policyimage_num = v.policyimage_num and vd.driver_num = v.unit_num
		LEFT JOIN diamond.dbo.LossHistory lh on pl.policy_id = lh.policy_id and pl.policyimage_num = lh.policyimage_num and vd.driver_num = lh.unit_num
		LEFT JOIN diamond.dbo.FilingInfo fi on pl.policy_id = fi.policy_id and pl.policyimage_num = fi.policyimage_num and vd.driver_num = fi.driver_num and fi.detailstatuscode_id = 1
	WHERE
		vd.detailstatuscode_id = 1
	GROUP BY
		vp.policy,
		pl.policy_id,
		pl.policyimage_num,
		--pl.rate_group,
		vd.driver_num,
		CASE vd.driverexcludetype_id WHEN 1 THEN 1 ELSE 0 END ,
		CASE vd.driverexcludetype_id WHEN 3 THEN 1 ELSE 0 END ,
		
		CASE
			WHEN vd.sex_id = 1 THEN 'Male'
			ELSE 'Female'
			END ,
		CASE
				WHEN vd.maritalstatus_id = 2 THEN 'Married'
				ELSE 'Single'
				END,

		CASE
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
				END) End,
		vd.points,
		
		CASE 
			WHEN vd.licensestatus_id in (6,11) THEN 1
			ELSE 0
			END 


select 
	policy,ds.policy_id,ds.policyimage_num,ds1.rated num_drivers, ds2.excluded num_excluded_drivers,ds4.male Male_Drivers, ds4.female Female_Drivers, CASE WHEN ds2.excluded >= 1 THEN 'Excluded Driver(s)' ELSE 'No Excluded Drivers' END Excluded, CASE WHEN ds3.FDL >= 1 THEN 'FDL' ELSE 'No FDL' END FDL
into #PolicyDriverInfo
from #DriverStats ds
left join (SELECT policy_id, policyimage_num, SUM(rated) rated from #DriverStats group by policy_id, policyimage_num) ds1 on ds.policy_id = ds1.policy_id and ds.policyimage_num = ds1.policyimage_num
left join (SELECT policy_id, policyimage_num, SUM(excluded) excluded from #DriverStats group by policy_id, policyimage_num) ds2 on ds.policy_id = ds2.policy_id and ds.policyimage_num = ds2.policyimage_num
left join (SELECT policy_id, policyimage_num, SUM(FDL) FDL from #DriverStats group by policy_id, policyimage_num) ds3 on ds.policy_id = ds3.policy_id and ds.policyimage_num = ds3.policyimage_num
left join (SELECT policy_id, policyimage_num, SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) Male, SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) Female from #DriverStats group by policy_id, policyimage_num) ds4 on ds.policy_id = ds4.policy_id and ds.policyimage_num = ds4.policyimage_num
group by policy, ds.policy_id, ds.policyimage_num,ds1.rated,ds2.excluded,ds3.FDL,ds4.Male,ds4.Female,ds2.excluded


		


/*
* Vehicle Data
*/
SELECT
	pl.policy_id,
	pl.policyimage_num,
	
	vv.added_policyimage_num,
	vv.vehicle_num,
	vv.eff_date,
	vv.VIN, 
	CASE WHEN c.coveragecode_id = 3 and CAST(cl.deductible as int) > 0 THEN 1
		ELSE 0 END [Vehicle_Profile]
INTO #vehicleInfo
FROM
	#T1 pl
	LEFT JOIN diamond.dbo.vVehicle vv on pl.policy_id = vv.policy_id and pl.policyimage_num = vv.policyimage_num
	LEFT JOIN diamond.dbo.coverage c on pl.policy_id = c.policy_id and pl.policyimage_num = c.policyimage_num and vv.vehicle_num = c.unit_num and c.coveragecode_id = 3 and c.detailstatuscode_id = 1
	LEFT JOIN diamond.dbo.coveragelimit cl on c.coveragelimit_id = cl.coveragelimit_id	
WHERE
	vv.detailstatuscode_id = 1

SELECT vi.policy_id,policyimage_num, nv.num_vehicles, CASE WHEN vp.vehicle_profile > 0 then 'Full Coverage' ELSE 'Liability Only' END Vehicle_Profile
INTO #policyVehInfo
FROM #vehicleInfo vi
left join (SELECT policy_id, COUNT(vehicle_num) num_vehicles from #vehicleInfo group by policy_id) nv on nv.policy_id = vi.policy_id
left join (SELECT policy_id, SUM(Vehicle_Profile) vehicle_profile from #vehicleInfo group by policy_id) vp on vp.policy_id = vi.policy_id
group by vi.policy_id,policyimage_num,nv.num_vehicles,vp.vehicle_profile


/*
* Policy Discoumts 
*/

SELECT policy_id,policy,policyimage_num,[ID],ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY policyimage_Num) [Rows],
	Case When [Prior Insurance] is null then 0 else [Prior Insurance] END [Prior Insurance]
into #allpriorimagesPI
FROM (
    SELECT 
        mt.dscr, 
		ur.policy_id,
		ur.policy,
		m.policyimage_num,
		CONCAT(ur.policy_id,ur.policyimage_num) [ID],
		CASE WHEN m.modifieroption_id <> 0 THEN CAST(1 as int) ELSE CAST(0 as int) END modifieroption_id		
    FROM #T1 ur
		INNER join diamond..modifier m on ur.policy_id = m.policy_id and (ur.policyimage_num  >= m.policyimage_num)-- and ur.policyimage_num - 1 <= m.policyimage_num)
        LEFT JOIN diamond..ModifierType mt
            ON m.modifiertype_id = mt.modifiertype_id	
) t 
PIVOT(
    SUM(modifieroption_id)
    FOR dscr IN ([Prior Insurance])
		
) AS pivot_table
--where policy_id = 12531960 --and policyimage_num = 13
ORDER BY [ID], policyimage_num;


SELECT policy_id,policy,policyimage_num,[ID],ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY policyimage_Num) [Rows],
	Case When [Recurring Payment] is null then 0 else [Recurring Payment] END [Recurring Payment],
	Case When [Paid in Full] is null then 0 else [Paid in Full] END [Paid in Full],
	Case When [Homeownership] is null then 0 else [Homeownership] END [Homeownership],
	Case When [Multi Car] is null then 0 else [Multi Car] END [Multi Car],
	Case When [Advanced Quote] is null then 0 else [Advanced Quote] END [Advanced Quote],
	Case When [Multi-Policy] is null then 0 else [Multi-Policy] END [Multi-Policy] 
into #allpriorimagesRest
FROM (
    SELECT 
        mt.dscr, 
		ur.policy_id,
		ur.policy,
		m.policyimage_num,
		CONCAT(ur.policy_id,ur.policyimage_num) [ID],
		
		CASE WHEN m.checkboxselected = 1 THEN CAST(1 as int) ELSE CAST(0 as int) END checkboxselected
    FROM #T1 ur
		INNER join diamond..modifier m on ur.policy_id = m.policy_id and (ur.policyimage_num  >= m.policyimage_num)-- and ur.policyimage_num - 1 <= m.policyimage_num)
        LEFT JOIN diamond..ModifierType mt
            ON m.modifiertype_id = mt.modifiertype_id
) t 
PIVOT(
    SUM(checkboxselected)
    FOR dscr IN (
        [Recurring Payment],
		[Paid in Full],
		[Homeownership],
		[Multi Car],
		[Advanced Quote],
		[Multi-Policy])
) AS pivot_table
--where policy_id = 12531960 --and policyimage_num = 13
ORDER BY [ID], policyimage_num;


/**

--Latest Image on Policy ONLY

**/
SELECT policy_id,policy,policyimage_num,[ID],ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY policyimage_Num) [Rows],
	Case When [Prior Insurance] is null then 0 else [Prior Insurance] END [Prior Insurance]
into #LatestImagePI
FROM (
    SELECT 
        mt.dscr, 
		ur.policy_id,
		ur.policy,
		vp.policyimage_num,
		CONCAT(ur.policy_id,ur.policyimage_num) [ID],
		CASE WHEN m.modifieroption_id <> 0 THEN CAST(1 as int) ELSE CAST(0 as int) END modifieroption_id		
    FROM #T1 ur
		LEFT JOIN (SELECT policy_id, MAX(policyimage_num) policyimage_num from Diamond..vpolicyimagexml GROUP BY policy_id) vp on vp.policy_id = ur.policy_id
		INNER join diamond..modifier m on ur.policy_id = m.policy_id and (vp.policyimage_num  = m.policyimage_num)-- and ur.policyimage_num - 1 <= m.policyimage_num)
        LEFT JOIN diamond..ModifierType mt
            ON m.modifiertype_id = mt.modifiertype_id	
) t 
PIVOT(
    SUM(modifieroption_id)
    FOR dscr IN ([Prior Insurance])
		
) AS pivot_table
--where policy_id = 13077746 --and policyimage_num = 13
ORDER BY [ID], policyimage_num;

SELECT DISTINCT
	policy_id,policy,policyimage_num,[ID],ROW_NUMBER() OVER (PARTITION BY [ID] ORDER BY policyimage_Num) [Rows],
	Case When [Recurring Payment] is null then 0 else [Recurring Payment] END [Recurring Payment],
	Case When [Paid in Full] is null then 0 else [Paid in Full] END [Paid in Full],
	Case When [Homeownership] is null then 0 else [Homeownership] END [Homeownership],
	Case When [Multi Car] is null then 0 else [Multi Car] END [Multi Car],
	Case When [Advanced Quote] is null then 0 else [Advanced Quote] END [Advanced Quote],
	Case When [Multi-Policy] is null then 0 else [Multi-Policy] END [Multi-Policy] 
into #latestImageRest
FROM (
    SELECT 
        mt.dscr, 
		ur.policy_id,
		ur.policy,
		vp.policyimage_num,
		CONCAT(ur.policy_id,ur.policyimage_num) [ID],
		
		CASE WHEN m.checkboxselected = 1 THEN CAST(1 as int) ELSE CAST(0 as int) END checkboxselected
    FROM #T1 ur
		LEFT JOIN (SELECT policy_id, MAX(policyimage_num) policyimage_num from Diamond..vpolicyimagexml GROUP BY policy_id) vp on vp.policy_id = ur.policy_id
		INNER join diamond..modifier m on ur.policy_id = m.policy_id and (vp.policyimage_num  = m.policyimage_num)-- and ur.policyimage_num - 1 <= m.policyimage_num)
        LEFT JOIN diamond..ModifierType mt
            ON m.modifiertype_id = mt.modifiertype_id
) t 
PIVOT(
    SUM(checkboxselected)
    FOR dscr IN (
        [Recurring Payment],
		[Paid in Full],
		[Homeownership],
		[Multi Car],
		[Advanced Quote],
		[Multi-Policy])
) AS pivot_table
--where policy_id = 12531960 --and policyimage_num = 13
ORDER BY policyimage_num;





SELECT ar.*, api.[Prior Insurance] 
INTO #allprior
FROM #allpriorimagesPI api 
left join #allpriorimagesRest ar on ar.[ID] = api.[ID] and ar.Rows = api.Rows
order by api.[ID] --need to adjust where it assigns rows so that w/in one policy/image pair the rows are in order or the top two selection will not work as expected

SELECT lr.*,lpi.[Prior Insurance]
INTO #allLatest
FROM #LatestImagePI lpi
LEFT JOIN #latestImageRest lr on lr.[ID] = lpi.[ID]
order by lpi.[ID];

--select * from #allprior where policy_id = 13077746 order by policyimage_num desc;
--select * from #allLatest where policy_id = 13077746;
 



WITH TOPTWO AS (
    SELECT *, ROW_NUMBER() 
    over (
        PARTITION BY [ID]
        order by policyimage_num desc
    ) AS RowNo 
    FROM #allprior
)
SELECT * into #bothimages FROM TOPTWO WHERE RowNo <= 2;
--select * from #bothimages where policy_id = 13077746 
--select * from #alllatest where policy_id = 13077746


select bi.policy_id,bi.policy, 
	CASE WHEN SUM(bi.[Recurring Payment]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Recurring Payment]) = 2 THEN 'No Change'
		ELSE 'Removed Recurring Payment' END [Recurring Payment],
	CASE WHEN SUM(bi.[Prior Insurance]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Prior Insurance]) = 2 THEN 'No Change'
		ELSE 'Removed Prior Insurance' END [Prior Insurance],
	CASE WHEN SUM(bi.[Paid in Full]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Paid in Full]) = 2 THEN 'No Change'
		ELSE 'Removed Paid in Full' END [Paid in Full],
	CASE WHEN SUM(bi.[Homeownership]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Homeownership]) = 2 THEN 'No Change'
		ELSE 'Removed Homeownership' END [Homeownership],
	CASE WHEN SUM(bi.[Multi Car]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Multi Car]) = 2 THEN 'No Change'
		ELSE 'Removed Multi Car' END [Multi Car],
	CASE WHEN SUM(bi.[Advanced Quote]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Advanced Quote]) = 2 THEN 'No Change'
		ELSE 'Removed Advanced Quote' END [Advanced Quote],
	CASE WHEN SUM(bi.[Multi-Policy]) = 0 THEN 'No Change'
		WHEN  SUM(bi.[Multi-Policy]) = 2 THEN 'No Change'
		ELSE 'Removed Multi-Policy' END [Multi-Policy]
into #finalchanges
from #bothimages bi
--where bi.policy_id = 13077746
group by bi.policy_id, bi.policy


/**
	Merging the latest image status to the update and its prior image
**/
select b.policyimage_num,f.policy_id,f.policy,f.[Recurring Payment],f.[Prior Insurance],f.[Paid in Full],f.Homeownership,f.[Multi Car],f.[Advanced Quote],f.[Multi-Policy],
	CASE WHEN li.[Recurring Payment] = 1 THEN 'Recurring Payment'
	ELSE 'No Recurring Payment' END [Latest Image Recurring Payment], 
	CASE WHEN li.[Prior Insurance] = 1 THEN 'Prior Insurance'
	ELSE 'No Prior Insurance' END [Latest Image Prior Insurance], 
	CASE WHEN li.[Paid in Full] = 1 THEN 'Paid in Full'
	ELSE 'No Paid in Full' END [Latest Image Paid in Full], 
	CASE WHEN li.Homeownership = 1 THEN 'Homeownership'
	ELSE 'No Homeownership' END [Latest Image Homeownership], 
	CASE WHEN li.[Multi Car] = 1 THEN 'Multi Car'
	ELSE 'No Multi Car' END [Latest Image Multi Car], 
	CASE WHEN li.[Advanced Quote] = 1 THEN 'Advanced Quote'
	ELSE 'No Advanced Quote' END [Latest Image Advanced Quote], 
	CASE WHEN li.[Multi-Policy] = 1 THEN 'Multi-Policy'
	ELSE 'No Multi-Policy' END [Latest Image Multi-Policy]
into #truefinal
from #finalchanges f
inner join (SELECT MAX(policyimage_num) policyimage_num, policy from #bothimages group by policy) b on b.policy = f.policy 
left join #alllatest li on li.policy_id = f.policy_id
--where f.policy_id = 13077746

--select * from #bothimages where policy_id = 13077746 
--select * from #alllatest where policy_id = 13077746
/*
* Final
*/
--insert into Product_DSQl2..UprateReportv3
select DISTINCT ur.*, DATEPART(year,ur.trans_date) Years,
	--vp.eff_date, --7/27
	CASE WHEN [Rate Change] = 'Uprate' THEN (ur.premium_chg_written/ur.premium_fullterm*1.00)
		WHEN [Rate Change] = 'Downrate' THEN (ur.premium_chg_written/ur.premium_fullterm*1.00)
		ELSE (ur.premium_chg_written/ur.premium_fullterm*100.00) END [Percent Change],--7/31
	CASE WHEN vp.renewal_ver > 1 THEN 'Renewal'
		ELSE 'New' END New_Renewal, --7/27
	CASE WHEN LEN(DATEPART(month,ur.trans_date)) = 1 THEN  CONCAT(DATEPART(year,ur.trans_date),'0',DATEPART(month,ur.trans_date))
		ELSE CONCAT(DATEPART(year,ur.trans_date),DATEPART(month,ur.trans_date)) END CYM,
	CASE WHEN pvi.num_vehicles < 4 and pdi.num_drivers < 4 then CONCAT(pvi.num_vehicles,'_',pdi.num_drivers) 
		WHEN pvi.num_vehicles >= 4 and pdi.num_drivers < 4 then CONCAT('4+','_',pdi.num_drivers) 
		WHEN pvi.num_vehicles < 4 and pdi.num_drivers >= 4 then CONCAT(pvi.num_vehicles,'_','4+') 
		WHEN pvi.num_vehicles >= 4 and pdi.num_drivers >= 4 then CONCAT('4+','_','4+') END Veh_Driver, 
	pvi.num_vehicles,pdi.num_drivers,pdi.num_excluded_drivers,pdi.Female_Drivers,pdi.Male_Drivers,
	pvi.Vehicle_Profile, pdi.Excluded, pdi.FDL,
--	pd.[Advanced Quote],pd.Homeownership,pd.[Multi Car],pd.[Multi-Policy],pd.[Paid in Full],pd.[Prior Insurance],pd.[Recurring Payment] --7/30
	f.[Recurring Payment] [Recurring Payment Status],f.[Prior Insurance] [Prior Insurance Status],f.[Paid in Full] [Paid in Full Status],f.Homeownership [Homeownership Status],
	f.[Multi Car] [Multi Car Status],f.[Advanced Quote] [Advanced Quote Status],f.[Multi-Policy] [Multi-Policy Status], --7/31
	f.[Latest Image Recurring Payment] [Latest Img Recurring Payment Status],
	f.[Latest Image Prior Insurance] [Latest Img Prior Insurance Status],
	f.[Latest Image Paid in Full] [Latest Img Paid in Full Status],
	f.[Latest Image Homeownership] [Latest Img Homeownership Status],
	f.[Latest Image Multi Car] [Latest Img Multi Car Status],
	f.[Latest Image Advanced Quote] [Latest Img Advanced Quote Status],
	f.[Latest Image Multi-Policy] [Latest Img Multi-Policy Status],
	CASE WHEN f.[Recurring Payment] <> 'No Change' THEN 'Recurring Payment Discount'
		WHEN f.[Prior Insurance] <> 'No Change' THEN 'Prior Insurance Discount'
		WHEN f.[Paid in Full] <> 'No Change' THEN 'Paid in Full Discount'
		WHEN f.Homeownership <> 'No Change' THEN 'Homeownership Discount'
		WHEN f.[Multi Car] <> 'No Change' THEN 'Multi Car Discount'
		WHEN f.[Advanced Quote] <> 'No Change' THEN 'Advanced Quote Discount'
		WHEN f.[Multi-Policy] <> 'No Change' THEN 'Multi-Policy Discount'
		ELSE 'Other Change/No Change' END [Discount Effected],
	CASE WHEN f.[Recurring Payment] <> 'No Change' THEN f.[Latest Image Recurring Payment]
		WHEN f.[Prior Insurance] <> 'No Change' THEN f.[Latest Image Prior Insurance]
		WHEN f.[Paid in Full] <> 'No Change' THEN f.[Latest Image Paid in Full]
		WHEN f.Homeownership <> 'No Change' THEN f.[Latest Image Homeownership]
		WHEN f.[Multi Car] <> 'No Change' THEN f.[Latest Image Multi Car]
		WHEN f.[Advanced Quote] <> 'No Change' THEN f.[Latest Image Advanced Quote]
		WHEN f.[Multi-Policy] <> 'No Change' THEN f.[Latest Image Multi-Policy]
		ELSE '' END [Current Status of Effected Discount]
--into Product_DSQl2..UprateReportv3 --used when the entire table gets dropped to accomodate new columns
into #T2
--from Product_DSQl2..UprateReport ur
from #T1 ur
left join #policyVehInfo pvi on pvi.policy_id = ur.policy_id and pvi.policyimage_num = ur.policyimage_num
left join #PolicyDriverInfo pdi on pdi.policy_id = ur.policy_id and pdi.policyimage_num = ur.policyimage_num
left join diamond..vpolicyimagexml vp on vp.policy_id = ur.policy_id and vp.policyimage_num = ur.policyimage_num
LEFT JOIN diamond.dbo.Version v on v.version_id=vp.version_id
LEFT JOIN diamond.dbo.vCompanyStateLOB csl on csl.companystatelob_id=v.companystatelob_id
--left join #policydiscounts pd on pd.policy_id = ur.policy_id and pd.policyimage_num = ur.policyimage_num
inner join #truefinal f on f.policy_id = ur.policy_id and f.policyimage_num = ur.policyimage_num
where ur.policy not like '__R%'
AND csl.lob_id not in (30,31) --remove aviation
--and ur.policy_id = 13077746

--select * from Product_DSQl2..UprateReportv3 where policy_id = 13077746

select * from #T2 order by trans_date




