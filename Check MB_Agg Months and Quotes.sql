use [Marketing]
go
SELECT COUNT (*) As CNT,Date_Data
FROM dbo.MB_AGG_AL
GROUP BY Date_Data
ORDER BY Date_Data
