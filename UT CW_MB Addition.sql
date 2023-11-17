use [Marketing]
go

SELECT [State],
		COMPANY,
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
		'' as [RANK2WIN],
		TOTPREM AS [TotalPremTermAdj],
		'' as [TotalPremTermAdj01],
		[RANK3PREM] as [MedianTotalPremTermAdj]
	From (
		select 
			COUNT(TOTPREM) AS QUOTES, 
			CARRIER AS COMPANY, 
			SUM(TOTPREM) AS TOTAL_PREMIUM,
			POP,
			RISK_AREA AS Risk_Area,
			P_LEVEL as P_Level,
			Q_YEAR AS QUOTE_YEAR,
			Q_MONTH AS QUOTE_MM,
			[YEAR] AS MODELYEAR,
			PROFILEP AS [PROFILE],
			DRVCNT, VEHCNT AS VEHCNT,
			'6' AS TERM,
			'UT' AS [STATE],
			LABEL as Label,
			DOMESTIC as Intl_Dom,
			PREMDIFF,
			TOTPREM,
   ( SELECT TOTPREM FROM dbo.UT_MB
     ORDER BY TOTPREM
     OFFSET (@rowcnt - 1) / 2 ROWS
     FETCH NEXT 1 + (1 - @rowcnt % 2) ROWS ONLY
) as [RANK3PREM]
		FROM [MARKETING].[DBO].[UT_MB] AS A LEFT JOIN DBO.TERRKEY AS B ON A.ZIP = B.ZIP
		GROUP BY CARRIER, TOTPREM, POP, RISK_AREA, P_LEVEL, Q_MONTH, [YEAR],PROFILEP, DRVCNT , VEHCNT, POP, LABEL, Q_YEAR,DOMESTIC,PREMDIFF,TOTPREM,PREM3,COMPANY3
		) as a
Group by COMPANY, POP, Risk_Area, P_Level, QUOTE_YEAR, QUOTE_MM, MODELYEAR, [Profile], DRVCNT, VEHCNT, TERM, [State], Intl_Dom,LABEL,PREMDIFF,TOTPREM,RANK3PREM
