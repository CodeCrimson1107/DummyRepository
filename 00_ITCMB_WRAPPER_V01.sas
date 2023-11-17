	
%put Process Timestamp: %sysfunc(time(),timeampm.) on %sysfunc(date(),worddate.).;
OPTIONS MPRINT MLOGIC SYMBOLGEN;
/*UPDATE THE 4 LET STATEMENT BELOW AND RUN*/
/*%let itc_str_dt = 20200101; /*Data Start Date: Takes a date of format YYYYMMDD e.g. 190901 which is September 1st, 2019*/
/*%let itc_end_dt = 20200131; /*Data End Date: Takes a date of format YYYYMMDD e.g. 190930 which is September 30th, 2019*/
%let mid_ind = N; /*Takes a value of Y or N indicating whether the ITC extracts were mid month e.g. not 1st to 30th/31st/28th. Impacts filepath naming if error*/
%let state_list = AL AR AZ GA KY MD MS NM OK SC VA WI; /*Takes a list of state abbreviations e.g. AL AR AZ GA IN IL MO MS NM OH OK OR SC TN VA WI*/
/******************************************************************************************************/
%MACRO WRAPPER();
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\VALID_DATE_TEST.sas';
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\ITCMB_LIBRARIES_AND_LOCATIONS.sas';
/*Creates filepath dates - transforms itc_str_dt by substringing and multiplying by 1 (remove leading 0s), e.g. 20190901 to 9-1-2019 or 2091015 to 10-15-2019*/
%let filepath_str_dt = 
%sysfunc(CATS(
%sysevalf(%sysfunc(substr(&itc_str_dt.,5,2))*1),-,
%sysevalf(%sysfunc(substr(&itc_str_dt.,7,2))*1),-,
%sysevalf(%sysfunc(substr(&itc_str_dt.,1,4))*1)));

%let filepath_end_dt = 
%sysfunc(CATS(
%sysevalf(%sysfunc(substr(&itc_end_dt.,5,2))*1),-,
%sysevalf(%sysfunc(substr(&itc_end_dt.,7,2))*1),-,
%sysevalf(%sysfunc(substr(&itc_end_dt.,1,4))*1)));

/*nStates = number of strings in state_list, e.g. (SC GA) = 2*/
%let nStates = %sysfunc(countw(&state_list));
/*Loop from1 to nStates*/
%do i=1 %to &nStates;
/*Let the state equal to the ith position string in the string list*/
%LET state = %scan(&state_list.,&i);

/*01 - IMPORT THE DATA*/
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\01_ITCMB_IMPORT_DATA_V01.sas'; 
/*01a - Map in VCP data*/
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\VCP_MAPPING.sas';
%VCP_MAPPING(
INPUT_DATA = work.&state._Rate_Car01
,OUTPUT_DATA = work.&state._Rate_Car02
,VIN_JOIN_VAR = VIN
,YEAR_JOIN_VAR = Year
,MAKE_JOIN_VAR =Maker
);
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\02_ITCMB_RANK_DATA.sas';
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\03_ITCMB_TRANSPOSING.sas';
%INCLUDE 'W:\Product\ITC_MarketBasket\PGM\04_ITCMB_FULL_JOIN.sas';

%END;
%MEND WRAPPER();
%let itc_str_dt = 20230901;
%let itc_end_dt = 20230930;
%WRAPPER();
/**/
/*%let itc_str_dt = 20220801;*/
/*%let itc_end_dt = 20220831;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220701;*/
/*%let itc_end_dt = 20220731;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220601;*/
/*%let itc_end_dt = 20220630;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220501;*/
/*%let itc_end_dt = 20220531;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220401;*/
/*%let itc_end_dt = 20220430;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220301;*/
/*%let itc_end_dt = 20220331;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220201;*/
/*%let itc_end_dt = 20220228;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20220101;*/
/*%let itc_end_dt = 20220131;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20211201;*/
/*%let itc_end_dt = 20211231;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20211101;*/
/*%let itc_end_dt = 20211130;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20211001;*/
/*%let itc_end_dt = 20211031;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20210901;*/
/*%let itc_end_dt = 20210930;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20210801;*/
/*%let itc_end_dt = 20210831;*/
/*%WRAPPER();*/
/*%let itc_str_dt = 20210701;*/
/*%let itc_end_dt = 20210731;*/
/*%WRAPPER();*/
