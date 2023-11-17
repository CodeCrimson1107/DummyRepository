use [Marketing]
go

declare @state as char(2)
set @state ='AL'

Select
	QuoteCNT
	,DR_MIX
	,CREDLVL
	,Company
	,TOTPREM
	,RISKAREA
	,P_LEVEL
	,RATE_YR
	,RATE_MO
	,[Profile]
	,COUNTY
	,VEHCNT
	,DRCNT
	,Won
	,TERM
	,STATE
	,RANK
	,RANK1CO
	,RANK2CO
	,RANK3CO
	,RANK4CO
	,RANK5CO
	,POP
	,LAPSE
	,HO
	,SR22
	,MAKER
	,MODEL
	,GENDER
	,ZIP
	,MODEL_YEAR
	,RANK1PR
	,RANK2PR
	,RANK3PR
	,RANK4PR
	,RANK5PR
	,DownPayment
	,PaymentAmount
	,Purchased
	,CompanyID
	,RateOption
	,IsCreditRequired
	,RateIteration
	,PolicyFee
	,NumofPayments
	,PercentDown
	,PaymentTotal
	,FinanceAmount
	,ThirdPartyID
	,Tier
	,Program
	,RatedDate
	,PerPaymentInstallmentFee
	,TotalInstallmentFee
	,EnteredTerm
	,EffectiveDate
	,DateCreated
	,PriorEffDate
	,PriorInAgency
	,NonOwner
	,InsuredDeclinedCredit
	,DateQuoted
	,QuoteAgencyZipCode
	,Bound
	,BinderDate
	,SR22Fee
	,ATPAFee
	,FR44Fee
	,FRBond
	,ExpirationDate
	,Broadform
	,RecordID
	,RateLinkID
	,RateVehicleId01
	,CoSym
	,CoTerr
	,LiabBIPremium
	,LiabPDPremium
	,MedPayPremium
	,PIPPremium
	,RentalPremium
	,TowingPremium
	,UIMBIPremium
	,UIMPDPremium
	,UninsBIPremium
	,UninsPDPremium
	,CoLiabLimits101
	,CoLiabLimits201
	,CoLiabLimits301
	,CoCollDed01
	,CoCompDed01
	,CoPIPLimit01
	,CoMedPayLimit01
	,CoUIMBILimits101
	,CoUIMBILimits201
	,CompPremium
	,CollPremium
	,VIN01
	,LiabLimits101
	,LiabLimits301
	,Maker01
	,Model01
	,Dr_Res_ZIP
	,Num_Drivers
	,Num_Excl_Drivers
	,RateDriverId01
	,Age01
	,Employed01
	,Excluded01
	,Licensed01
	,MonthsLicensed01
	,PriorMonthsCovg01
	,Relation01
	,ResidencyType01
	,StateLicensed01
	,SuspendedLic01
	,PriorCarrierId01
	,PriorLiabLimits101
	,PriorLiabLimits201
	,IndustryId01
	,OccupationId01
	,PrimaryCar01
	,EducationLevel01
	,TVDL01
	,RateDriverLinkId
	,Tot_Violation
	,Tot_AtFault
	,RateViolationId01
	,AtFault01
	,Tot_Convicted
	,Convicted01
	,ViolCode01
	,RANKING
	,Avg_TotalPremium
	,Median_TotalPremium
	,Max_TotalPremium
	,NumCompetitors
	,GCQUOTED
	,Co_Avg_TotalPremium
	,Co_Median_TotalPremium
	,Co_Max_TotalPremium
	,Co_NumCompetitors
	,Co_TotalPremium01
	,Co_TotalPremium02
	,Co_TotalPremium03
	,Co_TotalPremium04
	,Co_TotalPremium05
	,TERRITORY
	,P_LVL_BI
	,P_LVL_PD
	,P_LVL_COL
	,P_LVL_COMP
	,P_LVL_PIP
	,Company_Group
	,Last_Updated
	,TERM_FLAG
	,MAKE_NUMBER
	,MAKE_NAME
	,SERIES_NUMBER
	,SERIES_NAME
	,MODEL_NUMBER
	,MODEL_NAME
	,ENGINE_NAME
	,MIN_HORSE
	,MAX_HORSE
	,TRANS_NAME
	,ENG_CYLINDERS
	,ENG_DISPLACEMENT
	,PATTERN_PERCENT
	,VIN_POSITION
	,GVWR_MIN
	,GVWR_MAX
	,FUEL_CODE
	,FUEL_DESCRIPTION
	,ASPIRATION
	,GOODCD_PERCENT
	,VMG_CARRIER
	,VMG_STATE
	,VMG_PROGRAM
	,VMG_RATE_SET
	,VMG_HLDI_MAKE
	,VMG_EFF_DATE
	,VMG_EXP_DATE
	,VMG_MAKE_CODE
	,VMG_USER_ID
	,VMG_WK_STATION
	,VMG_SYS_DATE
	,VMG_SYS_TIME
	,VEH_CLASS_ID
	,VEH_CLASS_NAME
	,VEH_SIZE_ID
	,VEH_SIZE_NAME
	,CURB_WEIGHT
	,WHEELBASE
	,VEH_LENGTH
	,VEH_WIDTH
	,VEH_HEIGHT
	,VEH_BASE_PRICE
	,DOOR_ID
	,DRIVE_TYPE_ID
	,BODY_CONSTRUCTION_ID
	,GROUND_CLEARANCE_MIN
	,EPA_MILEAGE_CITY
	,EPA_MILEAGE_HIGHWAY
	,EPA_INTERIOR_VOLUME
	,EPA_LUGGAGE_VOLUME
	,WEB_MAKE_NAME
	,WEB_SERIES_NAME
	,SUPERSERIES_NUMBER
	,SUPERSERIES_NAME
	,REDESIGN_YEAR
	,FOUR_WHEEL_ABS
	,REAR_WHEEL_ABS
	,DAYTIME_LIGHTS
	,STABILITY_CONTROL
	,AUDIBLE_ALARM
	,IGNITION_CUTOFF
	,PASSIVE_AUDIBLE_ALARM
	,PASSIVE_IGNITION_CUTOFF
	,FRONTSD_DRV_AB_CHESTMOUNT_DOOR
	,FRONTSD_DRV_AB_CHESTMOUNT_SEAT
	,FRONTSD_DRV_AB_HEADMOUNT_DOOR
	,FRONTSD_DRV_AB_HEADMOUNT_SEAT
	,FRONTSD_DRV_AB_HEADMOUNT_ROOF
	,FRONTSD_PAS_AB_CHESTMOUNT_DOOR
	,FRONTSD_PAS_AB_CHESTMOUNT_SEAT
	,FRONTSD_PAS_AB_HEADMOUNT_DOOR
	,FRONTSD_PAS_AB_HEADMOUNT_SEAT
	,FRONTSD_PAS_AB_HEADMOUNT_ROOF
	,REAR_SIDE_AB_CHEST_MOUNT_DOOR
	,REAR_SIDE_AB_CHEST_MOUNT_SEAT
	,REAR_SIDE_AB_HEAD_MOUNT_DOOR
	,REAR_SIDE_AB_HEAD_MOUNT_SEAT
	,REAR_SIDE_AB_HEAD_MOUNT_ROOF
	,THRD_SIDE_AB_CHEST_MOUNT_DOOR
	,THRD_SIDE_AB_CHEST_MOUNT_SEAT
	,THRD_SIDE_AB_HEAD_MOUNT_DOOR
	,THRD_SIDE_AB_HEAD_MOUNT_SEAT
	,THRD_SIDE_AB_HEAD_MOUNT_ROOF
	,FRONT_DRV_AB
	,FRONT_PAS_AB
	,ADAPT_CRUISE_CONTROL
	,ADAPT_CRUISE_CONTROL_STOP
	,BLIND_SPOT_WARN
	,BLIND_SPOT_PREVENT
	,LANE_DEPART_WARN
	,LANE_DEPART_PREVENT
	,FWD_COLL_WARN
	,FWD_COLL_WARN_AUTO_BRAKE
	,ADAPT_HEADLIGHTS_CURVE
	,ADAPT_BRAKELIGHTS
	,NIGHT_VISION
	,DRVR_ALERT_MONITOR
	,COLL_PREVENT_LOW_SPD
	,PARK_SNSR_FRONT
	,PARK_SNSR_REAR
	,PARK_CAMERA_REAR
	,PARK_CAMERA_FULL
	,PARK_ASST
	,ADAPT_CRUISE_CONTROL_LANE_CTR
	,ADAPT_HIGHBEAMS
	,CROSS_TRAFFIC_FRONT
	,CROSS_TRAFFIC_REAR
	,AVG_HORSE
	,grp_AVG_HORSE_BIPDPIPCOL
	,grp_AVG_HORSE_CMP
	,base_price
	,grp_Base_price_BIPDPIP
	,grp_Base_price_CMP
	,grp_Base_price_COL
	,Vehicle_SizeV2
	,GRP_VEHCLASS_VEHSIZE
	,grp_day_run_light
	,grp_anti_theft
	,grp_Brakes
	,Airbag_Drv
	,airbag_pass
	,airbag_second_row
	,airbag_third_row
	,airbag
	,Body_Construction
	,grp_Body_Construct_COLCMP
	,Door_Count
	,Drive_Type
	,grp_Drive_type
	,Adaptive_Cruise_Ctrl
	,Adaptive_Cruise_Ctrl_Stop
	,Blind_Spot_Warning
	,Blind_Spot_Stop
	,Lane_Departure_Warn
	,Lane_Departure_Prevent
	,Forward_Coll_Warn
	,Forward_Coll_Brake
	,Adaptive_Headlights
	,Adaptive_Brakelights
	,Night_Vis
	,Driver_Alertness_Monitor
	,Low_Spd_Coll_Prevent
	,Front_Park_Sensor
	,Rear_Park_Sensor
	,Rear_Park_Camera
	,Full_Park_Camera
	,Parking_Assist
	,Adaptive_Highbeams
	,Adaptive_Cruise_Ctrl_Lane_Center
	,Full_Park_Camera_wide
	,CrossTrafficCamera_front
	,CrossTrafficWarning_Rear
	,grp_Adaptive_Cruise_ctrl
	,grp_Cam_Sensor
	,grp_Blind_Spot
	,grp_Accident_avoidance
	,grp_Lane_Depart
	,grp_AdaptiveCruise_AccAvoid
	,grp_BlindSpot_LaneDept
	,MAKE_GRP
	,CASE when doldiff <= 0 then 'WIN'
		  when doldiff <= 30 then '1_30'
		  when doldiff <= 60 then '31_60'
		  when doldiff <= 90 then '61_90'
		  when doldiff <= 120 then '91_120'
		  else 'GE_121' end as Label

From	(SELECT
			Count(TotalPremium) as QuoteCNT
			,Company_Name as Company
			,sum(TOTALPREMIUM) as TOTPREM
			,Risk_Area as RISKAREA
			,P_LVL_TOT as P_LEVEL
			,SUBSTRING(DateQuoted,1,4) as RATE_YR
			,SUBSTRING(DateQuoted,6,2) as RATE_MO
			,[Profile]
			,County as COUNTY
			,VEH_CNT as VEHCNT
			,Num_Drivers as DRCNT
			,Maker01 as MAKER
			,Won
			,TERM
			,@state as STATE
			,RANKING AS RANK
			,Company_Name01 as RANK1CO
			,Company_Name02 as RANK2CO
			,Company_Name03 as RANK3CO
			,Company_Name04 as RANK4CO
			,Company_Name05 as RANK5CO
			,PriorInsurance01 as POP
			,PriorDaysLapse01 as LAPSE
			,ResidencyStatus01 as HO
			,SR2201 as SR22
			,MODEL01 AS MODEL
			,Sex01 as GENDER
			,ZipCode as ZIP
			,Year01 as MODEL_YEAR
			,TotalPremium01 as RANK1PR
			,TotalPremium02 as RANK2PR
			,TotalPremium03 as RANK3PR
			,TotalPremium04 as RANK4PR
			,TotalPremium05 as RANK5PR
			,DownPayment
			,PaymentAmount
			,Purchased
			,CompanyID
			,RateOption
			,IsCreditRequired
			,RateIteration
			,PolicyFee
			,NumofPayments
			,PercentDown
			,PaymentTotal
			,FinanceAmount
			,ThirdPartyID
			,Tier
			,Program
			,RatedDate
			,PerPaymentInstallmentFee
			,TotalInstallmentFee
			,EnteredTerm
			,EffectiveDate
			,DateCreated
			,PriorEffDate
			,PriorInAgency
			,NonOwner
			,InsuredDeclinedCredit
			,DateQuoted
			,QuoteAgencyZipCode
			,Bound
			,BinderDate
			,SR22Fee
			,ATPAFee
			,FR44Fee
			,FRBond
			,ExpirationDate
			,Broadform
			,RecordID
			,RateLinkID
			,RateVehicleId01
			,CoSym
			,CoTerr
			,LiabBIPremium
			,LiabPDPremium
			,MedPayPremium
			,PIPPremium
			,RentalPremium
			,TowingPremium
			,UIMBIPremium
			,UIMPDPremium
			,UninsBIPremium
			,UninsPDPremium
			,CoLiabLimits101
			,CoLiabLimits201
			,CoLiabLimits301
			,CoCollDed01
			,CoCompDed01
			,CoPIPLimit01
			,CoMedPayLimit01
			,CoUIMBILimits101
			,CoUIMBILimits201
			,CompPremium
			,CollPremium
			,VIN01
			,LiabLimits101
			,LiabLimits301
			,Maker01
			,Model01
			,Dr_Res_ZIP
			,Num_Drivers
			,Num_Excl_Drivers
			,RateDriverId01
			,Age01
			,Employed01
			,Excluded01
			,Licensed01
			,MonthsLicensed01
			,PriorMonthsCovg01
			,Relation01
			,ResidencyType01
			,StateLicensed01
			,SuspendedLic01
			,PriorCarrierId01
			,PriorLiabLimits101
			,PriorLiabLimits201
			,IndustryId01
			,OccupationId01
			,PrimaryCar01
			,EducationLevel01
			,TVDL01
			,RateDriverLinkId
			,Tot_Violation
			,Tot_AtFault
			,RateViolationId01
			,AtFault01
			,Tot_Convicted
			,Convicted01
			,ViolCode01
			,RANKING
			,Avg_TotalPremium
			,Median_TotalPremium
			,Max_TotalPremium
			,NumCompetitors
			,GCQUOTED
			,Co_Avg_TotalPremium
			,Co_Median_TotalPremium
			,Co_Max_TotalPremium
			,Co_NumCompetitors
			,Co_TotalPremium01
			,Co_TotalPremium02
			,Co_TotalPremium03
			,Co_TotalPremium04
			,Co_TotalPremium05
			,TERRITORY
			,P_LVL_BI
			,P_LVL_PD
			,P_LVL_COL
			,P_LVL_COMP
			,P_LVL_PIP
			,Company_Group
			,Last_Updated
			,TERM_FLAG
			,MAKE_NUMBER
			,MAKE_NAME
			,SERIES_NUMBER
			,SERIES_NAME
			,MODEL_NUMBER
			,MODEL_NAME
			,ENGINE_NAME
			,MIN_HORSE
			,MAX_HORSE
			,TRANS_NAME
			,ENG_CYLINDERS
			,ENG_DISPLACEMENT
			,PATTERN_PERCENT
			,VIN_POSITION
			,GVWR_MIN
			,GVWR_MAX
			,FUEL_CODE
			,FUEL_DESCRIPTION
			,ASPIRATION
			,GOODCD_PERCENT
			,VMG_CARRIER
			,VMG_STATE
			,VMG_PROGRAM
			,VMG_RATE_SET
			,VMG_HLDI_MAKE
			,VMG_EFF_DATE
			,VMG_EXP_DATE
			,VMG_MAKE_CODE
			,VMG_USER_ID
			,VMG_WK_STATION
			,VMG_SYS_DATE
			,VMG_SYS_TIME
			,VEH_CLASS_ID
			,VEH_CLASS_NAME
			,VEH_SIZE_ID
			,VEH_SIZE_NAME
			,CURB_WEIGHT
			,WHEELBASE
			,VEH_LENGTH
			,VEH_WIDTH
			,VEH_HEIGHT
			,VEH_BASE_PRICE
			,DOOR_ID
			,DRIVE_TYPE_ID
			,BODY_CONSTRUCTION_ID
			,GROUND_CLEARANCE_MIN
			,EPA_MILEAGE_CITY
			,EPA_MILEAGE_HIGHWAY
			,EPA_INTERIOR_VOLUME
			,EPA_LUGGAGE_VOLUME
			,WEB_MAKE_NAME
			,WEB_SERIES_NAME
			,SUPERSERIES_NUMBER
			,SUPERSERIES_NAME
			,REDESIGN_YEAR
			,FOUR_WHEEL_ABS
			,REAR_WHEEL_ABS
			,DAYTIME_LIGHTS
			,STABILITY_CONTROL
			,AUDIBLE_ALARM
			,IGNITION_CUTOFF
			,PASSIVE_AUDIBLE_ALARM
			,PASSIVE_IGNITION_CUTOFF
			,FRONTSD_DRV_AB_CHESTMOUNT_DOOR
			,FRONTSD_DRV_AB_CHESTMOUNT_SEAT
			,FRONTSD_DRV_AB_HEADMOUNT_DOOR
			,FRONTSD_DRV_AB_HEADMOUNT_SEAT
			,FRONTSD_DRV_AB_HEADMOUNT_ROOF
			,FRONTSD_PAS_AB_CHESTMOUNT_DOOR
			,FRONTSD_PAS_AB_CHESTMOUNT_SEAT
			,FRONTSD_PAS_AB_HEADMOUNT_DOOR
			,FRONTSD_PAS_AB_HEADMOUNT_SEAT
			,FRONTSD_PAS_AB_HEADMOUNT_ROOF
			,REAR_SIDE_AB_CHEST_MOUNT_DOOR
			,REAR_SIDE_AB_CHEST_MOUNT_SEAT
			,REAR_SIDE_AB_HEAD_MOUNT_DOOR
			,REAR_SIDE_AB_HEAD_MOUNT_SEAT
			,REAR_SIDE_AB_HEAD_MOUNT_ROOF
			,THRD_SIDE_AB_CHEST_MOUNT_DOOR
			,THRD_SIDE_AB_CHEST_MOUNT_SEAT
			,THRD_SIDE_AB_HEAD_MOUNT_DOOR
			,THRD_SIDE_AB_HEAD_MOUNT_SEAT
			,THRD_SIDE_AB_HEAD_MOUNT_ROOF
			,FRONT_DRV_AB
			,FRONT_PAS_AB
			,ADAPT_CRUISE_CONTROL
			,ADAPT_CRUISE_CONTROL_STOP
			,BLIND_SPOT_WARN
			,BLIND_SPOT_PREVENT
			,LANE_DEPART_WARN
			,LANE_DEPART_PREVENT
			,FWD_COLL_WARN
			,FWD_COLL_WARN_AUTO_BRAKE
			,ADAPT_HEADLIGHTS_CURVE
			,ADAPT_BRAKELIGHTS
			,NIGHT_VISION
			,DRVR_ALERT_MONITOR
			,COLL_PREVENT_LOW_SPD
			,PARK_SNSR_FRONT
			,PARK_SNSR_REAR
			,PARK_CAMERA_REAR
			,PARK_CAMERA_FULL
			,PARK_ASST
			,ADAPT_CRUISE_CONTROL_LANE_CTR
			,ADAPT_HIGHBEAMS
			,CROSS_TRAFFIC_FRONT
			,CROSS_TRAFFIC_REAR
			,AVG_HORSE
			,grp_AVG_HORSE_BIPDPIPCOL
			,grp_AVG_HORSE_CMP
			,base_price
			,grp_Base_price_BIPDPIP
			,grp_Base_price_CMP
			,grp_Base_price_COL
			,Vehicle_SizeV2
			,GRP_VEHCLASS_VEHSIZE
			,grp_day_run_light
			,grp_anti_theft
			,grp_Brakes
			,Airbag_Drv
			,airbag_pass
			,airbag_second_row
			,airbag_third_row
			,airbag
			,Body_Construction
			,grp_Body_Construct_COLCMP
			,Door_Count
			,Drive_Type
			,grp_Drive_type
			,Adaptive_Cruise_Ctrl
			,Adaptive_Cruise_Ctrl_Stop
			,Blind_Spot_Warning
			,Blind_Spot_Stop
			,Lane_Departure_Warn
			,Lane_Departure_Prevent
			,Forward_Coll_Warn
			,Forward_Coll_Brake
			,Adaptive_Headlights
			,Adaptive_Brakelights
			,Night_Vis
			,Driver_Alertness_Monitor
			,Low_Spd_Coll_Prevent
			,Front_Park_Sensor
			,Rear_Park_Sensor
			,Rear_Park_Camera
			,Full_Park_Camera
			,Parking_Assist
			,Adaptive_Highbeams
			,Adaptive_Cruise_Ctrl_Lane_Center
			,Full_Park_Camera_wide
			,CrossTrafficCamera_front
			,CrossTrafficWarning_Rear
			,grp_Adaptive_Cruise_ctrl
			,grp_Cam_Sensor
			,grp_Blind_Spot
			,grp_Accident_avoidance
			,grp_Lane_Depart
			,grp_AdaptiveCruise_AccAvoid
			,grp_BlindSpot_LaneDept
			,MAKE_GRP
			,CASE WHEN ( left(Company_Name01,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium01)
                    WHEN ( left(Company_Name02,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium02)
                    WHEN ( left(Company_Name03,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium03)
                    WHEN ( left(Company_Name04,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium04)
                    else (TotalPremium - TotalPremium05) end as doldiff
			,CASE	WHEN InternatDL_Cnt = Num_Drivers THEN 'All_International'
					WHEN InternatDL_Cnt = 0 THEN 'All_Domestic'
					WHEN InternatDL01 = 0 AND InternatDL_Cnt > 0  THEN 'Mixed_DomNI'
					WHEN InternatDL01 = 1 AND InternatDL_Cnt < Num_Drivers THEN 'Mixed_IntNI'
					END AS DR_MIX
			,CASE	WHEN ASSUMEDCREDIT = 'A' THEN 'AVERAGE'
					WHEN ASSUMEDCREDIT = 'B' THEN 'BEST'
					WHEN ASSUMEDCREDIT = 'H' THEN 'NO HIT'
					WHEN ASSUMEDCREDIT = 'S' THEN 'NO SCORE'
					WHEN ASSUMEDCREDIT = 'W' THEN 'WORST' 
					END AS CREDLVL
				 FROM [MARKETING].[DBO].[ITC_AL_N_XL]
		 WHERE LiabLimits101 >=15 AND LiabLimits101<=30 and LiabLimits301 >=10 AND LiabLimits301<=30 
		 GROUP BY 
			TotalPremium
			,Company_Name
			,Risk_Area
			,P_LVL_TOT
			,DateQuoted
			,[Profile]
			,County
			,VEH_CNT
			,Num_Drivers
			,Maker01
			,Model01
			,Won
			,TERM
			,RANKING
			,Company_Name01
			,Company_Name02
			,Company_Name03
			,Company_Name04
			,Company_Name05
			,PriorInsurance01
			,PriorDaysLapse01
			,ResidencyStatus01
			,SR2201
			,Sex01
			,ZipCode
			,Year01
			,TotalPremium01
			,TotalPremium02
			,TotalPremium03
			,TotalPremium04
			,TotalPremium05
			,DownPayment
			,PaymentAmount
			,Purchased
			,CompanyID
			,RateOption
			,IsCreditRequired
			,RateIteration
			,PolicyFee
			,NumofPayments
			,PercentDown
			,PaymentTotal
			,FinanceAmount
			,ThirdPartyID
			,Tier
			,Program
			,RatedDate
			,PerPaymentInstallmentFee
			,TotalInstallmentFee
			,EnteredTerm
			,EffectiveDate
			,DateCreated
			,PriorEffDate
			,PriorInAgency
			,NonOwner
			,InsuredDeclinedCredit
			,DateQuoted
			,QuoteAgencyZipCode
			,Bound
			,BinderDate
			,SR22Fee
			,ATPAFee
			,FR44Fee
			,FRBond
			,ExpirationDate
			,Broadform
			,RecordID
			,RateLinkID
			,RateVehicleId01
			,VEH_CNT
			,CoSym
			,CoTerr
			,LiabBIPremium
			,LiabPDPremium
			,MedPayPremium
			,PIPPremium
			,RentalPremium
			,TowingPremium
			,UIMBIPremium
			,UIMPDPremium
			,UninsBIPremium
			,UninsPDPremium
			,CoLiabLimits101
			,CoLiabLimits201
			,CoLiabLimits301
			,CoCollDed01
			,CoCompDed01
			,CoPIPLimit01
			,CoMedPayLimit01
			,CoUIMBILimits101
			,CoUIMBILimits201
			,CompPremium
			,CollPremium
			,VIN01
			,LiabLimits101
			,LiabLimits301
			,Maker01
			,Model01
			,Dr_Res_ZIP
			,Num_Drivers
			,Num_Excl_Drivers
			,RateDriverId01
			,Age01
			,Employed01
			,Excluded01
			,Licensed01
			,MonthsLicensed01
			,PriorMonthsCovg01
			,Relation01
			,ResidencyType01
			,StateLicensed01
			,SuspendedLic01
			,PriorCarrierId01
			,PriorLiabLimits101
			,PriorLiabLimits201
			,IndustryId01
			,OccupationId01
			,PrimaryCar01
			,EducationLevel01
			,TVDL01
			,RateDriverLinkId
			,Tot_Violation
			,Tot_AtFault
			,RateViolationId01
			,AtFault01
			,Tot_Convicted
			,Convicted01
			,ViolCode01
			,RANKING
			,Avg_TotalPremium
			,Median_TotalPremium
			,Max_TotalPremium
			,NumCompetitors
			,GCQUOTED
			,Co_Avg_TotalPremium
			,Co_Median_TotalPremium
			,Co_Max_TotalPremium
			,Co_NumCompetitors
			,Co_TotalPremium01
			,Co_TotalPremium02
			,Co_TotalPremium03
			,Co_TotalPremium04
			,Co_TotalPremium05
			,TERRITORY
			,P_LVL_BI
			,P_LVL_PD
			,P_LVL_COL
			,P_LVL_COMP
			,P_LVL_PIP
			,Company_Group
			,Last_Updated
			,TERM_FLAG
			,MAKE_NUMBER
			,MAKE_NAME
			,SERIES_NUMBER
			,SERIES_NAME
			,MODEL_NUMBER
			,MODEL_NAME
			,ENGINE_NAME
			,MIN_HORSE
			,MAX_HORSE
			,TRANS_NAME
			,ENG_CYLINDERS
			,ENG_DISPLACEMENT
			,PATTERN_PERCENT
			,VIN_POSITION
			,GVWR_MIN
			,GVWR_MAX
			,FUEL_CODE
			,FUEL_DESCRIPTION
			,ASPIRATION
			,GOODCD_PERCENT
			,VMG_CARRIER
			,VMG_STATE
			,VMG_PROGRAM
			,VMG_RATE_SET
			,VMG_HLDI_MAKE
			,VMG_EFF_DATE
			,VMG_EXP_DATE
			,VMG_MAKE_CODE
			,VMG_USER_ID
			,VMG_WK_STATION
			,VMG_SYS_DATE
			,VMG_SYS_TIME
			,VEH_CLASS_ID
			,VEH_CLASS_NAME
			,VEH_SIZE_ID
			,VEH_SIZE_NAME
			,CURB_WEIGHT
			,WHEELBASE
			,VEH_LENGTH
			,VEH_WIDTH
			,VEH_HEIGHT
			,VEH_BASE_PRICE
			,DOOR_ID
			,DRIVE_TYPE_ID
			,BODY_CONSTRUCTION_ID
			,GROUND_CLEARANCE_MIN
			,EPA_MILEAGE_CITY
			,EPA_MILEAGE_HIGHWAY
			,EPA_INTERIOR_VOLUME
			,EPA_LUGGAGE_VOLUME
			,WEB_MAKE_NAME
			,WEB_SERIES_NAME
			,SUPERSERIES_NUMBER
			,SUPERSERIES_NAME
			,REDESIGN_YEAR
			,FOUR_WHEEL_ABS
			,REAR_WHEEL_ABS
			,DAYTIME_LIGHTS
			,STABILITY_CONTROL
			,AUDIBLE_ALARM
			,IGNITION_CUTOFF
			,PASSIVE_AUDIBLE_ALARM
			,PASSIVE_IGNITION_CUTOFF
			,FRONTSD_DRV_AB_CHESTMOUNT_DOOR
			,FRONTSD_DRV_AB_CHESTMOUNT_SEAT
			,FRONTSD_DRV_AB_HEADMOUNT_DOOR
			,FRONTSD_DRV_AB_HEADMOUNT_SEAT
			,FRONTSD_DRV_AB_HEADMOUNT_ROOF
			,FRONTSD_PAS_AB_CHESTMOUNT_DOOR
			,FRONTSD_PAS_AB_CHESTMOUNT_SEAT
			,FRONTSD_PAS_AB_HEADMOUNT_DOOR
			,FRONTSD_PAS_AB_HEADMOUNT_SEAT
			,FRONTSD_PAS_AB_HEADMOUNT_ROOF
			,REAR_SIDE_AB_CHEST_MOUNT_DOOR
			,REAR_SIDE_AB_CHEST_MOUNT_SEAT
			,REAR_SIDE_AB_HEAD_MOUNT_DOOR
			,REAR_SIDE_AB_HEAD_MOUNT_SEAT
			,REAR_SIDE_AB_HEAD_MOUNT_ROOF
			,THRD_SIDE_AB_CHEST_MOUNT_DOOR
			,THRD_SIDE_AB_CHEST_MOUNT_SEAT
			,THRD_SIDE_AB_HEAD_MOUNT_DOOR
			,THRD_SIDE_AB_HEAD_MOUNT_SEAT
			,THRD_SIDE_AB_HEAD_MOUNT_ROOF
			,FRONT_DRV_AB
			,FRONT_PAS_AB
			,ADAPT_CRUISE_CONTROL
			,ADAPT_CRUISE_CONTROL_STOP
			,BLIND_SPOT_WARN
			,BLIND_SPOT_PREVENT
			,LANE_DEPART_WARN
			,LANE_DEPART_PREVENT
			,FWD_COLL_WARN
			,FWD_COLL_WARN_AUTO_BRAKE
			,ADAPT_HEADLIGHTS_CURVE
			,ADAPT_BRAKELIGHTS
			,NIGHT_VISION
			,DRVR_ALERT_MONITOR
			,COLL_PREVENT_LOW_SPD
			,PARK_SNSR_FRONT
			,PARK_SNSR_REAR
			,PARK_CAMERA_REAR
			,PARK_CAMERA_FULL
			,PARK_ASST
			,ADAPT_CRUISE_CONTROL_LANE_CTR
			,ADAPT_HIGHBEAMS
			,CROSS_TRAFFIC_FRONT
			,CROSS_TRAFFIC_REAR
			,AVG_HORSE
			,grp_AVG_HORSE_BIPDPIPCOL
			,grp_AVG_HORSE_CMP
			,base_price
			,grp_Base_price_BIPDPIP
			,grp_Base_price_CMP
			,grp_Base_price_COL
			,Vehicle_SizeV2
			,GRP_VEHCLASS_VEHSIZE
			,grp_day_run_light
			,grp_anti_theft
			,grp_Brakes
			,Airbag_Drv
			,airbag_pass
			,airbag_second_row
			,airbag_third_row
			,airbag
			,Body_Construction
			,grp_Body_Construct_COLCMP
			,Door_Count
			,Drive_Type
			,grp_Drive_type
			,Adaptive_Cruise_Ctrl
			,Adaptive_Cruise_Ctrl_Stop
			,Blind_Spot_Warning
			,Blind_Spot_Stop
			,Lane_Departure_Warn
			,Lane_Departure_Prevent
			,Forward_Coll_Warn
			,Forward_Coll_Brake
			,Adaptive_Headlights
			,Adaptive_Brakelights
			,Night_Vis
			,Driver_Alertness_Monitor
			,Low_Spd_Coll_Prevent
			,Front_Park_Sensor
			,Rear_Park_Sensor
			,Rear_Park_Camera
			,Full_Park_Camera
			,Parking_Assist
			,Adaptive_Highbeams
			,Adaptive_Cruise_Ctrl_Lane_Center
			,Full_Park_Camera_wide
			,CrossTrafficCamera_front
			,CrossTrafficWarning_Rear
			,grp_Adaptive_Cruise_ctrl
			,grp_Cam_Sensor
			,grp_Blind_Spot
			,grp_Accident_avoidance
			,grp_Lane_Depart
			,grp_AdaptiveCruise_AccAvoid
			,grp_BlindSpot_LaneDept
			,MAKE_GRP


			,CASE WHEN ( left(Company_Name01,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium01)
                    WHEN ( left(Company_Name02,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium02)
                    WHEN ( left(Company_Name03,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium03)
                    WHEN ( left(Company_Name04,4) <> left(RTRIM(LTRIM(CONCAT(Company_Name,Program))) ,4) ) then (TotalPremium - TotalPremium04)
                    else (TotalPremium - TotalPremium05) end  
			,CASE	WHEN InternatDL_Cnt = Num_Drivers THEN 'All_International'
							WHEN InternatDL_Cnt = 0 THEN 'All_Domestic'
					WHEN InternatDL01 = 0 AND InternatDL_Cnt > 0  THEN 'Mixed_DomNI'
					WHEN InternatDL01 = 1 AND InternatDL_Cnt < Num_Drivers THEN 'Mixed_IntNI'
					END 
			,CASE	WHEN ASSUMEDCREDIT = 'A' THEN 'AVERAGE'
					WHEN ASSUMEDCREDIT = 'B' THEN 'BEST'
					WHEN ASSUMEDCREDIT = 'H' THEN 'NO HIT'
					WHEN ASSUMEDCREDIT = 'S' THEN 'NO SCORE'
					WHEN ASSUMEDCREDIT = 'W' THEN 'WORST' 
					END 
              ) AS A
	
Group by 
	doldiff
	,DR_MIX
	,CREDLVL
	,QuoteCNT
	,Company
	,TOTPREM
	,RISKAREA
	,P_LEVEL
	,RATE_YR
	,RATE_MO
	,[Profile]
	,COUNTY
	,VEHCNT
	,DRCNT
	,MAKER
	,MODEL
	,Won
	,TERM
	,STATE
	,RANK
	,RANK1CO
	,RANK2CO
	,RANK3CO
	,RANK4CO
	,RANK5CO
	,POP
	,LAPSE
	,HO
	,SR22
	,MAKER
	,MODEL
	,GENDER
	,ZIP
	,MODEL_YEAR
	,RANK1PR
	,RANK2PR
	,RANK3PR
	,RANK4PR
	,RANK5PR
	,DownPayment
	,PaymentAmount
	,Purchased
	,CompanyID
	,RateOption
	,IsCreditRequired
	,RateIteration
	,PolicyFee
	,NumofPayments
	,PercentDown
	,PaymentTotal
	,FinanceAmount
	,ThirdPartyID
	,Tier
	,Program
	,RatedDate
	,PerPaymentInstallmentFee
	,TotalInstallmentFee
	,EnteredTerm
	,EffectiveDate
	,DateCreated
	,PriorEffDate
	,PriorInAgency
	,NonOwner
	,InsuredDeclinedCredit
	,DateQuoted
	,QuoteAgencyZipCode
	,Bound
	,BinderDate
	,SR22Fee
	,ATPAFee
	,FR44Fee
	,FRBond
	,ExpirationDate
	,Broadform
	,RecordID
	,RateLinkID
	,RateVehicleId01
	,CoSym
	,CoTerr
	,LiabBIPremium
	,LiabPDPremium
	,MedPayPremium
	,PIPPremium
	,RentalPremium
	,TowingPremium
	,UIMBIPremium
	,UIMPDPremium
	,UninsBIPremium
	,UninsPDPremium
	,CoLiabLimits101
	,CoLiabLimits201
	,CoLiabLimits301
	,CoCollDed01
	,CoCompDed01
	,CoPIPLimit01
	,CoMedPayLimit01
	,CoUIMBILimits101
	,CoUIMBILimits201
	,CompPremium
	,CollPremium
	,VIN01
	,LiabLimits101
	,LiabLimits301
	,Maker01
	,Model01
	,Dr_Res_ZIP
	,Num_Drivers
	,Num_Excl_Drivers
	,RateDriverId01
	,Age01
	,Employed01
	,Excluded01
	,Licensed01
	,MonthsLicensed01
	,PriorMonthsCovg01
	,Relation01
	,ResidencyType01
	,StateLicensed01
	,SuspendedLic01
	,PriorCarrierId01
	,PriorLiabLimits101
	,PriorLiabLimits201
	,IndustryId01
	,OccupationId01
	,PrimaryCar01
	,EducationLevel01
	,TVDL01
	,RateDriverLinkId
	,Tot_Violation
	,Tot_AtFault
	,RateViolationId01
	,AtFault01
	,Tot_Convicted
	,Convicted01
	,ViolCode01
	,RANKING
	,Avg_TotalPremium
	,Median_TotalPremium
	,Max_TotalPremium
	,NumCompetitors
	,GCQUOTED
	,Co_Avg_TotalPremium
	,Co_Median_TotalPremium
	,Co_Max_TotalPremium
	,Co_NumCompetitors
	,Co_TotalPremium01
	,Co_TotalPremium02
	,Co_TotalPremium03
	,Co_TotalPremium04
	,Co_TotalPremium05
	,TERRITORY
	,P_LVL_BI
	,P_LVL_PD
	,P_LVL_COL
	,P_LVL_COMP
	,P_LVL_PIP
	,Company_Group
	,Last_Updated
	,TERM_FLAG
	,MAKE_NUMBER
	,MAKE_NAME
	,SERIES_NUMBER
	,SERIES_NAME
	,MODEL_NUMBER
	,MODEL_NAME
	,ENGINE_NAME
	,MIN_HORSE
	,MAX_HORSE
	,TRANS_NAME
	,ENG_CYLINDERS
	,ENG_DISPLACEMENT
	,PATTERN_PERCENT
	,VIN_POSITION
	,GVWR_MIN
	,GVWR_MAX
	,FUEL_CODE
	,FUEL_DESCRIPTION
	,ASPIRATION
	,GOODCD_PERCENT
	,VMG_CARRIER
	,VMG_STATE
	,VMG_PROGRAM
	,VMG_RATE_SET
	,VMG_HLDI_MAKE
	,VMG_EFF_DATE
	,VMG_EXP_DATE
	,VMG_MAKE_CODE
	,VMG_USER_ID
	,VMG_WK_STATION
	,VMG_SYS_DATE
	,VMG_SYS_TIME
	,VEH_CLASS_ID
	,VEH_CLASS_NAME
	,VEH_SIZE_ID
	,VEH_SIZE_NAME
	,CURB_WEIGHT
	,WHEELBASE
	,VEH_LENGTH
	,VEH_WIDTH
	,VEH_HEIGHT
	,VEH_BASE_PRICE
	,DOOR_ID
	,DRIVE_TYPE_ID
	,BODY_CONSTRUCTION_ID
	,GROUND_CLEARANCE_MIN
	,EPA_MILEAGE_CITY
	,EPA_MILEAGE_HIGHWAY
	,EPA_INTERIOR_VOLUME
	,EPA_LUGGAGE_VOLUME
	,WEB_MAKE_NAME
	,WEB_SERIES_NAME
	,SUPERSERIES_NUMBER
	,SUPERSERIES_NAME
	,REDESIGN_YEAR
	,FOUR_WHEEL_ABS
	,REAR_WHEEL_ABS
	,DAYTIME_LIGHTS
	,STABILITY_CONTROL
	,AUDIBLE_ALARM
	,IGNITION_CUTOFF
	,PASSIVE_AUDIBLE_ALARM
	,PASSIVE_IGNITION_CUTOFF
	,FRONTSD_DRV_AB_CHESTMOUNT_DOOR
	,FRONTSD_DRV_AB_CHESTMOUNT_SEAT
	,FRONTSD_DRV_AB_HEADMOUNT_DOOR
	,FRONTSD_DRV_AB_HEADMOUNT_SEAT
	,FRONTSD_DRV_AB_HEADMOUNT_ROOF
	,FRONTSD_PAS_AB_CHESTMOUNT_DOOR
	,FRONTSD_PAS_AB_CHESTMOUNT_SEAT
	,FRONTSD_PAS_AB_HEADMOUNT_DOOR
	,FRONTSD_PAS_AB_HEADMOUNT_SEAT
	,FRONTSD_PAS_AB_HEADMOUNT_ROOF
	,REAR_SIDE_AB_CHEST_MOUNT_DOOR
	,REAR_SIDE_AB_CHEST_MOUNT_SEAT
	,REAR_SIDE_AB_HEAD_MOUNT_DOOR
	,REAR_SIDE_AB_HEAD_MOUNT_SEAT
	,REAR_SIDE_AB_HEAD_MOUNT_ROOF
	,THRD_SIDE_AB_CHEST_MOUNT_DOOR
	,THRD_SIDE_AB_CHEST_MOUNT_SEAT
	,THRD_SIDE_AB_HEAD_MOUNT_DOOR
	,THRD_SIDE_AB_HEAD_MOUNT_SEAT
	,THRD_SIDE_AB_HEAD_MOUNT_ROOF
	,FRONT_DRV_AB
	,FRONT_PAS_AB
	,ADAPT_CRUISE_CONTROL
	,ADAPT_CRUISE_CONTROL_STOP
	,BLIND_SPOT_WARN
	,BLIND_SPOT_PREVENT
	,LANE_DEPART_WARN
	,LANE_DEPART_PREVENT
	,FWD_COLL_WARN
	,FWD_COLL_WARN_AUTO_BRAKE
	,ADAPT_HEADLIGHTS_CURVE
	,ADAPT_BRAKELIGHTS
	,NIGHT_VISION
	,DRVR_ALERT_MONITOR
	,COLL_PREVENT_LOW_SPD
	,PARK_SNSR_FRONT
	,PARK_SNSR_REAR
	,PARK_CAMERA_REAR
	,PARK_CAMERA_FULL
	,PARK_ASST
	,ADAPT_CRUISE_CONTROL_LANE_CTR
	,ADAPT_HIGHBEAMS
	,CROSS_TRAFFIC_FRONT
	,CROSS_TRAFFIC_REAR
	,AVG_HORSE
	,grp_AVG_HORSE_BIPDPIPCOL
	,grp_AVG_HORSE_CMP
	,base_price
	,grp_Base_price_BIPDPIP
	,grp_Base_price_CMP
	,grp_Base_price_COL
	,Vehicle_SizeV2
	,GRP_VEHCLASS_VEHSIZE
	,grp_day_run_light
	,grp_anti_theft
	,grp_Brakes
	,Airbag_Drv
	,airbag_pass
	,airbag_second_row
	,airbag_third_row
	,airbag
	,Body_Construction
	,grp_Body_Construct_COLCMP
	,Door_Count
	,Drive_Type
	,grp_Drive_type
	,Adaptive_Cruise_Ctrl
	,Adaptive_Cruise_Ctrl_Stop
	,Blind_Spot_Warning
	,Blind_Spot_Stop
	,Lane_Departure_Warn
	,Lane_Departure_Prevent
	,Forward_Coll_Warn
	,Forward_Coll_Brake
	,Adaptive_Headlights
	,Adaptive_Brakelights
	,Night_Vis
	,Driver_Alertness_Monitor
	,Low_Spd_Coll_Prevent
	,Front_Park_Sensor
	,Rear_Park_Sensor
	,Rear_Park_Camera
	,Full_Park_Camera
	,Parking_Assist
	,Adaptive_Highbeams
	,Adaptive_Cruise_Ctrl_Lane_Center
	,Full_Park_Camera_wide
	,CrossTrafficCamera_front
	,CrossTrafficWarning_Rear
	,grp_Adaptive_Cruise_ctrl
	,grp_Cam_Sensor
	,grp_Blind_Spot
	,grp_Accident_avoidance
	,grp_Lane_Depart
	,grp_AdaptiveCruise_AccAvoid
	,grp_BlindSpot_LaneDept
	,MAKE_GRP