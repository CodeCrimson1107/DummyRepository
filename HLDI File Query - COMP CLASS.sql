WITH CTE as 
	(
	select 
		hldi.class [Class]
		,sum(hldi.paidClaims) [paidClaims]
		,sum(hldi.claimPayments) [claimPayments]
		,sum(hldi.earnedDays)/365.25 [ECY]
		,sum(hldi.paidClaims)/(sum(hldi.earnedDays)/365.25) [Frequency]
		,case when sum(hldi.paidClaims) = 0  
			  then 0 
			  else sum(hldi.claimPayments)/sum(hldi.paidClaims) 
			  end as [Severity] 
	from [HLDI - Highway Loss Data Institute].dbo.AR_Class_Zip_2019_2024 HLDI
	left join Product_DSQl2.dbo.kma_all kma on kma.zip = HLDI.zip
	where 
		kma.state = 'AR' --change the state variable
		and coverageType = 'BI' --change the coverage type 
	group by 
		hldi.class
		)
SELECT 
	Class
	,sum(ECY) [ECY]
	,sum(Frequency) as [Frequency]
	,FORMAT(sum(Severity), 'c', 'en-US') [Severity]
	,case when power((sum(paidClaims)/1082),0.5) >= 1 
	 then 1
	 else power((CAST(sum(paidClaims) AS float)/1082),0.5) 
	 end as [Credibility]
	,FORMAT(sum(Frequency) * sum(Severity), 'c', 'en-US')  [PurePremium]
	,sum(paidClaims) [Sum of paidClaims]
	,FORMAT(sum(claimPayments), 'c', 'en-US') [Sum of claimPayments]
FROM CTE
group by
	Class
order by
	Severity desc