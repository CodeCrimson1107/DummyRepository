LIBNAME MARK ODBC READ_ISOLATION_LEVEL = RU SCHEMA=DBO
DBCOMMIT=100000 INSERTBUFF=10000 BULKLOAD=YES CONNECTION=SHARED
DBMAX_TEXT=32767 /* PREVENT TEXT COLUMN TRUNCATION */
REQUIRED=
"DRIVER=SQL SERVER;
DATABASE=MARKETING;
SERVER=DALDBCP06\REPORTING;";

LIBNAME Full "W:\Product\Schwartz_Jonah\ITC_MB\DATA\FULL_TABLES";
LIBNAME Output "W:\Product\Schwartz_Jonah\ITC_MB\ITC_OUTPUTS";
LIBNAME Test "W:\Product\Cardell\Market_Basket";


/*%let month_str_3 = 20210501;*/
/*%let month_end_3 = 20210531;*/
/*%let month_str_2 = 20210301;*/
/*%let month_end_2 = 20210331;*/
/*%let month_str_1 = 20210401;*/
/*%let month_end_1 = 20210430;*/

/*%let month_add_str = 20220401;*/
/*%let month_add_end = 20220430;*/
%let state_list = SC;

%MACRO MB_FULL();

proc sql;
create table work.&state_list._Test as
select *,&month_add_str. as YYYYMM
from full.&state_list._&month_add_str._&month_add_end._full
%IF %str(&state) = TX %THEN where companyid in (126226343, 126227627);
/*select *,&month_str_1. as YYYYMM*/
/*from full.&state_list._&month_str_1._&month_end_1._full*/
/*%IF &state_list. = TX %THEN where companyid in (126226343, 126227627);*/
/*UNION ALL*/
/*select *,&month_str_2. as YYYYMM*/
/*from full.&state_list._&month_str_2._&month_end_2._full*/
/*UNION ALL*/
/*select *,&month_str_3. as YYYYMM*/
/*from full.&state_list._&month_str_3._&month_end_3._full*/
;quit;

/*proc sql;*/
/*delete from mark.MB_FULL_&state_list.*/
/*where YYYYMM = &month_removed*/
/*;quit;*/
/*proc sql;*/
/*create table work.&state_list._Full as */
/*select **/
/*,TotalPremium_Term_Adj - TotalPremium_Term_Adj01 as PRICE_DIFFERENCE01*/
/*,CASE 	WHEN NONOWNER = 1 THEN 'NO'*/
/*		WHEN LIABBIPREMIUM > 0 AND LIABPDPREMIUM > 0 AND COLLPREMIUM > 0 AND COMPPREMIUM > 0 THEN 'FULL_COV'*/
/*		WHEN LIABBIPREMIUM > 0 AND LIABPDPREMIUM > 0 THEN 'LO'*/
/*		ELSE 'MIXED'			*/
/*		END AS PROFILE*/
/*,CASE	WHEN InternatDL_Cnt = Num_Drivers THEN "All_International"*/
/*		WHEN InternatDL_Cnt = 0 THEN "All_Domestic"*/
/*		WHEN InternatDL01 = 0 AND InternatDL_Cnt > 0  THEN "Mixed_DomNI"*/
/*		WHEN InternatDL01 = 1 AND InternatDL_Cnt < Num_Drivers THEN "Mixed_IntNI"*/
/*		ELSE "Mixed"*/
/*		END AS Int_Dom_Mix*/
/*from &state_Test*/

proc sql;
/*CREATE TABLE mark.MB_FULL_&state_list. AS */
INSERT INTO mark.MB_FULL_&state_list._NEW
select *
,TotalPremium_Term_Adj - TotalPremium_Term_Adj01 as PRICE_DIFFERENCE
%IF %str(&state) = FL %THEN /* FLORIDA */
,	CASE	WHEN NONOWNER = 1 THEN 'NO'
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
%IF %str(&state) = GA %THEN /*GEORGIA*/
,	CASE 	WHEN NONOWNER = 1 THEN 'NO'
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
%IF %str(&state) NE GA AND %str(&state) NE FL %THEN
,	CASE	WHEN NONOWNER = 1 THEN 'NO'
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
,CASE		WHEN InternatDL_Cnt = Num_Drivers THEN "All_International"
			WHEN InternatDL_Cnt = 0 THEN "All_Domestic"
			WHEN InternatDL01 = 0 AND InternatDL_Cnt > 0  THEN "Mixed_DomInt"
			WHEN InternatDL01 = 1 AND InternatDL_Cnt < Num_Drivers THEN "Mixed_IntDOM"
			ELSE "Mixed"
			END AS Int_Dom_Mix
,CASE		WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 0 THEN 'WIN'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 31 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >=1  THEN '1_30'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 60 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >=31 THEN '31_60'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 90 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >= 61 THEN '61_90'
		  	WHEN TotalPremium_Term_Adj - TotalPremium_Term_Adj01 <= 120 AND TotalPremium_Term_Adj - TotalPremium_Term_Adj01 >= 91 THEN '91_120'
		  	ELSE 'GE_121'
			END AS LABEL 
 
from work.&state_list._Test
;quit;

%MEND;

%let month_add_str = 20220701;
%let month_add_end = 20220731;
%MB_FULL();
/*%MB_FULL(AR,20220501,20220531);*/
/*%MB_FULL(AR,20220401,20220430);*/
/*%MB_FULL(AR,20220301,20220331);*/
/*%MB_FULL(AR,20220201,20220228);*/
/*%MB_FULL(AR,20220101,20220131);*/
/*%MB_FULL(AR,20211201,20211231);*/
/*%MB_FULL(AR,20211101,20211130);*/
/*%MB_FULL(AR,20211001,20211031);*/
/*%MB_FULL(AL,20220601,20220630);*/
/*%MB_FULL(AR,20220601,20220630);*/
/*%MB_FULL(AZ,20220601,20220630);*/
/*%MB_FULL(FL,20220601,20220630);*/
/*%MB_FULL(GA,20220601,20220630);*/
/*%MB_FULL(IL,20220601,20220630);*/
/*%MB_FULL(IN,20220601,20220630);*/
/*%MB_FULL(IL,20220601,20220630);*/
/*%MB_FULL(MO,20220601,20220630);*/
/*%MB_FULL(MS,20220601,20220630);*/
/*%MB_FULL(OH,20220601,20220630);*/
/*%MB_FULL(OR,20220601,20220630);*/
/*%MB_FULL(SC,20220601,20220630);*/
/*%MB_FULL(TN,20220601,20220630);*/
/*%MB_FULL(TX,20220601,20220630);*/
/*%MB_FULL(VA,20220601,20220630);*/
/*%MB_FULL(WI,20220601,20220630);*/
/*%MB_FULL(OH,20210801,20210831);*/
/*%MB_FULL(OH,20210701,20210731);*/
/*%MB_FULL(OH,20210601,20210630);*/
/*%MB_FULL(AR);*/
/*%MB_FULL(AZ);*/
/*%MB_FULL(FL);*/
/*%MB_FULL(GA);*/
/*%MB_FULL(IN);*/
/*%MB_FULL(IL);*/
/*%MB_FULL(MO);*/
/*%MB_FULL(MS);*/
/*%MB_FULL(NM);*/
/*%MB_FULL(OH);*/
/*%MB_FULL(OK);*/
/*%MB_FULL(OR);*/
/*%MB_FULL(SC);*/
/*%MB_FULL(TN);*/
/*%MB_FULL(TX);*/
/*%MB_FULL(VA);*/
/*%MB_FULL(WI);*/

