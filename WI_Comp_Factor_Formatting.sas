

PROC IMPORT 
OUT=WORK.Terr_Compare
/*DATAFILE="W:\Product\Pennsylvania\Competitor Intel\BW_Factors\BW_Factors.xlsx"*/
/*DATAFILE="W:\Product\Pennsylvania\Competitor Intel\Kemper_Factors\KEMPER_PA_FACTORS.xlsx"*/
/*DATAFILE="W:\Product\Pennsylvania\Competitor Intel\General_Factors\Copy of GENERAL_FACTORS.xlsx"*/
DATAFILE="W:Product\Cardell\Wisconsin\GC_DL_Territory.xlsx"
DBMS=EXCEL REPLACE;
RANGE="GC_DL_Compare$";
GETNAMES=YES;

proc transpose data=work.Terr_Compare out=work.Compare_Terr(rename=(_NAME_=Profile COL1=Factor));
    var "ABI"n--"UIB"n;
    by Zipcode	P_Level	Risk_Area	City 
;
run;

proc export data=work.Compare_Terr
/*    outfile="W:\Product\Pennsylvania\Competitor Intel\Kemper_Factors\KP_POINTS.csv"*/
	outfile="W:Product\Wisconsin\Competitors\Factor Research\Dairyland\GC_DL_Terr_Tibble.csv"
/*	outfile="W:\Product\Pennsylvania\Competitor Intel\General_Factors\GEN_POINTS"*/
	dbms=csv replace;
run;
