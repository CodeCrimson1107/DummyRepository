use [Storehouse]
go
select AGENTCODE,zip_garage,sum(quote) as QuoteCNT
from dbo.Quote_report_enhanced
where year_month >= 201911 and year_month < 202012
group by AGENTCODE,zip_garage,quote
