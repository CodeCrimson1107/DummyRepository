use [DuckCreek_DataMart]
SELECT 
distinct (status) as [Status],
sum([SR_22?]) as SR_22,
count(*) as [Total_Policies]
--sum([SR_22?])/count(*) as [Ratio]
FROM (
    SELECT *,
	ROW_NUMBER() OVER (PARTITION BY policy_number ORDER BY modified_date desc) AS ROWNUM,
	case when fee_SR22 != 0 then 1 else 0 end as [SR_22?]
    FROM dbo.Policy
) x 
WHERE 
ROWNUM = 1 
and
risk_state = 'WI' 
group by status
--fee_SR22 = 0
--group by policy_number,
--status, 
--status_key,
--status_reason,
--modified_date
