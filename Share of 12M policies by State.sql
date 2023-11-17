use [DuckCreek_DataMart]
SELECT 
risk_state as [State],
sum(SR_22) as [SR_22],
sum([Not SR_22]) as [Not SR_22],
Date_Group,
count(*) as [Total_Policies]
--sum([SR_22?])/count(*) as [Ratio]
FROM (
    SELECT *,
	ROW_NUMBER() OVER (PARTITION BY policy_number ORDER BY modified_date desc) AS ROWNUM,
	case when fee_SR22 != 0 then 1 else 0 end as 'SR_22',
	case when fee_SR22 = 0 then 1 else 0 end as 'Not SR_22',
	case when status_effective_date >= '2022-05-16 00:01:00.0000000' then 'Post Change' else 'Pre Change' end as 'Date_Group'
    FROM dbo.Policy
) x 
WHERE 
ROWNUM = 1 and 
risk_state = 'WI'
--risk_state = 'OH' or risk_state = 'OH' or risk_state = 'OH' or risk_state = 'OH' or risk_state = 'OH' or
group by risk_state,
Date_Group
--fee_SR22 = 0
--group by policy_number,
--status, 
--status_key,
--status_reason,
--modified_date
order by Total_Policies desc
