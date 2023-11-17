use [DuckCreek_DataMart]
go
select
distinct(T1.policy_number),
T1.agency_code,
convert(date,T1.effective_date) as Effective_Date,
year(T1.effective_date)*100+MONTH(t1.effective_date) as EffYYYYMM,
year(T1.effective_date)*10000+MONTH(t1.effective_date)*100+DAY(t1.effective_date) as EffYYYYMMDD,
T1.sales_channel,
T1.term
--T1.risk_state

from dbo.Policy T1
	INNER JOIN
    (SELECT policy_number, MAX(effective_date) AS MaxEffDate
    FROM Policy
    GROUP BY policy_number
	) T2
on T1.policy_number = T2.policy_number 
and year(T1.effective_date)*100+MONTH(t1.effective_date) = year(T2.MaxEffDate)*100+MONTH(T2.MaxEffDate)

where 
T1.agency_code is not null 
and T1.sales_channel is not null
 
group by 
T1.policy_number,
T1.agency_code,
convert(date,T1.effective_date),
year(T1.effective_date)*100+MONTH(t1.effective_date),
year(T1.effective_date)*10000+MONTH(t1.effective_date)*100+DAY(t1.effective_date),
T1.sales_channel,
T1.term
--T1.risk_state

order by t1.policy_number desc