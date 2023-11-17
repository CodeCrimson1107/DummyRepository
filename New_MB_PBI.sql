use [Marketing]
go
WITH CTE AS
(   SELECT   
			CARRIER AS COMPANY, 
			SUM(TOTPREM) AS TOTAL_PREMIUM,
			POP,
			COMPANY2,
			COUNT(TOTPREM) AS QUOTES,
			RISK_AREA,
			P_LEVEL,
			Q_YEAR AS QUOTE_YEAR,
			Q_MONTH AS QUOTE_MM,
			PROFILEP AS [PROFILE],
			DRVCNT,
			VEHCNT AS VEHCNT,
			'UT' as [State],
			LABEL as Label,
			DOMESTIC as Intl_Dom,
			PREMDIFF,
			TOTPREM,
			PREM1,
			case when COMPANY2 = CARRIER then 1 else 0 end as RANK2WIN,
            NTILE(2) OVER(PARTITION BY CARRIER ORDER BY TOTPREM) AS [half1], 
            NTILE(2) OVER(PARTITION BY CARRIER ORDER BY TOTPREM DESC) AS [half2] 
    FROM    dbo.UT_MB AS A LEFT JOIN DBO.TERRKEY AS B ON A.ZIP = B.ZIP
    WHERE   TOTPREM IS NOT NULL
	GROUP BY [STATE],CARRIER,TOTPREM,POP,RISK_AREA,P_LEVEL,Q_YEAR,Q_MONTH,PROFILEP,DRVCNT,VEHCNT,LABEL,DOMESTIC,PREMDIFF,PREM1,COMPANY2
)
SELECT  [State],
		COMPANY as [CompanyName_Program],
		QUOTE_YEAR*100+QUOTE_MM as Date_Data,
		Risk_Area,
		P_Level,
		PROFILE,
		Intl_Dom,
		Label,
		case when Label = 'WIN' 
			 then sum(Quotes)
			 else 0 end as WINS,
		PREMDIFF as [DOLDIFF],
		sum(quotes) as QuoteCNT,
		sum(RANK2WIN) as RANK2WIN,
		sum(TOTAL_PREMIUM) AS [TotalPremTermAdj],
		PREM1 as [TotalPremTermAdj01],
        ((MAX(CASE WHEN Half1 = 1 THEN TOTAL_PREMIUM ELSE 0 END) + MIN(CASE WHEN Half2 = 1 THEN TOTAL_PREMIUM ELSE 0 END)) / 2.0) AS [MedianTotalPremTermAdj]
FROM    CTE
GROUP BY [State],COMPANY,QUOTE_YEAR*100+QUOTE_MM,RISK_AREA,P_LEVEL,PROFILE,Intl_Dom,Label,PREMDIFF,PREM1
union all
select *
from dbo.MB_AGG_AL
union all
select *
from dbo.MB_AGG_AR
union all
select *
from dbo.MB_AGG_AZ
union all
select *
from dbo.MB_AGG_FL
union all
select *
from dbo.MB_AGG_GA
union all
select *
from dbo.MB_AGG_IN
union all
select *
from dbo.MB_AGG_IL
union all
select *
from dbo.MB_AGG_MO
union all
select *
from dbo.MB_AGG_MS
union all
select *
from dbo.MB_AGG_NM
union all
select *
from dbo.MB_AGG_OH
union all
select *
from dbo.MB_AGG_OK
union all
select *
from dbo.MB_AGG_SC
union all
select *
from dbo.MB_AGG_TN
union all
select *
from dbo.MB_AGG_TX
union all
select *
from dbo.MB_AGG_VA
union all
select *
from dbo.MB_AGG_VA





