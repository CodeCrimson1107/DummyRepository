use [Marketing]
go
select 
BRANCH,
CARRIER,
PROGRAM,
POLICY,
SEQ,
POP,
EFT,
ZIPCODE,
BOUND_DATE,
year(BOUND_DATE)*100+month(BOUND_DATE) as YYYYMM,
year(SYSTEMDATE)*10000+month(SYSTEMDATE)*100+day(SYSTEMDATE) as YYYYMMDD,
DRVCNT,
VEHCNT,
DOMESTIC,
EXCCNT,
 case when PROFILEP = 'Full Coverage'  then 'F' 
	when PROFILEP = 'Non Owner' then 'N' 
	when PROFILEP = 'Mixed' then 'M' else 'L' end as ProfileP,
TOTALPREMIUM,
HO,
TERM,
AGENTCODE,
INSTALLMENT,
PIF,
OLRW,
PROV_CODE,
CHANNEL,
SYSTEMDATE,
POL_SCORE_SOURCE,
TIERS,
RISK_STATE,
year(systemdate) as year,
month(systemdate) as month,
systemdate as postdate 

from marketing.dbo.NBPROFILE_DCDM