%MACRO VALID_DATE_TEST();
/*Test to make sure your date is good and will break the macro if it isn't*/
%let st_dt_test = %sysfunc(MDY(	(%sysfunc(substr(&itc_str_dt.,5,2))),
								(%sysfunc(substr(&itc_str_dt.,7,2))),
								(%sysfunc(substr(&itc_str_dt.,1,4)))));
%let ed_dt_test = %sysfunc(MDY(	(%sysfunc(substr(&itc_end_dt.,5,2))),
								(%sysfunc(substr(&itc_end_dt.,7,2))),
								(%sysfunc(substr(&itc_end_dt.,1,4)))));

%IF &st_dt_test. = . %then %do; %put ERROR: BAD DATE; %return; %end;
%IF &ed_dt_test. = . %then %do; %put ERROR: BAD DATE; %return; %end;
%MEND VALID_DATE_TEST();
%VALID_DATE_TEST();
