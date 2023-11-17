use [DuckCreek_DataMart]
SELECT 
risk_state as [State],
count(*) as QuoteCNT,
case when fee_SR22 != 0.00 then 1 else 0 end as [SR_22]
--case when fee_SR22 = 0.00 then 1 else 0 end as [Not_SR_22]

FROM dbo.Policy
where 
risk_state = 'WI' and
start_date > '2022-05-13 00:01:00.0000000'
group by 
risk_state,
fee_SR22

order by risk_state