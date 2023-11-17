use [Marketing]
go
--UPDATE DBO.MB_AGG_WI_NEW
--SET CompanyName_Program = 
--CASE
--	WHEN CompanyName_Program like '%126229525%' THEN 'GAINSCO'
--	ELSE CompanyName_Program
--end

--where CompanyName_Program like '%126229525%'

UPDATE DBO.MB_AGG_WI_NEW
SET CompanyName_Program = 
CASE
	WHEN CompanyName_Program like '%126229525%' THEN 'Gainsco'
	ELSE CompanyName_Program
end

where CompanyName_Program like '%126229525%'
;
UPDATE DBO.MB_AGG_MS_NEW
SET CompanyName_Program = 
CASE
	WHEN CompanyName_Program like '%126229696%' THEN 'Gainsco'
	ELSE CompanyName_Program
end

where CompanyName_Program like '%126229696%'