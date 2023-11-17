	use Storehouse
	go
	Declare @Date_filter as Date 
	Declare @This_Sun as Date 
	Declare @Last_Sun as Date  
	Set @Date_filter = dateadd(m,-14,GETDATE()) 
	Set @This_Sun = DATEADD(wk, 0, DATEADD(DAY, 1-DATEPART(WEEKDAY, GETDATE()), DATEDIFF(dd, 0, GETDATE()))) 
	Set @Last_Sun = DATEADD(wk, 0, DATEADD(DAY, 1-DATEPART(WEEKDAY, GETDATE()), DATEDIFF(dd, 0, GETDATE())))-7  
	Select max(quotedate)
	from dbo.Quote_report_enhanced with (nolock) 
	Where quotedate >= @Last_Sun and AGENTCODE is not null
