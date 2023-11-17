use [Marketing]
go
SELECT MAX(RATE_YR*100+RATE_MO) AS YYYYMM
FROM dbo.OK_MB

