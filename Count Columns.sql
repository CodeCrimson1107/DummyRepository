use [Marketing]
go
select count(*)
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'ITC_GA_N_XL'