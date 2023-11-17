USE [Marketing]
GO
select ZIP as zipcode, RISK_AREA as riskarea, CITY, COUNTY,P_LEVEL,STATE, HH_LT75K
from dbo.TerrKey
union all
select distinct ZipCode,RiskArea as riskarea,city, county,P_LEVEL, 'OH' as STATE, HHLT75K
from dbo.OH_MB
union all
select distinct ZipCode,RiskArea as riskarea,city, county,P_LEVEL, 'IN' as STATE, 'n/a' as HHLT75K
from dbo.IN_MB
union all
select ZipCode as zipcode, RISKAREA as riskarea, CITY, COUNTY,P_LEVEL,'AR' as STATE, 'n/a' as HH_LT75K
from dbo.AR_MB_VCP
/*SELECT [ZIP]
      ,[RISK_AREA]
      ,[CITY]
      ,[COUNTY]
      ,[TM]
      ,[P_LEVEL]
      ,[STATE]
      ,[HH_LT75K]
  FROM [dbo].[TerrKey]

union all
SELECT [ZipCode]
      ,[RISKAREA]
      ,[CITY]
      ,[COUNTY]
      ,null as TM
      ,[P_LEVEL]
      ,null as state
      ,[HHLT75K]
  FROM [MARKETING].[DBO].[OH_MB]
  union all
SELECT [ZipCode]
      ,[RISKAREA]
      ,[CITY]
      ,[COUNTY]
      ,null as TM
      ,[P_LEVEL]
      ,null as state
      ,null as HHLT75K
  FROM [MARKETING].[DBO].[IN_MB]
  union all
SELECT [ZipCode]
      ,[RISKAREA]
      ,[CITY]
      ,[COUNTY]
      ,null as TM
      ,[P_LEVEL]
      ,null as state
      ,[HHLT75K]
  FROM [MARKETING].[DBO].[OH_MB]
GO
*/
