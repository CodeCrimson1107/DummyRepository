select 
	COV
	,State [policyState]
	,calendarYear
	,VehicleClassName
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,MakeName
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	--,NULL [salClaims]
	--,NULL [salPayments]
	--,NULL [subClaims]
	--,NULL [subPayments]
	--,NULL [fireclm]	
	--,NULL [firepay]
	--,NULL [glasclm]
	--,NULL [glaspay]	
	--,NULL [othrclm]	
	--,NULL [othrpay]
	--,NULL [thftclm]
	--,NULL [thftpay]
FROM [HLDI - Highway Loss Data Institute].dbo.v_VIN_Detail_BI
WHERE 
	state = 'OK'
	and calendarYear = 2023
group by	
	COV
	,State
	,calendarYear
	,VehicleClassName
	,CONCAT(Marital,Gender,Age)
	,marital
	,gender
	,age
	,MakeName