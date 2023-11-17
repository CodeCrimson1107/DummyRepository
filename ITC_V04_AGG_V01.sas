OPTIONS MLOGIC MPRINT SYMBOLGEN;
LIBNAME MARK ODBC READ_ISOLATION_LEVEL = RU SCHEMA=DBO
DBCOMMIT=100000 INSERTBUFF=10000 BULKLOAD=YES CONNECTION=SHARED
DBMAX_TEXT=32767 /* PREVENT TEXT COLUMN TRUNCATION */
REQUIRED=
"DRIVER=SQL SERVER;
DATABASE=MARKETING;
SERVER=DALDBCP06\REPORTING;";

LIBNAME Full "W:\Product\Schwartz_Jonah\ITC_MB\DATA\FULL_TABLES";
LIBNAME Test "W:\Product\Cardell\Market_Basket";

/*%let BEG_DATE = 20210201;*/
/*%let END_DATE = 20210228;*/

%MACRO MB_PBI(state, itc_str_Dt, itc_end_dt);

proc sql;
create table work.&state._&itc_str_Dt._AGG as 
	select
	 "&state" as State
	,Company_name_program
	,&itc_str_dt. as Date_Data
	,Risk_Area
	,P_LVL_TOT
	,CASE
			WHEN InternatDL_Cnt = Num_Drivers THEN "All_International"
			WHEN InternatDL_Cnt = 0 THEN "All_Domestic"
			WHEN InternatDL01 = 0 AND InternatDL_Cnt > 0  THEN "Mixed_DomNI"
			WHEN InternatDL01 = 1 AND InternatDL_Cnt < Num_Drivers THEN "Mixed_IntNI"
			ELSE "Mixed"
		END AS Int_Dom_Mix 	
	%IF %str(&state) = FL %THEN /* FLORIDA */
	,CASE	WHEN NONOWNER = 1 THEN 'NO'
			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1 THEN 'FULL_COV'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND PIPPremium_COV_IND02 = 1 THEN 'FULL_COV'

			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1 /*FC AMD LO*/
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND PIPPremium_COV_IND02 = 1 THEN 'MIXED_FC_LO'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND PIPPremium_COV_IND01 = 1 /*LO AND FC*/
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND PIPPremium_COV_IND02 = 1 THEN 'MIXED_FC_LO'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND PIPPremium_COV_IND01 = 1 /*LO AND PPCC*/
							 AND LiabBIPremium_COV_IND02 = 0 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND PIPPremium_COV_IND02 = 1 THEN 'MIXED_LO_PPCC'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1 /*FC AND PPCC*/
							 AND LiabBIPremium_COV_IND02 = 0 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND PIPPremium_COV_IND02 = 1 THEN 'MIXED'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 0 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1 /*PPCC AND FC*/
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND PIPPremium_COV_IND02 = 1 THEN 'MIXED'


			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 0 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1 THEN 'PPCC'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 0 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND PIPPremium_COV_IND01 = 1 
							 AND LiabBIPremium_COV_IND02 = 0 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND PIPPremium_COV_IND02 = 1 THEN 'PPCC'

			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND PIPPremium_COV_IND01 = 1 THEN 'LO'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND PIPPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND PIPPremium_COV_IND02 = 1 THEN 'LO'

			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 0 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND PIPPremium_COV_IND01 = 1 THEN 'PP'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 0 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND PIPPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 0 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND PIPPremium_COV_IND02 = 1 THEN 'pp'
			ELSE 'MIX_ELSE'
			END AS PROFILE;
%IF %str(&state.) = GA %THEN /*GEORGIA*/
	,CASE 	WHEN NONOWNER = 1 THEN 'NO'
			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0 THEN 'FULL_COV' 			
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND MedPayPremium_COV_IND02 = 0 AND UninsBIPremium_COV_IND02 = 0 THEN 'FULL_COV'

			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND MedPayPremium_COV_IND02 = 0 AND UninsBIPremium_COV_IND02 = 0 THEN 'MIXED_FC_LO'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND MedPayPremium_COV_IND02 = 0 AND UninsBIPremium_COV_IND02 = 0 THEN 'MIXED_FC_LO'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 1 AND UninsBIPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1 AND MedPayPremium_COV_IND02 = 0 AND UninsBIPremium_COV_IND02 = 0 THEN 'MIXED_FC_ML'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND MedPayPremium_COV_IND02 = 1 AND UninsBIPremium_COV_IND02 = 1 THEN 'MIXED_FC_ML'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 1 AND UninsBIPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND MedPayPremium_COV_IND02 = 0 AND UninsBIPremium_COV_IND02 = 0 THEN 'MIXED_ML_LO'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND MedPayPremium_COV_IND02 = 1 AND UninsBIPremium_COV_IND02 = 1 THEN 'MIXED_ML_LO'


			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 1 AND UninsBIPremium_COV_IND01 = 1 THEN 'ML' 			
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 1 AND UninsBIPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND MedPayPremium_COV_IND02 = 1 AND UninsBIPremium_COV_IND02 = 1 THEN 'ML'

			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0 THEN 'LO' 			
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0 AND MedPayPremium_COV_IND01 = 0 AND UninsBIPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0 AND MedPayPremium_COV_IND02 = 0 AND UninsBIPremium_COV_IND02 = 0 THEN 'LO'
			ELSE 'MIX_ELSE'
		END AS PROFILE;
%IF %str(&state.) NE GA AND %str(&state.) NE FL %THEN
	,CASE	WHEN NONOWNER = 1 THEN 'NO'
			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1  THEN 'FULL_COV' 			
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1  THEN 'FULL_COV'

			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 1 AND CompPremium_COV_IND01 = 1
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0  THEN 'MIXED'
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 1 AND CompPremium_COV_IND02 = 1  THEN 'MIXED'

			WHEN VEH_CNT = 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0  THEN 'LO' 			
			WHEN VEH_CNT > 1 AND LiabBIPremium_COV_IND01 = 1 AND LiabPDPremium_COV_IND01 = 1 AND CollPremium_COV_IND01 = 0 AND CompPremium_COV_IND01 = 0
							 AND LiabBIPremium_COV_IND02 = 1 AND LiabPDPremium_COV_IND02 = 1 AND CollPremium_COV_IND02 = 0 AND CompPremium_COV_IND02 = 0  THEN 'LO'
			ELSE 'MIXED'
		END AS PROFILE;


	,CASE	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 0 THEN 'WIN'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 31 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >=1  THEN '1_30'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 60 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >=31 THEN '31_60'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 90 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >= 61 THEN '61_90'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 120 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >= 91 THEN '91_120'
		  	ELSE 'GE_121'
			END AS LABEL 
	,SUM(TotalPremium_Term_Adj) AS TotalPremium_Term_Adj
	,SUM(Median_TotalPremium_Term_Adj) as Median_TotalPremium_Term_Adj
	,SUM(TotalPremium_Term_Adj01) as TotalPremium_Term_Adj01
	,SUM(TOTALPREMIUM_TERM_ADJ - TOTALPREMIUM_TERM_ADJ01) AS DOLLDIFF
	,SUM(CASE WHEN COMPANY_NAME02 = COMPANY_NAME_PROGRAM THEN 1 ELSE 0 END) AS RANK2_WIN
	,SUM(QUOTE) as QuoteCNT
	,SUM(Won) as Wins
	from Full.&state._&itc_str_dt._&itc_end_dt._full

	group by state,Company_name_program,Date_Data,Risk_Area,P_LVL_TOT,Profile,LABEL,Int_Dom_Mix
	order by state,Company_name_program,Date_Data,Risk_Area,P_LVL_TOT,Profile,LABEL,Int_Dom_Mix
;quit;


proc sql;
/*create table mark.MB_AGG_&state. as*/
insert into mark.MB_AGG_&state.
select
	 State as State
	,Company_name_program as CompanyName_Program 
	,Date_Data as Date_Data
	,Risk_Area as Risk_Area
	,P_LVL_TOT as P_Level
	,PROFILE as PROFILE
	,Int_Dom_Mix as Intl_Dom
	,Label as Label
	,Wins as WINS
	,DOLLDIFF AS DOLDIFF
	,QuoteCNT as QuoteCNT
	,RANK2_WIN as RANK2WIN
	,TotalPremium_Term_Adj as TotalPremTermAdj
	,TotalPremium_Term_Adj01 as TotalPremTermAdj01
	,Median_TotalPremium_Term_Adj as MedianTotalPremTermAdj
	
from work.&state._&itc_str_Dt._AGG

;quit;

%MEND;

/*%MB_PBI(state = AL, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = AR, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = AZ, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = FL, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = GA, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = IL, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = IN, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = MO, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
%MB_PBI(state = MS, itc_str_Dt = 20220701, itc_end_dt = 20220731);
/*%MB_PBI(state = NM, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = OK, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = OR, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = SC, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = TN, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = TX, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = VA, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = WI, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/


/*%MB_PBI(state = OH, itc_str_Dt = 20220601, itc_end_dt = 20220630);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20220501, itc_end_dt = 20220531);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20220401, itc_end_dt = 20220430);*/


/*%MB_PBI(state = OH, itc_str_Dt = 20210601, itc_end_dt = 20210630);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20210501, itc_end_dt = 20210531);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20210401, itc_end_dt = 20210430);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20210301, itc_end_dt = 20210331);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20210201, itc_end_dt = 20210228);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20210101, itc_end_dt = 20210131);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20201201, itc_end_dt = 20201231);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20201101, itc_end_dt = 20201130);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20201001, itc_end_dt = 20201031);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200901, itc_end_dt = 20200930);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200801, itc_end_dt = 20200831);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200701, itc_end_dt = 20200731);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200601, itc_end_dt = 20200630);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200501, itc_end_dt = 20200531);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200401, itc_end_dt = 20200430);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200301, itc_end_dt = 20200331);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200201, itc_end_dt = 20200228);*/
/*%MB_PBI(state = OH, itc_str_Dt = 20200101, itc_end_dt = 20200131);*/

/*%MB_PBI(state = AL, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = FL, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = GA, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = OH, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = IN, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = IL, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = SC, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = TX, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/
/*%MB_PBI(state = WI, itc_str_Dt = &BEG_DATE., itc_end_dt = &END_DATE.);*/



