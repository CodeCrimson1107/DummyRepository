WITH CTE as 
	(

	select 
		kma.zip
		,sum(hldi.fireclm) + sum(hldi.glasclm) + sum(hldi.othrclm) + sum(hldi.thftclm) [paidClaims]
		,sum(hldi.firepay) + sum(hldi.glaspay) + sum(hldi.othrpay) + sum(hldi.thftpay) [claimPayments]
		,sum(hldi.earnedDays)/365.25 [ECY]
		,(sum(hldi.fireclm) + sum(hldi.glasclm) + sum(hldi.othrclm) + sum(hldi.thftclm))/(sum(hldi.earnedDays)/365.25) [Frequency]
		,case when (sum(hldi.firepay) + sum(hldi.glaspay) + sum(hldi.othrpay) + sum(hldi.thftpay)) = 0  
			  then 0 
			  else (sum(hldi.firepay) + sum(hldi.glaspay) + sum(hldi.othrpay) + sum(hldi.thftpay))/(sum(hldi.fireclm) + sum(hldi.glasclm) + sum(hldi.othrclm) + sum(hldi.thftclm))
			  end as [Severity] 
		,sum(hldi.fireclm) [fireclm]
		,sum(hldi.firepay) [firepay]
		,sum(hldi.glasclm) [glasclm]
		,sum(hldi.glaspay) [glaspay]
		,sum(hldi.othrclm) [othrclm]
		,sum(hldi.othrpay) [othrpay]
		,sum(hldi.thftclm) [thftclm]
		,sum(hldi.thftpay) [thftpay]
	from [HLDI - Highway Loss Data Institute].dbo.NM_Class_Zip_2019_2024 HLDI
	left join Product_DSQl2.dbo.hallmarkterritories kma on kma.zip = HLDI.zip
	where 
		kma.state = 'NM' --change the state variable
		and coverageType = 'COMP' --change the coverage type 
	group by 
		kma.zip
		)
SELECT 
	zip
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
	,sum(CTE.fireclm) [fireclm]
	,sum(CTE.firepay) [firepay]
	,sum(CTE.glasclm) [glasclm]
	,sum(CTE.glaspay) [glaspay]
	,sum(CTE.othrclm) [othrclm]
	,sum(CTE.othrpay) [othrpay]
	,sum(CTE.thftclm) [thftclm]
	,sum(CTE.thftpay) [thftpay]
FROM CTE
group by
	Zip
order by
	zip asc