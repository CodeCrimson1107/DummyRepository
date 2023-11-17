OPTIONS MLOGIC MPRINT SYMBOLGEN;
LIBNAME MARK ODBC READ_ISOLATION_LEVEL = RU SCHEMA=DBO
DBCOMMIT=100000 INSERTBUFF=10000 BULKLOAD=YES CONNECTION=SHARED
DBMAX_TEXT=32767 /* PREVENT TEXT COLUMN TRUNCATION */
REQUIRED=
"DRIVER=SQL SERVER;
DATABASE=MARKETING;
SERVER=DALDBCP06\REPORTING;";

LIBNAME Full "W:\Product\ITC_MarketBasket\DATA\FULL_DATA";
LIBNAME Test "W:\Product\Cardell\Market_Basket";

%let state_list = AL AR AZ GA KY MD MS NM OK SC VA WI ;

/*%let BEG_DATE = 20210201;*/
/*%let END_DATE = 20210228;*/

%MACRO MB_PBI();

/*nStates = number of strings in state_list, e.g. (SC GA) = 2*/
%let nStates = %sysfunc(countw(&state_list));
/*Loop from1 to nStates*/
%do i=1 %to &nStates;
/*Let the state equal to the ith position string in the string list*/
%LET state = %scan(&state_list.,&i);

proc sql;
create table work.&state._&itc_str_Dt._AGG as 
	select
	 "&state" as State
	,Company_name_program
	,&itc_str_dt. as Date_Data
	,Risk_Area
	,P_LVL_TOT
	,GCQuoted
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
	,sum(GCQuoted) as GCQuoted_CNT
	,SUM(Won) as Wins
	
	from Full.&state._&itc_str_dt._&itc_end_dt._full
/*	from Full.&state._&itc_str_dt._&itc_end_dt._full_test*/

	group by state,Company_name_program,Date_Data,Risk_Area,P_LVL_TOT,Profile,LABEL,Int_Dom_Mix,GCQuoted
	order by state,Company_name_program,Date_Data,Risk_Area,P_LVL_TOT,Profile,LABEL,Int_Dom_Mix,GCQuoted
;quit;

/*AGGTEST has 4+ competitors*/
/*AGG_COMP has 2+ competitors*/

proc sql;
/*create table mark.MB_AGG_&state._NEW as*/
insert into mark.MB_AGG_&state._NEW 
select
	 State as State
	,Company_name_program as CompanyName_Program 
	,Date_Data as Date_Data
	,Risk_Area as Risk_Area
	,P_LVL_TOT as P_Level
	,GCQuoted
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
	,GCQuoted_CNT
	
from work.&state._&itc_str_Dt._AGG

;quit;
%END;
%MEND;

%let itc_str_dt = 20230901;
%let itc_end_dt = 20230930;
%MB_PBI();
/*%let itc_str_dt = 20220601;*/
/*%let itc_end_dt = 20220630;*/
/*%MB_PBI();*/
/*%let itc_str_dt = 20220501;*/
/*%let itc_end_dt = 20220531;*/
/*%MB_PBI();*/
