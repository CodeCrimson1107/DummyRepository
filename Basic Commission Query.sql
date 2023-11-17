use [Product]
go
Declare @Dfilt int
Set @Dfilt = year(getdate())-2

Select PRATEZIP, sum(pcrcount) as polcnt, sum(PAPREM) as Aprem, Case when prenewal = 0 then NWCM/100*sum(PAprem) else RNWCM/100*sum(PAPREM) end as Comm, 
	   Case when prenewal = 0 then 1 when PINFDAYS > 0 then 1 else 0 end as Inforce, 
	   Case when PRENEWAL = 0 then 'N' else 'R' end as SEQ, PSTATE, PAGENCY, (PEFFYY*100+PEFFMM) as YYYYMM, PEFFYY, PEFFMM
From dbo.PRODCAN as a left join ( Select sum(polcnt) as polcnt, AGENCY, NWCM, RNWCM 
			from dbo.POLPROD where CALLYY >= @Dfilt Group by AGENCY, NWCM, RNWCM ) as b on a.PAGENCY = b.AGENCY
Where PCALLYY >= @Dfilt
Group by PRATEZIP, NWCM, RNWCM, PINFDAYS, PRENEWAL, PSTATE, PAGENCY, PEFFYY, PEFFMM