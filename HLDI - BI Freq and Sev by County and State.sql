	select 
		kma.STATE
		,kma.County
		,sum(hldi.PaidClaims)/(sum(hldi.Days)/365.25) [Frequency]
		,case when sum(hldi.paidClaims) = 0  
			  then 0 
			  else sum(hldi.Payments)/sum(hldi.paidClaims) 
			  end as [Severity] 
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2023 HLDI
	left join Product_DSQl2.dbo.kma_all kma on kma.zip = HLDI.zip
	--where 
	--	kma.state = 'MT' --change the state variable
	group by 
		kma.STATE
		,kma.County