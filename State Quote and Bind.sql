use [Storehouse]
go
select
quote = sum(quote)
,bound = sum(bound)
,DPW_CHANNEL
,AgentDBA
,riskstate
,init
,quote_year
,quote_month
,quote_day
,day_of_week = FORMAT(quotedate, 'dddd')
,riskstate
,quotedate
,Channel_grp = case when DPW_CHANNEL in ('ANSWERFIN' , 'ANSWERIAC' , 'ANSWEROTHE' , 'ANSWERRAI' ) then 'National Acct'
				when DPW_CHANNEL in ('COMPARE' , 'CUSTOMER' , 'DATALOT' , 'DATALOT2' , 'EQ2'
									, 'EQ3' , 'EQ4' , 'EVERQUOTE' , 'FETCH' , 'GAIA'
									, 'INSDRESP' , 'INSURIFY'  , 'KISS2', 'KISS3'
									, 'LeadCloud' , 'MEDALPH' , 'NEXTGEN' , 'QUIN2'
									, 'QUINSTREET' , 'QUOTEXCHNG' , 'RATEFORCE' , 'SMRTFIN'
									, 'SMRTFIN2' , 'ZEBRA'  ) then 'AD'
				else 'IA'
				end
from dbo.Quote_report_enhanced
where flag_ALBR	= 'N'
group by DPW_CHANNEL
,AgentDBA
,riskstate
,init
,quote_year
,quote_month
,quote_day
,quotedate
