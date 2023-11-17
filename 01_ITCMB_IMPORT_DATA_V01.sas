/*%let ITC_EXT = \\DALGRP01\RiskManagementGrpshare\Product\ITC_MarketBasket\DATA\EXTRACTS\;*/
/*%let itc_str_dt = 20220401;*/
/*%let itc_end_dt = 20220430;*/
/*%let filepath_str_dt = */
/*%sysfunc(CATS(*/
/*%sysevalf(%sysfunc(substr(&itc_str_dt.,5,2))*1),-,*/
/*%sysevalf(%sysfunc(substr(&itc_str_dt.,7,2))*1),-,*/
/*%sysevalf(%sysfunc(substr(&itc_str_dt.,1,4))*1)));*/
/*%let state = MO;*/
/*%let mid_ind = N;*/


%MACRO ITC_MB_IMPORT_DATA();

data work.&state._Policy01;
/*We only keep these variables because other variables are either bad data or not used.*/
keep RecordID Term;
%IF &mid_ind. = N %THEN	infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._Policy.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
%ELSE					infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._to_&filepath_end_dt._Policy.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
;
informat RecordID 				10.;format RecordID 				10. ;
informat ZipCode 				$7. ;format ZipCode 				$7. ;
informat Term 					10. ;format Term 					10. ;
informat CoTerm 				$3. ;format CoTerm 					$3. ;
informat EffectiveDate 			$25.;format EffectiveDate 			$25. ;
informat PolicyFee 				$9. ;format PolicyFee 				$9. ;
informat TotalPremium 			$11.;format TotalPremium 			$11. ;
informat DateCreated 			$25.;format DateCreated 			$25. ;
informat PriorEffDate 			$25.;format PriorEffDate 			$25. ;
informat PriorInAgency 			$3. ;format PriorInAgency 			$3. ;
informat NumOfPayments 			$3. ;format NumOfPayments			$3. ;
informat PercentDown 			$20.;format PercentDown 			$20. ;
informat NonOwner 				$3. ;format NonOwner 				$3. ;
informat SR22Fee 				$7. ;format SR22Fee 				$7. ;
informat InsuredDeclinedCredit 	$3. ;format InsuredDeclinedCredit 	$3. ;
informat DownPayment 			$10.;format DownPayment 			$10. ;
informat PaymentTotal 			$20.;format PaymentTotal 			$20. ;
informat FinanceAmount 			$11.;format FinanceAmount 			$11. ;
informat CompanyID 				$2. ;format CompanyID 				$2. ;
informat DateQuoted 			$25.;format DateQuoted 				$25. ;
informat QuoteAgencyZipCode 	$7. ;format QuoteAgencyZipCode 		$7. ;
informat AssumedCredit 			$3. ;format AssumedCredit 			$3. ;
informat Bound 					$3. ;format Bound 					$3. ;
informat BinderDate 			$25.;format BinderDate 				$25. ;
informat EmailEntered 			$3. ;format EmailEntered 			$3. ;
informat FRBond 				$3. ;format FRBond 					$3. ;
informat ExpirationDate 		$25.;format ExpirationDate 			$25. ;
informat Broadform 				$3. ;format Broadform 				$3. ;
input
RecordID 
ZipCode $
Term 
CoTerm $
EffectiveDate $
PolicyFee $
TotalPremium $
DateCreated $
PriorEffDate $
PriorInAgency $
NumOfPayments $
PercentDown $
NonOwner $
SR22Fee $
InsuredDeclinedCredit $
DownPayment $
PaymentTotal $
FinanceAmount $
CompanyID $
DateQuoted $
QuoteAgencyZipCode $
AssumedCredit $
Bound $
BinderDate $
EmailEntered $
FRBond $
ExpirationDate $
Broadform $
;
run;

data work.&state._Rate01 ;
%IF &mid_ind. = N %THEN	infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._Rate.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
%ELSE					infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._to_&filepath_end_dt._Rate.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
;
informat PolicyLinkID 				12. 		;format PolicyLinkID 				12. ;
informat RateId 					12. 		;format RateId 						12. ;
informat TotalPremium 				11.2 		;format TotalPremium 				11.2 ;
informat DownPayment 				10.2 		;format DownPayment 				10.2 ;
informat PaymentAmount 				10.2 		;format PaymentAmount 				10.2 ;
informat Term 						3. 			;format Term 						3. ;
informat Purchased 					3. 			;format Purchased 					3. ;
informat RatedDate 					ANYDTDTE32. ;format RatedDate 					DATE9. ;
informat CompanyId 					11. 		;format CompanyId 					11. ;
informat RateOption 				$3. 		;format RateOption 					$3. ;
informat IsCreditRequired 			3. 			;format IsCreditRequired 			3. ;
informat RateIteration 				3. 			;format RateIteration 				3. ;
informat PolicyFee 					9. 			;format PolicyFee 					9. ;
informat NumOfPayments 				3. 			;format NumOfPayments 				3. ;
informat PercentDown 				7.2 		;format PercentDown 				7.2 ;
informat PaymentTotal 				20.2 		;format PaymentTotal 				20.2 ;
informat FinanceAmount 				11.2 		;format FinanceAmount 				11.2 ;
informat ThirdPartyId 				$96. 		;format ThirdPartyId 				$96. ;
informat Tier 						$3. 		;format Tier 						$3. ;
informat Program 					$3. 		;format Program 					$3. ;
informat CompanyData1 				$3. 		;format CompanyData1 				$3. ;
informat CompanyData2 				$3. 		;format CompanyData2 				$3. ;
informat CompanyData3 				$3. 		;format CompanyData3 				$3. ;
informat PerPaymentInstallmentFee 	9. 			;format PerPaymentInstallmentFee 	9. ;
informat TotalInstallmentFee 		9. 			;format TotalInstallmentFee 		9. ;
informat ZipCode 					7. 			;format ZipCode 					7. ;
informat EnteredTerm 				$3. 		;format EnteredTerm 				$3. ;
informat EffectiveDate 				ANYDTDTE32. ;format EffectiveDate 				DATE9. ;
informat DateCreated 				ANYDTDTE32. ;format DateCreated 				DATE9. ;
informat PriorEffDate 				ANYDTDTE32. ;format PriorEffDate 				DATE9. ;
informat PriorInAgency 				3. 			;format PriorInAgency 				3. ;
informat NonOwner 					3. 			;format NonOwner 					3. ;
informat InsuredDeclinedCredit 		3. 			;format InsuredDeclinedCredit 		3. ;
informat DateQuoted 				ANYDTDTE32. ;format DateQuoted 					DATE9. ;
informat QuoteAgencyZipCode 		10. 		;format QuoteAgencyZipCode 			10. ;
informat AssumedCredit 				$3. 		;format AssumedCredit 				$3. ;
informat Bound 						3. 			;format Bound 						3. ;
informat BinderDate 				ANYDTDTE32. ;format BinderDate 					DATE9. ;
informat SR22Fee 					7. 			;format SR22Fee 					7. ;
informat ATPAFee 					7. 			;format ATPAFee 					7. ;
informat FR44Fee 					7. 			;format FR44Fee 					7. ;
informat FRBond 					3. 			;format FRBond 						3. ;
informat ExpirationDate 			ANYDTDTE32. ;format ExpirationDate 				DATE9. ;
informat Broadform 					3. 			;format Broadform 					3. ;
input
PolicyLinkID
RateId 
TotalPremium 
DownPayment 
PaymentAmount 
Term 
Purchased 
RatedDate 
CompanyId 
RateOption 
IsCreditRequired 
RateIteration 
PolicyFee 
NumOfPayments 
PercentDown 
PaymentTotal 
FinanceAmount 
ThirdPartyId 
Tier 
Program 
CompanyData1 
CompanyData2 
CompanyData3 
PerPaymentInstallmentFee 
TotalInstallmentFee 
ZipCode 
EnteredTerm 
EffectiveDate 
DateCreated 
PriorEffDate 
PriorInAgency 
NonOwner 
InsuredDeclinedCredit 
DateQuoted 
QuoteAgencyZipCode 
AssumedCredit 
Bound 
BinderDate 
SR22Fee 
ATPAFee 
FR44Fee 
FRBond 
ExpirationDate 
Broadform 
;
run;

data work.&state._Rate_Car01 ;
%IF &mid_ind. = N %THEN	infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._Rate_Car.txt" delimiter=',' MISSOVER DSD firstobs=2;
%ELSE					infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._to_&filepath_end_dt._Rate_Car.txt" delimiter=',' MISSOVER DSD firstobs=2;
;
informat RateLinkID 			12. ;format RateLinkID 		12. ;
informat RateVehicleId 			12. ;format RateVehicleId 	12. ;
informat CoSym 					$3. ;format CoSym 			$3. ;
informat CoTerr 				$7. ;format CoTerr 			$7. ;
informat LiabBIPremium 			8. 	;format LiabBIPremium 	8. ;
informat LiabPDPremium 			7. 	;format LiabPDPremium 	7. ;
informat MedPayPremium 			7. 	;format MedPayPremium 	7. ;
informat PIPPremium 			5. 	;format PIPPremium 		5. ;
informat RentalPremium 			6. 	;format RentalPremium 	6. ;
informat TowingPremium 			5. 	;format TowingPremium 	5. ;
informat UIMBIPremium 			5. 	;format UIMBIPremium 	5. ;
informat UIMPDPremium 			5. 	;format UIMPDPremium 	5. ;
informat UninsBIPremium 		7. 	;format UninsBIPremium 	7. ;
informat UninsPDPremium 		7. 	;format UninsPDPremium 	7. ;
informat CoLiabLimits1 			7. 	;format CoLiabLimits1 	7. ;
informat CoLiabLimits2 			8. 	;format CoLiabLimits2 	8. ;
informat CoLiabLimits3 			7. 	;format CoLiabLimits3 	7. ;
informat CoCollDed 				5. 	;format CoCollDed 		5. ;
informat CoCompDed 				5. 	;format CoCompDed 		5. ;
informat CoPIPLimit 			4. 	;format CoPIPLimit 		4. ;
informat CoMedPayLimit 			6. 	;format CoMedPayLimit 	6. ;
informat CoUIMBILimits1 		4. 	;format CoUIMBILimits1	4. ;
informat CoUIMBILimits2 		4. 	;format CoUIMBILimits2 	4. ;
informat CoTowingLimit 			12. ;format CoTowingLimit 	12. ;
informat CoUIMPDLimit 			4. 	;format CoUIMPDLimit 	4. ;
informat CoUninsBILimits1 		7. 	;format CoUninsBILimits1 	7. ;
informat CoUninsBILimits2 		8. 	;format CoUninsBILimits2 	8. ;
informat CoUninsPDLimit 		7. 	;format CoUninsPDLimit 		7. ;
informat CoRentalLimit 			4. 	;format CoRentalLimit 		4. ;
informat CoUninsPDDed 			5. 	;format CoUninsPDDed 		5. ;
informat CompPremium 			7. 	;format CompPremium 		7. ;
informat CollPremium 			7. 	;format CollPremium 		7. ;
informat IncludedCoverages 		4. 	;format IncludedCoverages 	4. ;
informat VIN 					$12.;format VIN 				$12. ;
informat ACV 					8. 	;format ACV 				8. ;
informat AnnualMiles 			9. 	;format AnnualMiles 		9. ;
informat CollDed 				5. 	;format CollDed 			5. ;
informat CompDed 				5. 	;format CompDed 			5. ;
informat County 				$10.;format County 				$10. ;
informat MedPayLimit 			6. 	;format MedPayLimit 		6. ;
informat Miles 					10. ;format Miles 				10. ;
informat Odometer 				10. ;format Odometer 			10. ;
informat PercentToWork 			5. 	;format PercentToWork		5. ;
informat PIPLimit 				6. 	;format PIPLimit	 		6. ;
informat RentalLimit 			5. 	;format RentalLimit 		5. ;
informat TowingLimit 			5. 	;format TowingLimit 		5. ;
informat UIMPDLimit 			5. 	;format UIMPDLimit 			5. ;
informat UninsPDLimit 			5. 	;format UninsPDLimit 		5. ;
informat Usage 					$3. ;format Usage 				$3. ;
informat ZipCode 				7. 	;format ZipCode 			7. ;
informat Garaged 				3. 	;format Garaged 			3. ;
informat GaragingZipCode 		7. 	;format GaragingZipCode	 	7. ;
informat LeasedVehicle 			3. 	;format LeasedVehicle 		3. ;
informat LiabLimits1 			6. 	;format LiabLimits1 		6. ;
informat LiabLimits2 			6. 	;format LiabLimits2 		6. ;
informat LiabLimits3 			6. 	;format LiabLimits3 		6. ;
informat UninsBILimits1 		6. 	;format UninsBILimits1 		6. ;
informat UninsBILimits2 		6. 	;format UninsBILimits2 		6. ;
informat UIMBILimits1 			6. 	;format UIMBILimits1 		6. ;
informat UIMBILimits2 			6. 	;format UIMBILimits2 		6. ;
informat PrimaryOperator 		3. 	;format PrimaryOperator 	3. ;
informat Year 					6. 	;format Year 				6. ;
informat Maker 					$9. ;format Maker 				$9. ;
informat Model 					$11.;format Model 				$11. ;
informat CoAccDeathLimit 		6. 	;format CoAccDeathLimit 	6. ;
informat CoCustomEquipLimit 	3. 	;format CoCustomEquipLimit 	3. ;
informat CoExtraMedLimit 		4. 	;format CoExtraMedLimit 	4. ;
informat CoSafetyGlass 			3. 	;format CoSafetyGlass 		3. ;
informat CoGapCoverage 			3. 	;format CoGapCoverage 		3. ;
informat CoIncomeLossLimit 		4. 	;format CoIncomeLossLimit 	4. ;
informat CoIncomeLossLimit2 	4. 	;format CoIncomeLossLimit2 	4. ;
informat CoLegalExpense 		3. 	;format CoLegalExpense 		3. ;
informat AccDeathPremium 		5. 	;format AccDeathPremium 	5. ;
informat CustomEquipPremium 	5. 	;format CustomEquipPremium 	5. ;
informat ExtraMedPremium 		5. 	;format ExtraMedPremium 	5. ;
informat SafetyGlassPremium 	5. 	;format SafetyGlassPremium 	5. ;
informat GapPremium 			5. 	;format GapPremium 			5. ;
informat IncomeLossPremium 		5. 	;format IncomeLossPremium 	5. ;
informat LegalExpensePremium 	5. 	;format LegalExpensePremium 5. ;
informat AccDeathLimit 			6. 	;format AccDeathLimit 		6. ;
informat CustomEquipLimit 		3. 	;format CustomEquipLimit 	3. ;
informat ExtraMedLimit 			4. 	;format ExtraMedLimit 		4. ;
informat SafetyGlass 			3. 	;format SafetyGlass 		3. ;
informat GapCoverage 			3. 	;format GapCoverage 		3. ;
informat IncomeLossLimit 		4. 	;format IncomeLossLimit 	4. ;
informat IncomeLossLimit2 		4. 	;format IncomeLossLimit2 	4. ;
informat LegalExpense 			3. 	;format LegalExpense 		3. ;
input
RateLinkID 
RateVehicleId 
CoSym $
CoTerr 
LiabBIPremium 
LiabPDPremium 
MedPayPremium 
PIPPremium 
RentalPremium 
TowingPremium 
UIMBIPremium 
UIMPDPremium 
UninsBIPremium 
UninsPDPremium 
CoLiabLimits1 
CoLiabLimits2 
CoLiabLimits3 
CoCollDed 
CoCompDed 
CoPIPLimit 
CoMedPayLimit 
CoUIMBILimits1 
CoUIMBILimits2 
CoTowingLimit $
CoUIMPDLimit 
CoUninsBILimits1 
CoUninsBILimits2 
CoUninsPDLimit 
CoRentalLimit 
CoUninsPDDed 
CompPremium 
CollPremium 
IncludedCoverages 
VIN $
ACV 
AnnualMiles 
CollDed 
CompDed 
County $
MedPayLimit 
Miles 
Odometer 
PercentToWork 
PIPLimit 
RentalLimit 
TowingLimit 
UIMPDLimit 
UninsPDLimit 
Usage $
ZipCode 
Garaged 
GaragingZipCode 
LeasedVehicle 
LiabLimits1 
LiabLimits2 
LiabLimits3 
UninsBILimits1 
UninsBILimits2 
UIMBILimits1 
UIMBILimits2 
PrimaryOperator 
Year 
Maker $
Model $
CoAccDeathLimit 
CoCustomEquipLimit 
CoExtraMedLimit 
CoSafetyGlass 
CoGapCoverage 
CoIncomeLossLimit 
CoIncomeLossLimit2 
CoLegalExpense 
AccDeathPremium 
CustomEquipPremium 
ExtraMedPremium 
SafetyGlassPremium 
GapPremium 
IncomeLossPremium 
LegalExpensePremium 
AccDeathLimit 
CustomEquipLimit 
ExtraMedLimit 
SafetyGlass 
GapCoverage 
IncomeLossLimit 
IncomeLossLimit2 
LegalExpense 
;
run;

data work.&state._Rate_Driver01 ;
%IF &mid_ind. = N %THEN	infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._Rate_Driver.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
%ELSE			infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._to_&filepath_end_dt._Rate_Driver.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
;
informat RateLinkID 		12.			;format RateLinkID 			12. ;
informat RateDriverId 		12.			;format RateDriverId 		12. ;
informat ZipCode 			7. 			;format ZipCode 			7. ;
informat DOB 				ANYDTDTE32.	;format DOB 				DATE9. ;
informat Age 				4. 			;format Age 				4. ;
informat Employed 			$3.			;format Employed 			$3. ;
informat EmployedDate 		ANYDTDTE32.	;format EmployedDate 		DATE9. ;
informat Excluded 			3. 			;format Excluded 			3. ;
informat InternatDL 		3. 			;format InternatDL 			3. ;
informat Licensed 			3. 			;format Licensed 			3. ;
informat Marital			$3.			;format Marital 			$3. ;
informat MilesToWork 		3. 			;format MilesToWork 		3. ;
informat MonthsLicensed 	5. 			;format MonthsLicensed 		5. ;
informat PriorDaysLapse 	5. 			;format PriorDaysLapse 		5. ;
informat PriorInsurance 	3. 			;format PriorInsurance 		3. ;
informat PriorMonthsCovg	4. 			;format PriorMonthsCovg 	4. ;
informat Relation 			$3.			;format Relation 			$3. ;
informat ResidencyStatus 	$3.			;format ResidencyStatus 	$3. ;
informat ResidencyType 		$3.			;format ResidencyType 		$3. ;
informat ResideTime 		4. 			;format ResideTime 			4. ;
informat Sex 				$3.			;format Sex 				$3. ;
informat SR22 				3. 			;format SR22 				3. ;
informat StateLicensed 		$4.			;format StateLicensed 		$4. ;
informat SuspendedLic 		3. 			;format SuspendedLic 		3. ;
informat EmailAddress 		3. 			;format EmailAddress 		3. ;
informat PriorCarrierId 	13.			;format PriorCarrierId 		13. ;
informat PriorLiabLimits1 	4. 			;format PriorLiabLimits1	4. ;
informat PriorLiabLimits2 	4. 			;format PriorLiabLimits2 	4. ;
informat PriorLiabLimits3 	4. 			;format PriorLiabLimits3 	4. ;
informat IndustryId 		$4.			;format IndustryId 			$4. ;
informat OccupationId 		$5.			;format OccupationId 		$5. ;
informat PrimaryCar 		3. 			;format PrimaryCar 			3. ;
informat DriverClass 		2. 			;format DriverClass 		2. ;
informat Points 			2. 			;format Points 				2. ;
informat EducationLevel 	$3.			;format EducationLevel 		$3. ;
informat TVDL 				3. 			;format TVDL 				3. ;
input
RateLinkID 
RateDriverId 
ZipCode 
DOB 
Age 
Employed $
EmployedDate 
Excluded 
InternatDL 
Licensed 
Marital $
MilesToWork 
MonthsLicensed 
PriorDaysLapse 
PriorInsurance 
PriorMonthsCovg 
Relation $
ResidencyStatus $
ResidencyType $
ResideTime 
Sex $
SR22 
StateLicensed $
SuspendedLic 
EmailAddress 
PriorCarrierId 
PriorLiabLimits1 
PriorLiabLimits2 
PriorLiabLimits3 
IndustryId $
OccupationId $
PrimaryCar 
DriverClass 
Points 
EducationLevel $
TVDL 
;
run;

data work.&state._Rate_Violation01 ;
%IF &mid_ind. = N %THEN	infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._Rate_Violation.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
%ELSE			infile "&ITC_EXT.Quoted_&state._&filepath_str_dt._to_&filepath_end_dt._Rate_Violation.txt" delimiter = ',' MISSOVER DSD firstobs=2 ;
;
informat RateViolationId 	11. 		;format RateViolationId 	11. ;
informat RateDriverLinkId 	12. 		;format RateDriverLinkId 	12. ;
informat AtFault 			3.	 		;format AtFault 			3. ;
informat Convicted 			3.	 		;format Convicted 			3. ;
informat ViolCode 			4.		 	;format ViolCode 			4. ;
informat ViolDate 			ANYDTDTE32.	;format ViolDate 		DATE9. ;
input
RateViolationId 
RateDriverLinkId 
AtFault 
Convicted 
ViolCode 
ViolDate 
;
run;

/**/
/*PROC IMPORT */
/*	DATAFILE= "W:\Product\Schwartz_Jonah\ITC_MB\Territory_Key.xlsx" OUT=work.ZipMap*/
/*	DBMS=xlsx REPLACE;*/
/*	SHEET = "ZipMap";*/
/*	GETNAMES=YES;*/
/*RUN;*/

PROC SQL;
CREATE TABLE WORK.ZipMap AS
SELECT
STATE
,ZIP AS ZIPCODE
,TERRITORY
,RISK_AREA
,CITY
,COUNTY
,P_LVL_TOT
,P_LVL_BI
,P_LVL_PD
,P_LVL_COL
,P_LVL_CMP AS P_LVL_COMP
,P_LVL_PIP
,A_LEVEL

FROM MARK.TERRKEY

GROUP BY 
STATE
,ZIPCODE
,TERRITORY
,RISK_AREA
,CITY
,COUNTY
,P_LVL_TOT
,P_LVL_BI
,P_LVL_PD
,P_LVL_COL
,P_LVL_CMP
,P_LVL_PIP
,A_LEVEL

;QUIT;

PROC IMPORT 
	DATAFILE= "W:\Product\ITC_MarketBasket\DATA\COMPETITOR_CODES\Competitor_Codes.xlsx" OUT=work.Competitor_Codes
	DBMS=xlsx REPLACE;
	SHEET = "Competitor_Codes";
	GETNAMES=YES;
RUN;

PROC IMPORT 
	DATAFILE= "W:\Product\Schwartz_Jonah\ITC_MB\DATA\Violation_Mapping_MB.xlsx" OUT=work.Points_Map
	DBMS=xlsx REPLACE;
	SHEET = "ViolationCodes";
	GETNAMES=YES;
RUN;

%MEND ITC_MB_IMPORT_DATA();

%ITC_MB_IMPORT_DATA();
