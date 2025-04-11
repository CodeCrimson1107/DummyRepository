--select top 100 * from diamond.dbo.AgencyProducer;
--select top 100 * from diamond.dbo.Agency;
--select top 100 * from diamond.dbo.vAgencyProducer where code = '4220984-160-000'
--select top 100 * from diamond.dbo.agencyproducerlicense;
--select top 100 * from diamond.dbo.State;
--select top 100 * from diamond.dbo.vAgency where commercial_name1 like '%L.A. Insurance%';
--select top 100 * from diamond.dbo.address;
--select * from Diamond.dbo.AgencyAddressLink;

SELECT 
	A.code [Agency Code]
	,A.commercial_name1 [Agency Name]
	,AD.display_address [Agency Address]
	--,AP.agencyproducer_id
	--,AP.status [License Status]
	,case when year(AG.close_date)*100+month(AG.close_date) > 180001 and year(AG.rehab_date)*100+month(AG.rehab_date) = 180001 then 'Closed' else 'Open' end as [Agency_Status]
	,case when AP.name is null then 'No Producer Available' else AP.name end as [Producer Name] 
	--,APL.eff_date [Appointment Date]
	--,APL.exp_date [Expiration Date]
	--,APl.pcadded_date [Added Date]
	--,APL.last_modified_date [Modified Date]
	,case when APROD.terminated_date = '1800-01-01' then 'Active' 
	 else 'Terminated' end as [Producer Status]
	,ST.state [Agency State]
	--,Ad
	--,APROD.terminated_date
FROM Diamond.dbo.vAgency A
LEFT JOIN diamond.dbo.vAgencyProducer AP on A.agency_id = AP.agency_id
LEFT JOIN diamond.dbo.Agency AG on AP.agency_id = AG.agency_id
LEFT JOIN diamond.dbo.AgencyProducerLicense APL on AP.agencyproducer_id = APL.agencyproducer_id
LEFT JOIN diamond.dbo.AgencyProducer APROD on AP.agencyproducer_id = APROD.agencyproducer_id
LEFT JOIN Diamond.dbo.AgencyAddressLink AAL on AAL.agency_id = A.agency_id
LEFT JOIN diamond.dbo.address AD on AD.address_id = AAL.address_id
LEFT JOIN diamond.dbo.State ST on AD.state_id = ST.state_id
where 
	--A.agencygroup_id = 263
--	and A.code like '4216697%'
	AP.status = 1
	and st.state = 'NM'
	--and A.status = 1
	--and APROD.terminated_date = '1800-01-01' 
	--OR APROD.terminated_date = '' OR APROD.terminated_date IS NULL
	and AD.display_address != ''
	and APROD.terminated_date = '1800-01-01'
	--and APL.exp_date >= '2024-08-05' 
	--OR APL.exp_date = '' 
GROUP BY 
	A.code 
	,A.commercial_name1
	,AD.display_address
	--,AP.agencyproducer_id
	--,AP.status
	,case when year(AG.close_date)*100+month(AG.close_date) > 180001 and year(AG.rehab_date)*100+month(AG.rehab_date) = 180001 then 'Closed' else 'Open' end
	,case when AP.name is null then 'No Producer Available' else AP.name end
	,APL.eff_date
	,case when APROD.terminated_date = '1800-01-01' then 'Active' 
	 else 'Terminated' end
	--,APL.exp_date
	--,APl.pcadded_date
	--,APL.last_modified_date 
	,ST.state
	--,APROD.terminated_date
		--having Agency_Status = 'Open'
ORDER BY
	A.code
	--,AP.code asc
	--AP.agencyproducer_id asc