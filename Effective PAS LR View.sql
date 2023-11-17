


/****** Script for SelectTopNRows command from SSMS  ******/

create view [Effective_PAS_LR] as 
with t1 as (

Select a.FK_Record,
		a.vin,
		b.agency_code,
		b.term,
		b.proof_of_prior,
		b.tier,
		b.payment_plan,
		b.total_drivers,
		b.total_vehicles,
		b.profile,
		b.driver_mix,
		c.garage_postal_code,
		c.model_age,
		c.max_horsepower,
		c.class_size,
		c.model_year,
		c.vehicle_type,
		b.homeowner,
		b.policy_number,
		b.renewal,
		b.sales_channel,
		b.endorsement,
		b.[start_date],
		b.policy_number_renewal_endorsement,
		ROW_NUMBER() over (partition by policy_number_renewal_endorsement, c.vin order by b.[start_date] asc) as dupe,
		cast(right(policy_number,8) as int) as polno,
		left(policy_number,2) as branch,
		'PA' as Carrier,
		'DC' as Program
from DuckCreek_DataMart.dbo.[Transaction] as a with (nolock) inner join DuckCreek_DataMart.dbo.[policy] as b with (nolock) on
		a.FK_Record = b.PK_composite inner join DuckCreek_DataMart.dbo.[Vehicle] as c with (nolock)
		on a.FK_Record = c.FK_Record and a.vin = c.vin
where garage_postal_code <> 'TBD'
),

--toss out any duplicated records on policy number endorsement vin--

T2 as (

Select *
from t1
where dupe = 1

),

--join chcfli00 on merge fields -- 

T3 as (

Select *
from Attunity_REPL.DuckCreek.CHCLFI00 as a left join t2 as b on 
    a.CLPBRAN = branch COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS and
	a.CLPCARR = Carrier COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS and
	a.CLPPROG = Program COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS and
	a.CLPNO = polno and
	isnull(a.CLPREN,0) = renewal and
	isnull(a.CLPEND,0) = endorsement and
	a.CLIID = vin COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS
),

--join with other loss tables to get loss data --

T4 as (

SELECT
			 T04.[STATE]
			,INCUR = T02.CTPAY + T02.CTRES
			,T01.AGENCY_CODE 
			,t01.class_size
			,t01.model_year
			,t01.model_age
			,t01.max_horsepower
			,t01.policy_number
			,t01.renewal
			,t01.endorsement
			,t01.profile
			,t01.proof_of_prior
			,t01.tier
			,t01.driver_mix
			,t01.total_drivers
			,t01.total_vehicles
			,t01.term
			,homeowner
			,t01.garage_postal_code
			,t01.vin
			,CTLOB as lob
			,sales_channel
			,CASE WHEN T02.CTTRAN IN ('I1','01','03','05','5A','06','6A','11','12','13') THEN T02.CTPAY ELSE 0 END AS PAIDLOSS
			,CASE WHEN T02.CTTRAN IN ('I1','01','03','05','5A','06','6A','11','12','13') THEN T02.CTPAY + T02.CTRES ELSE 0 END AS INCLOSS
			,CASE WHEN T02.CTTRAN IN ('I1','01','03','05','5A','06','6A','11','12','13') THEN T02.CTRES ELSE 0 END AS RESLOSS
			,CASE WHEN T02.CTTRAN IN ('I2','02','04','07','08','14','15','16','ER') THEN T02.CTPAY ELSE 0 END AS PAIDEXP
			,CASE WHEN T02.CTTRAN IN ('I2','02','04','07','08','14','15','16','ER') THEN T02.CTPAY + T02.CTRES ELSE 0 END AS INCEXP
			,CASE WHEN T02.CTTRAN IN ('I2','02','04','07','08','14','15','16','ER') THEN T02.CTRES ELSE 0 END AS RESEXP
			,CASE WHEN T02.CTTRAN IN ('09','10','OT') THEN T02.CTPAY ELSE 0 END AS PAIDREC
			,CASE WHEN T02.CTTRAN IN ('09','10','OT') THEN T02.CTPAY + T02.CTRES ELSE 0 END AS INCREC
			,CASE WHEN T02.CTTRAN IN ('09','10','OT') THEN T02.CTRES ELSE 0 END AS RESREC
			,CASE WHEN T02.CTTRAN IN ('13') THEN 1 ELSE 0 END AS REOPEN

			,ACTDTE = T02.CTACC * 10000 + T02.CTAYY * 100 + T02.CTAMM
			,ACTDATE = /*ACTDTE*/ (T02.CTACC*10000 + T02.CTAYY*100 + T02.CTAMM)* 100 + T02.CTADD
			,ACT_DATE = /*ACTDATE*/ CONVERT(DATE,CONVERT(VARCHAR(10),(T02.CTACC*10000 + T02.CTAYY*100 + T02.CTAMM)* 100 + T02.CTADD))
			,RPTDTE = T01.CLRECC * 10000 + T01.CLREYY * 100 + T01.CLREMM
			,RPTDATE = /*RPTDTE*/ (T01.CLRECC*10000 + T01.CLREYY*100 + T01.CLREMM)*100 + T01.CLREDD
			,RPT_DATE = /*RPTDATE*/ CONVERT(DATE,CONVERT(VARCHAR(10),(T01.CLRECC*10000 + T01.CLREYY*100 + T01.CLREMM)*100 + T01.CLREDD))
			,LOSDTE = T01.CLLCC * 10000 + T01.CLLYY * 100 + T01.CLLMM
			,LOSDATE = /*LOSDTE*/ (T01.CLLCC*10000 + T01.CLLYY*100 + T01.CLLMM)*100 + T01.CLLDD
			,LOS_DATE = /*LOSDATE*/ CONVERT(DATE,CONVERT(VARCHAR(10),(T01.CLLCC*10000 + T01.CLLYY*100 + T01.CLLMM)*100 + T01.CLLDD))
			,EFFDTE = T02.CTPEFCC * 10000 + T02.CTPEFYY * 100 + T02.CTPEFMM
			,EFFDATE = /*EFFDTE*/ (T02.CTPEFCC*10000 + T02.CTPEFYY*100 + T02.CTPEFMM)*100 + T02.CTPEFDD
			,EFF_DATE = /*EFFDATE*/ CONVERT(DATE,CONVERT(VARCHAR(10),NULLIF((T02.CTPEFCC*10000 + T02.CTPEFYY*100 + T02.CTPEFMM)*100 + T02.CTPEFDD,00000000)))
			,CLSDTE = T03.LACCC * 10000 + T03.LACYY * 100 + T03.LACMM
			,CLSDATE = /*CLSDTE*/ (T03.LACCC*10000 + T03.LACYY*100 + T03.LACMM)*100 + T03.LACDD
			,CLS_DATE = /*CLSDATE*/ CONVERT(DATE,CONVERT(VARCHAR(10),NULLIF((T03.LACCC*10000 + T03.LACYY*100 + T03.LACMM)*100 + T03.LACDD,00000000)))

			,LOSSQTR = CONVERT(VARCHAR(4),(T01.CLLCC*100 + T01.CLLYY)) + 'Q' +
					CONVERT(VARCHAR(2),DATENAME(QQ,CONVERT(DATE,CONVERT(VARCHAR(10),(T01.CLLCC*10000 + T01.CLLYY*100 + T01.CLLMM)*100 + T01.CLLDD))))		

FROM		T3 AS T01 
			LEFT JOIN Attunity_REPL.DuckCreek.CHCLFI02 as T02 
				ON T01.CLCLMNO = T02.CTCLMNO
			LEFT JOIN ATTUNITY_REPL.DUCKCREEK.CHCLFI01 T03 
				ON T01.CLCLMNO = T03.LACLMNO
				AND T02.CTCLMSU = T03.LACLMSU
			LEFT JOIN STOREHOUSE.ACTUARIAL.BRCRPRST T04
				ON T01.CLPBRAN = T04.BRANCH COLLATE LATIN1_GENERAL_CS_AS
				AND T01.CLPCARR = T04.CARRIER COLLATE LATIN1_GENERAL_CS_AS
				AND T01.CLPPROG = T04.PROGRAM COLLATE LATIN1_GENERAL_CS_AS
),

T5 as (

Select 
	   a.agency_code,
	   a.state_name,
	   b.sales_channel,
	   b.proof_of_prior,
	   b.profile,
	   b.total_vehicles,
	   b.driver_mix,
	   b.total_drivers,
	   b.homeowner,
	   b.tier,
	   b.term,
	   b.policy_number,
	   b.renewal,
	   a.lob,
	   b.postal_code_base as zip,
	   t2.model_age,
	   t2.class_size,
	   t2.model_year,
	   year(b.effective_date)*100+MONTH(b.effective_date) as EFFDTE,
	   year(a.AsOfDate)*100+MONTH(a.AsOfDate) as ACTDTE,
	   b.premium_with_fees as polprem,
	   sum(a.premium_earned) as calep,
	   sum(a.premium_writen) as netwp,
	   0 as incur
from storehouse.Actuarial.PREM_SNAPSHOT as a left join
     DuckCreek_DataMart.dbo.Policy as b on
	 a.PK_composite = b.PK_composite
	 left join t2 on t2.vin = a.vin and t2.fk_record = a.pk_composite
Where postal_code_base <> 'TBD'
group by AsOfDate,
	   a.agency_code,
	   a.state_name,
	   b.proof_of_prior,
	   b.profile,
	   b.total_vehicles,
	   b.driver_mix,
	   b.total_drivers,
	   b.effective_date,
	   b.homeowner,
	   b.owner_nonowner,
	   b.tier,
	   b.term,
	   b.premium_with_fees,
	   b.postal_code_base,
	   b.sales_channel,
	   b.policy_number,
	   b.renewal,
	   lob,
	   model_age,
	   class_size,
	   model_year

)



Select agency_code,
	   t4.State as state_name,
	   sales_channel,
	   proof_of_prior,
	   profile,
	   total_vehicles,
	   driver_mix,
	   total_drivers,
	   homeowner,
	   tier,
	   term,
	   policy_number,
	   renewal,
	   lob,
	   garage_postal_code as zip,
	   EFFDTE,
	   ACTDTE,
	   0 as polprem,
	   0 as calep,
	   0 as netwp,
	   sum(INCUR) as incur,
	   b.RISK_AREA,
	   b.P_LEVEL,
	   t4.model_age,
	   t4.class_size,
	   t4.model_year
from T4 left join Marketing.dbo.TerrKey as b on t4.garage_postal_code = b.ZIP
where ACTDTE <= year(getdate()-30)*100+month(getdate()-30)
group by agency_code,
		 b.RISK_AREA,
		 b.P_LEVEL,
		 t4.State,
		 sales_channel,
		 proof_of_prior,
		 profile,
		 total_vehicles,
		 driver_mix,
		 total_drivers,
		 homeowner,
		 tier,
		 term,
		 policy_number,
		 renewal,
		 garage_postal_code,
		 EFFDTE,
		 ACTDTE,
		 lob,
		 t4.model_age,
	     t4.class_size,
		 t4.model_year
union all
Select agency_code,
	   state_name,
	   sales_channel,
	   proof_of_prior,
	   profile,
	   total_vehicles,
	   driver_mix,
	   total_drivers,
	   homeowner,
	   tier,
	   term,
	   policy_number,
	   renewal,
	   lob,
	   t5.zip,
	   EFFDTE,
	   ACTDTE,
	   polprem,
	   calep,
	   netwp,
	   0 as incur,
	   RISK_AREA,
	   P_LEVEL,
	   model_age,
	   class_size,
	   model_year
from T5 left join Marketing.dbo.TerrKey as c on t5.zip = c.ZIP 
