use [DuckCreek_DataMart]
SELECT
risk_state,
sum(Six_Month) as Six,
sum(TWELVE_Month) as Twelve,
count(*) as [Total_Policies]

FROM (
    SELECT *,
	1 as ROWCNT,
	
	case when term = 'SIX' then 1 else 0 end as Six_Month,
	case when term = 'TWELVE' then 1 else 0 end as TWELVE_Month
	FROM dbo.Policy
) x 

WHERE 
ROWCNT = 1 and agency_code is not NULL and (risk_state = 'TN' or risk_state = 'VA' or risk_state = 'OR' or risk_state = 'IN' or risk_state = 'IL' or risk_state = 'MO' or risk_state='WI')
and year(effective_date)*100+MONTH(effective_date) >= 202110 and year(effective_date)*100+MONTH(effective_date) <= 202112
group by 
risk_state


order by
risk_state


