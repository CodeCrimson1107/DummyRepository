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


%MACRO MB_FULL(state,month_add_str,month_add_end);

PROC SQL;
/*update full.&state._&month_add_str._&month_add_end._full*/
/*set Risk_Area =  A.[RISK AREA]*/
/*from full.&state._&month_add_str._&month_add_end._full B join MARK.TerrKey A on A.ZIP = B.ZipCode*/

update full.&state._&month_add_str._&month_add_end._full as A
   set Risk_Area = (select Risk_Area from mark.terrkey as B
			where A.ZipCode = B.Zip)
		where A.ZipCode in (select ZIP from mark.terrkey);
;quit;

%MEND;
/*%MB_FULL(OH,20210601,20210630);*/
/*%MB_FULL(OH,20210501,20210531);*/
/*%MB_FULL(OH,20210401,20210430);*/
/*%MB_FULL(OH,20210301,20210331);*/
/*%MB_FULL(OH,20210201,20210228);*/
/*%MB_FULL(OH,20210101,20210131);*/
%MB_FULL(OH,20201201,20201231);
%MB_FULL(OH,20201101,20201130);
%MB_FULL(OH,20201001,20201031);
%MB_FULL(OH,20200901,20200930);
%MB_FULL(OH,20200801,20200831);
%MB_FULL(OH,20200701,20200731);
%MB_FULL(OH,20200601,20200630);
%MB_FULL(OH,20200501,20200531);
%MB_FULL(OH,20200401,20200430);
%MB_FULL(OH,20200301,20200331);
%MB_FULL(OH,20200201,20200228);
%MB_FULL(OH,20200101,20200131);
