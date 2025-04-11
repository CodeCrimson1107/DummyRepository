declare @st VARCHAR(50)
set @st = 'NM'

INSERT INTO [HLDI - Highway Loss Data Institute].dbo.NM_Class_Zip_2019_2024	
	select 
	'BI' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2024_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,	Age
	,Zip

UNION ALL

select 
	
	'PDL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2024_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COMP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,NULL [paidClaims]
	,NULL [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,sum(fireclm) [fireclm]	
	,sum(firepay) [firepay]
	,sum(glasclm) [glasclm]
	,sum(glaspay) [glaspay]	
	,sum(othrclm) [othrclm]	
	,sum(othrpay) [othrpay]
	,sum(thftclm) [thftclm]
	,sum(thftpay) [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COMP_2024_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COLL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) [claimPayments]
	,sum(salClaims) [salClaims]
	,sum(salPayments) [salPayments]
	,sum(subClaims) [subClaims]
	,sum(subPayments) [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COLL_2024_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PIP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PIP_2024_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL

select 
	
	'MED' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip
FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_MED_2024_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

union all
	
	select 
	'BI' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip


FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2023_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PDL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2023_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COMP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,NULL [paidClaims]
	,NULL [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,sum(fireclm) [fireclm]	
	,sum(firepay) [firepay]
	,sum(glasclm) [glasclm]
	,sum(glaspay) [glaspay]	
	,sum(othrclm) [othrclm]	
	,sum(othrpay) [othrpay]
	,sum(thftclm) [thftclm]
	,sum(thftpay) [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COMP_2023_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COLL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) [claimPayments]
	,sum(salClaims) [salClaims]
	,sum(salPayments) [salPayments]
	,sum(subClaims) [subClaims]
	,sum(subPayments) [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COLL_2023_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PIP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PIP_2023_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL

select 
	
	'MED' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_MED_2023_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL 

select 
	
	'BI' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2022_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PDL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2022_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COMP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,NULL [paidClaims]
	,NULL [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,sum(fireclm) [fireclm]	
	,sum(firepay) [firepay]
	,sum(glasclm) [glasclm]
	,sum(glaspay) [glaspay]	
	,sum(othrclm) [othrclm]	
	,sum(othrpay) [othrpay]
	,sum(thftclm) [thftclm]
	,sum(thftpay) [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COMP_2022_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COLL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) [claimPayments]
	,sum(salClaims) [salClaims]
	,sum(salPayments) [salPayments]
	,sum(subClaims) [subClaims]
	,sum(subPayments) [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COLL_2022_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PIP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PIP_2022_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL

select 
	
	'MED' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_MED_2022_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL 

select 
	
	'BI' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2021_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,	Age
	,Zip

UNION ALL

select 
	
	'PDL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2021_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COMP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,NULL [paidClaims]
	,NULL [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,sum(fireclm) [fireclm]	
	,sum(firepay) [firepay]
	,sum(glasclm) [glasclm]
	,sum(glaspay) [glaspay]	
	,sum(othrclm) [othrclm]	
	,sum(othrpay) [othrpay]
	,sum(thftclm) [thftclm]
	,sum(thftpay) [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COMP_2021_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COLL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) [claimPayments]
	,sum(salClaims) [salClaims]
	,sum(salPayments) [salPayments]
	,sum(subClaims) [subClaims]
	,sum(subPayments) [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COLL_2021_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PIP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PIP_2021_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL

select 
	
	'MED' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip
FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_MED_2021_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL 

select 
	
	'BI' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2020_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,	Age
	,Zip

UNION ALL

select 
	
	'PDL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2020_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COMP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,NULL [paidClaims]
	,NULL [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,sum(fireclm) [fireclm]	
	,sum(firepay) [firepay]
	,sum(glasclm) [glasclm]
	,sum(glaspay) [glaspay]	
	,sum(othrclm) [othrclm]	
	,sum(othrpay) [othrpay]
	,sum(thftclm) [thftclm]
	,sum(thftpay) [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COMP_2020_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COLL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) [claimPayments]
	,sum(salClaims) [salClaims]
	,sum(salPayments) [salPayments]
	,sum(subClaims) [subClaims]
	,sum(subPayments) [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COLL_2020_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PIP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PIP_2020_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL

select 
	
	'MED' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip
FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_MED_2020_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'BI' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_BI_2019_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,	Age
	,Zip

UNION ALL

select 
	
	'PDL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2019_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COMP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,NULL [totalClaims]
	,NULL [paidClaims]
	,NULL [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,sum(fireclm) [fireclm]	
	,sum(firepay) [firepay]
	,sum(glasclm) [glasclm]
	,sum(glaspay) [glaspay]	
	,sum(othrclm) [othrclm]	
	,sum(othrpay) [othrpay]
	,sum(thftclm) [thftclm]
	,sum(thftpay) [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COMP_2019_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'COLL' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) [earnedDays]
	,NULL [totalClaims]
	,sum(claims) [paidClaims]
	,sum(Payments) [claimPayments]
	,sum(salClaims) [salClaims]
	,sum(salPayments) [salPayments]
	,sum(subClaims) [subClaims]
	,sum(subPayments) [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_COLL_2019_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

UNION ALL

select 
	
	'PIP' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip

FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_PIP_2019_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip

	UNION ALL

select 
	
	'MED' [coverageType] 
	,State [policyState]
	,calendarYear
	,CONCAT(Marital,Gender,Age) as [class]
	,marital
	,gender
	,age
	,sum(Days) as [earnedDays]
	,sum(TotalClaims) as [totalClaims]
	,sum(Paidclaims) as [paidClaims]
	,sum(Payments) as [claimPayments]
	,NULL [salClaims]
	,NULL [salPayments]
	,NULL [subClaims]
	,NULL [subPayments]
	,NULL [fireclm]	
	,NULL [firepay]
	,NULL [glasclm]
	,NULL [glaspay]	
	,NULL [othrclm]	
	,NULL [othrpay]
	,NULL [thftclm]
	,NULL [thftpay]
	,zip
FROM [HLDI - Highway Loss Data Institute].dbo.HLDI_MED_2019_1024
WHERE 
	State = @st 
	
GROUP BY 
	CalendarYear
	,State
	,CONCAT(Marital,Gender,Age)
	,Marital
	,Gender
	,Age
	,Zip
