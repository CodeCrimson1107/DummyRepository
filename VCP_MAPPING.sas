LIBNAME D_TBL ODBC USER=AUDIT1 PASSWORD=audit11 DATASRC=DRAGON SCHEMA=LDSNEWTBL;

%macro VCP_MAPPING(
INPUT_DATA = 
,OUTPUT_DATA = 
,VIN_JOIN_VAR = 
,YEAR_JOIN_VAR = 
,MAKE_JOIN_VAR =
);
%macro formatkeep(); 
%mend formatkeep(); 
PROC SQL;
CREATE TABLE work.VCP_STEP01 AS
	SELECT *
	FROM &INPUT_DATA. INPUT

	LEFT JOIN D_TBL.VINPAT8 VINPAT8 ON
		SUBSTR(INPUT.&VIN_JOIN_VAR.,1,8) = VINPAT8.VIN_PATTERN_8
	AND INPUT.&YEAR_JOIN_VAR. = VINPAT8.MODEL_YEAR

	LEFT JOIN D_TBL.VMAKEGRP VMAKEGRP ON
		INPUT.&MAKE_JOIN_VAR. = VMAKEGRP.VMG_HLDI_MAKE
	AND VMG_EXP_DATE = mdy(1, 1, 9999)
	AND VMG_STATE = 'TX'
	AND VMG_RATE_SET = 5
	
	LEFT JOIN D_TBL.vehspecext vehspecext ON
		INPUT.&YEAR_JOIN_VAR. = vehspecext.MODEL_YEAR
	AND VINPAT8.MAKE_NUMBER = vehspecext.MAKE_NUMBER
	AND VINPAT8.SERIES_NUMBER = vehspecext.SERIES_NUMBER

     LEFT JOIN D_TBL.vehftrsext  vehftr ON
           INPUT.&YEAR_JOIN_VAR. = vehftr.MODEL_YEAR
     AND VINPAT8.MAKE_NUMBER = vehftr.MAKE_NUMBER
     AND VINPAT8.SERIES_NUMBER = vehftr.SERIES_NUMBER

	ORDER BY 1,2

;QUIT;
DATA &OUTPUT_DATA.;
SET work.VCP_STEP01;
			if Curb_Weight < 2729 then grp_CurbWgt_COLCMP = 'A - LT 2729';
	else if 2729 <=Curb_Weight < 2943 then grp_CurbWgt_COLCMP='B - 2729 to 2943';
	else if 2943 <=Curb_Weight < 3180 then grp_CurbWgt_COLCMP='C - 2943 to 3180';
	else if 3180 <=Curb_Weight < 3490 then grp_CurbWgt_COLCMP='D - 3180 to 3490';
	else if 3490 <=Curb_Weight < 3776 then grp_CurbWgt_COLCMP='E - 3490 to 3776';
	else if 3776 <=Curb_Weight < 4035 then grp_CurbWgt_COLCMP='F - 3776 to 4035';
	else if 4035 <=Curb_Weight < 4268 then grp_CurbWgt_COLCMP='G - 4035 to 4268';
	else if 4268 <=Curb_Weight < 4780 then grp_CurbWgt_COLCMP='H - 4268 to 4780';
	else if 4780 <=Curb_Weight < 4950 then grp_CurbWgt_COLCMP='I - 4780 to 4950';
	else if 4950 <=Curb_Weight < 5311 then grp_CurbWgt_COLCMP='J - 4950 to 5311';
	else if 5311 <=Curb_Weight  then grp_CurbWgt_COLCMP='K - GT 5311';


			if (MAX_HORSE + MIN_HORSE)/2 < 126 then grp_AVG_HORSE_BIPDPIPCOL='A - LT126';
	else if 126 <=(MAX_HORSE + MIN_HORSE)/2 < 145 then grp_AVG_HORSE_BIPDPIPCOL='B - 126 to 145';
	else if 145<=(MAX_HORSE + MIN_HORSE)/2 < 182 then grp_AVG_HORSE_BIPDPIPCOL='C - 145 to 182';
	else if 182<=(MAX_HORSE + MIN_HORSE)/2 < 220 then grp_AVG_HORSE_BIPDPIPCOL='D - 182 to 220';
	else if 220<=(MAX_HORSE + MIN_HORSE)/2 < 258 then grp_AVG_HORSE_BIPDPIPCOL='E - 220 to 258';
	else if 258<=(MAX_HORSE + MIN_HORSE)/2 < 352 then grp_AVG_HORSE_BIPDPIPCOL='F - 258 to 352';
	else if 352<=(MAX_HORSE + MIN_HORSE)/2  then grp_AVG_HORSE_BIPDPIPCOL='G - GT352';

			if (MAX_HORSE + MIN_HORSE)/2 < 134 then grp_AVG_HORSE_CMP='A - LT134';
	else if 134 <=(MAX_HORSE + MIN_HORSE)/2 < 143 then grp_AVG_HORSE_CMP='B - 134 to 143';
	else if 143<=(MAX_HORSE + MIN_HORSE)/2 < 165 then grp_AVG_HORSE_CMP='C - 143 to 165';
	else if 165<=(MAX_HORSE + MIN_HORSE)/2 < 173 then grp_AVG_HORSE_CMP='D - 165 to 173';
	else if 173<=(MAX_HORSE + MIN_HORSE)/2 < 215 then grp_AVG_HORSE_CMP='E - 173 to 215';
	else if 215<=(MAX_HORSE + MIN_HORSE)/2 < 272 then grp_AVG_HORSE_CMP='F - 215 to 272';
	else if 272<=(MAX_HORSE + MIN_HORSE)/2 < 307 then grp_AVG_HORSE_CMP='G - 272 to 307';
	else if 307<=(MAX_HORSE + MIN_HORSE)/2  then grp_AVG_HORSE_CMP='H - GT 307';

		if veh_base_price < 11250 then grp_veh_base_price_BIPDPIP = "A - LT 11250";
	else if 11250 <=veh_base_price < 13835 then grp_veh_base_price_BIPDPIP='B - 11250 to 13835';
	else if 13835 <=veh_base_price < 15994 then grp_veh_base_price_BIPDPIP='C - 13835 to 15994';
	else if 15994 <=veh_base_price < 17696 then grp_veh_base_price_BIPDPIP='D - 15994 to 17696';
	else if 17696 <=veh_base_price < 21910 then grp_veh_base_price_BIPDPIP='E - 17696 to 21910';
	else if 21910 <=veh_base_price < 26579 then grp_veh_base_price_BIPDPIP='F - 21910 to 26579';
	else if 26579 <=veh_base_price < 29842 then grp_veh_base_price_BIPDPIP='G - 26579 to 29842';
	else if 29842 <=veh_base_price < 33781 then grp_veh_base_price_BIPDPIP='H - 29842 to 33781';
	else if 33781 <=veh_base_price < 37182 then grp_veh_base_price_BIPDPIP='I - 33781 to 37182';
	else if 37182 <=veh_base_price < 45996 then grp_veh_base_price_BIPDPIP='J - 37182 to 45996';
	else if 45996 <=veh_base_price  then grp_veh_base_price_BIPDPIP='K - GT 45996';

	if veh_base_price < 16608 then grp_veh_base_price_CMP = "A - LT 16608";
	else if 16608 <=veh_base_price < 18426 then grp_veh_base_price_CMP='B - 16608 to 18426';
	else if 18426 <=veh_base_price < 19938 then grp_veh_base_price_CMP='C - 18426 to 19938';
	else if 19938 <=veh_base_price < 20727 then grp_veh_base_price_CMP='D - 19938 to 20727';
	else if 20727 <=veh_base_price < 24070 then grp_veh_base_price_CMP='E - 20727 to 24070';
	else if 24070 <=veh_base_price < 27533 then grp_veh_base_price_CMP='F - 24070 to 27533';
	else if 27533 <=veh_base_price < 31893 then grp_veh_base_price_CMP='G - 27533 to 31893';
	else if 31893 <=veh_base_price  then grp_veh_base_price_CMP='H - 31893';

	if veh_base_price < 16608 then grp_veh_base_price_COL = "A - LT 16608";
	else if 16608 <=veh_base_price < 18426 then grp_veh_base_price_COL='B - 16608 to 18426';
	else if 18426 <=veh_base_price < 19938 then grp_veh_base_price_COL='C - 18426 to 19938';
	else if 19938 <=veh_base_price < 20727 then grp_veh_base_price_COL='D - 19938 to 20727';
	else if 20727 <=veh_base_price < 24070 then grp_veh_base_price_COL='E - 20727 to 24070';
	else if 24070 <=veh_base_price < 27533 then grp_veh_base_price_COL='F - 24070 to 27533';
	else if 27533 <=veh_base_price < 31893 then grp_veh_base_price_COL='G - 27533 to 31893';
	else if 31893 <=veh_base_price  then grp_veh_base_price_COL='H - 31893';

	if veh_base_price < 16301 then grp_veh_base_price_COL = "A - LT 16301";
	else if 16301 <=veh_base_price < 18371 then grp_veh_base_price_COL='B - 16301 to 18371';
	else if 18371 <=veh_base_price < 19768 then grp_veh_base_price_COL='C - 18371 to 19768';
	else if 19768 <=veh_base_price < 21285 then grp_veh_base_price_COL='D - 19768 to 21285';
	else if 21285 <=veh_base_price < 24305 then grp_veh_base_price_COL='E - 21285 to 24305';
	else if 24305 <=veh_base_price < 25902 then grp_veh_base_price_COL='F - 24305 to 25902';
	else if 25902 <=veh_base_price < 30208 then grp_veh_base_price_COL='G - 25902 to 30208';
	else if 30208 <=veh_base_price < 31555 then grp_veh_base_price_COL='H - 30208 to 31555';
	else if 31555 <=veh_base_price < 37208 then grp_veh_base_price_COL='I - 31555 to 37208';
	else if 37208 <=veh_base_price  then grp_veh_base_price_COL='J - GT 37208'; 

	Vehicle_SizeV2=VEH_SIZE_NAME;
	IF VEH_SIZE_NAME IN ("MICRO" "MINI") THEN VEHICLE_SIZEV2 = "SMALL";
 
	   IF VEH_CLASS_NAME = 'LUXURY' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURY_S';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURY_M';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURY_L';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURY_XL';
	 ELSE IF VEH_CLASS_NAME = '2 DOOR' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'TWODOOR_S';
	 ELSE IF VEH_CLASS_NAME = '2 DOOR' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'TWODOOR_M';
	 ELSE IF VEH_CLASS_NAME = '2 DOOR' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'TWODOOR_L';
	 ELSE IF VEH_CLASS_NAME = '2 DOOR' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'TWODOOR_XL';
	 ELSE IF VEH_CLASS_NAME = '4 DOOR' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'FOURDOOR_S';
	 ELSE IF VEH_CLASS_NAME = '4 DOOR' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'FOURDOOR_M';
	 ELSE IF VEH_CLASS_NAME = '4 DOOR' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'FOURDOOR_L';
	 ELSE IF VEH_CLASS_NAME = '4 DOOR' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'FOURDOOR_XL';
	 ELSE IF VEH_CLASS_NAME = 'SPORTS' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'SPORTS_S';
	 ELSE IF VEH_CLASS_NAME = 'SPORTS' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'SPORTS_M';
	 ELSE IF VEH_CLASS_NAME = 'SPORTS' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'SPORTS_L';
	 ELSE IF VEH_CLASS_NAME = 'SPORTS' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'SPORTS_XL';
	 ELSE IF VEH_CLASS_NAME = 'SUV' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'SUV_S';
	 ELSE IF VEH_CLASS_NAME = 'SUV' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'SUV_M';
	 ELSE IF VEH_CLASS_NAME = 'SUV' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'SUV_L';
	 ELSE IF VEH_CLASS_NAME = 'SUV' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'SUV_XL';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY SUV' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURYSUV_S';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY SUV' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURYSUV_M';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY SUV' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURYSUV_L';
	 ELSE IF VEH_CLASS_NAME = 'LUXURY SUV' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'LUXURYSUV_XL';
	 ELSE IF VEH_CLASS_NAME = 'STATION WAGON' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'STATIONWAGON_S';
	 ELSE IF VEH_CLASS_NAME = 'STATION WAGON' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'STATIONWAGON_M';
	 ELSE IF VEH_CLASS_NAME = 'STATION WAGON' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'STATIONWAGON_L';
	 ELSE IF VEH_CLASS_NAME = 'STATION WAGON' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'STATIONWAGON_XL';
	 ELSE IF VEH_CLASS_NAME = 'MINIVAN' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'MINIVAN_S';
	 ELSE IF VEH_CLASS_NAME = 'MINIVAN' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'MINIVAN_M';
	 ELSE IF VEH_CLASS_NAME = 'MINIVAN' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'MINIVAN_L';
	 ELSE IF VEH_CLASS_NAME = 'MINIVAN' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'MINIVAN_XL';
	 ELSE IF VEH_CLASS_NAME = 'PICKUP' AND VEHICLE_SIZEV2 = 'SMALL' THEN GRP_VEHCLASS_VEHSIZE = 'PICKUP_S';
	 ELSE IF VEH_CLASS_NAME = 'PICKUP' AND VEHICLE_SIZEV2 = 'MIDSIZE' THEN GRP_VEHCLASS_VEHSIZE = 'PICKUP_M';
	 ELSE IF VEH_CLASS_NAME = 'PICKUP' AND VEHICLE_SIZEV2 = 'LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'PICKUP_L';
	 ELSE IF VEH_CLASS_NAME = 'PICKUP' AND VEHICLE_SIZEV2 = 'VERY LARGE' THEN GRP_VEHCLASS_VEHSIZE = 'PICKUP_XL';
	 ELSE GRP_VEHCLASS_VEHSIZE = 'OTHER';

	grp_day_run_light = daytime_lights;

				 if passive_audible_alarm	 = "S" then grp_anti_theft = "Passive Aud";
			else if passive_ignition_cutoff  = "S" then grp_anti_theft = "Passive Ign";
			else if ignition_cutoff  = "S" or audible_alarm           = "S" then grp_anti_theft = "Active";
			else if passive_ignition_cutoff = "O" or passive_audible_alarm = "O" 
					or ignition_cutoff      = "O" or audible_alarm         = "O" then grp_anti_theft = "O";
			else if passive_ignition_cutoff = "NA" or passive_audible_alarm = "NA"
					or ignition_cutoff      = "NA" or audible_alarm         = "NA" then grp_anti_theft = "NA";

			*This is new.;
			if      stability_control = "S" then grp_Brakes = 'ESC-Stnd';
			else if stability_control = "O" then grp_Brakes = 'ESC-Opt';
			else if FOUR_WHEEL_ABS       = "S" then grp_Brakes = 'ABS-Stnd';
			else if REAR_WHEEL_ABS    = "S" then grp_Brakes = 'ABS-Rear';
			else if FOUR_WHEEL_ABS       = "O" or REAR_WHEEL_ABS = "O" then grp_Brakes = 'ABS-Opt';
			else if stability_control = "NA" or FOUR_WHEEL_ABS    = "NA" or REAR_WHEEL_ABS = "NA" then grp_Brakes = 'NA';
			else                                                                           grp_Brakes = 'NA';


		*This is new.;
			if 	   FRONTSD_DRV_AB_CHESTMOUNT_DOOR="S" or FRONTSD_DRV_AB_CHESTMOUNT_SEAT="S" 
				or FRONTSD_DRV_AB_HEADMOUNT_DOOR ="S" or FRONTSD_DRV_AB_HEADMOUNT_SEAT ="S" 
				or FRONTSD_DRV_AB_HEADMOUNT_ROOF ="S" then Airbag_Drv = 'Side-S';
			else if FRONTSD_DRV_AB_CHESTMOUNT_DOOR="O" or FRONTSD_DRV_AB_CHESTMOUNT_SEAT="O" 
				or FRONTSD_DRV_AB_HEADMOUNT_DOOR ="O" or FRONTSD_DRV_AB_HEADMOUNT_SEAT ="O" 
			    or FRONTSD_DRV_AB_HEADMOUNT_ROOF ="O" then Airbag_Drv = 'Side-O';
			else if FRONT_DRV_AB = "S" then Airbag_Drv = 'Front-S';
			else if FRONT_DRV_AB = "O" then Airbag_Drv = 'Front-O';
			else if FRONT_DRV_AB = "NA" then Airbag_Drv = 'NA';
			else                                      Airbag_Drv = 'UN';

			*This is new;
			if 	   FRONTSD_PAS_AB_CHESTMOUNT_DOOR="S" or FRONTSD_PAS_AB_CHESTMOUNT_SEAT="S" 
				or FRONTSD_PAS_AB_HEADMOUNT_DOOR ="S" or FRONTSD_PAS_AB_HEADMOUNT_SEAT ="S" 
				or FRONTSD_PAS_AB_HEADMOUNT_ROOF ="S" then airbag_pass = 'Side-S';
			else if FRONTSD_PAS_AB_CHESTMOUNT_DOOR="O" or FRONTSD_PAS_AB_CHESTMOUNT_SEAT="O" 
				or FRONTSD_PAS_AB_HEADMOUNT_DOOR ="O" or FRONTSD_PAS_AB_HEADMOUNT_SEAT ="O" 
			    or FRONTSD_PAS_AB_HEADMOUNT_ROOF ="O" then airbag_pass = 'Side-O';
			else if FRONT_PAS_AB = "S" then airbag_pass = 'Front-S';
			else if FRONT_PAS_AB = "O" then airbag_pass = 'Front-O';
			else if FRONT_PAS_AB = "NA" then airbag_pass = 'NA';
			else                                      airbag_pass = 'UN';
					
			if 		rear_side_ab_chest_mount_door="S" or rear_side_ab_chest_mount_seat="S" 
				 or rear_side_ab_head_mount_door ="S" or rear_side_ab_head_mount_seat ="S" 
				 or rear_side_ab_head_mount_roof ="S" then airbag_second_row = "S";
			else if rear_side_ab_chest_mount_door="O" or rear_side_ab_chest_mount_seat="O" 
				 or rear_side_ab_head_mount_door ="O" or rear_side_ab_head_mount_seat ="O" 
				 or rear_side_ab_head_mount_roof ="O" then airbag_second_row = "O";
			else if rear_side_ab_chest_mount_door = "NA" or rear_side_ab_chest_mount_seat = "NA"
				 or rear_side_ab_head_mount_door = "NA" or rear_side_ab_head_mount_seat = "NA"
				 or rear_side_ab_head_mount_roof = "NA" then airbag_second_row = "NA";
			else                                                airbag_second_row = 'UN';

			if 		thrd_side_ab_chest_mount_door="S" or thrd_side_ab_chest_mount_seat="S" 
				 or thrd_side_ab_head_mount_door ="S" or thrd_side_ab_head_mount_seat ="S" 
				 or thrd_side_ab_head_mount_roof ="S" then airbag_third_row = "S";
			else if thrd_side_ab_chest_mount_door="O" or thrd_side_ab_chest_mount_seat="O" 
				 or thrd_side_ab_head_mount_door ="O" or thrd_side_ab_head_mount_seat ="O" 
				 or thrd_side_ab_head_mount_roof ="O" then airbag_third_row = "O";
			else if thrd_side_ab_chest_mount_door = "NA" or thrd_side_ab_chest_mount_seat = "NA"
				 or thrd_side_ab_head_mount_door = "NA" or thrd_side_ab_head_mount_seat = "NA"
				 or thrd_side_ab_head_mount_roof = "NA" then airbag_third_row = "NA";
			else                                                airbag_third_row = 'UN';

			airbag = compress(trim(airbag_drv||"/"||airbag_pass||"/"||airbag_second_row||"/"||airbag_third_row),"");

			*Decode all the new HLDI features flags.;
			if      Body_Construction_ID = "UNI" then Body_Construction = 'Unibody';
			else if Body_Construction_ID = "BOF" then Body_Construction = 'Body-on-Frame';
			else if Body_Construction_ID = "UN" then Body_Construction = 'UN';
			else  										Body_Construction = 'UN';

			IF Body_Construction = "UN" then grp_Body_Construct_COLCMP = "Unibody"; else grp_Body_Construct_COLCMP = Body_Construction;

			Door_Count=Door_ID;
			Drive_Type = Drive_Type_ID;

			if Drive_Type = "2WD" then grp_Drive_type = "Two_WD";
			else if Drive_Type = "4WD" then grp_Drive_type = "Four_WD";
			else 						grp_Drive_type = "Two_WD";

			Adaptive_Cruise_Ctrl = ADAPT_CRUISE_CONTROL;
			Adaptive_Cruise_Ctrl_Stop = ADAPT_CRUISE_CONTROL_STOP;
			Blind_Spot_Warning = BLIND_SPOT_WARN;
			Blind_Spot_Stop = BLIND_SPOT_PREVENT;
			Lane_Departure_Warn = LANE_DEPART_WARN;
			Lane_Departure_Prevent = LANE_DEPART_PREVENT;
			Forward_Coll_Warn = FWD_COLL_WARN;
			Forward_Coll_Brake = FWD_COLL_WARN_AUTO_BRAKE;
			Adaptive_Headlights = ADAPT_HEADLIGHTS_CURVE;
			Adaptive_Brakelights = ADAPT_BRAKELIGHTS;
			Night_Vis = NIGHT_VISION;
			Driver_Alertness_Monitor = DRVR_ALERT_MONITOR;
			Low_Spd_Coll_Prevent = COLL_PREVENT_LOW_SPD;
			Front_Park_Sensor = PARK_SNSR_FRONT;
			Rear_Park_Sensor = PARK_SNSR_REAR;
			Rear_Park_Camera = PARK_CAMERA_REAR;
			Full_Park_Camera = PARK_CAMERA_FULL;
			Parking_Assist = PARK_ASST;
			Adaptive_Highbeams = ADAPT_HIGHBEAMS;
			Adaptive_Cruise_Ctrl_Lane_Center = ADAPT_CRUISE_CONTROL_lane_ctr;
			Full_Park_Camera_wide = PARK_CAMERA_REAR_WIDE;
			CrossTrafficCamera_front = ADAPT_CRUISE_CONTROL;
			CrossTrafficWarning_Rear = Cross_Traffic_Rear;

			if Adaptive_Cruise_Ctrl = "S" or Adaptive_Cruise_Ctrl_Lane_Center = "S" or Adaptive_Cruise_Ctrl_Stop = "S" then grp_Adaptive_Cruise_ctrl = "S";
			else if Adaptive_Cruise_Ctrl = "NA" and Adaptive_Cruise_Ctrl_Lane_Center = "NA" and Adaptive_Cruise_Ctrl_Stop = "NA" then grp_Adaptive_Cruise_ctrl = "Not_Avail";
			else																													grp_Adaptive_Cruise_ctrl = "O";

			if 	CrossTrafficCamera_front= "S" or CrossTrafficWarning_Rear= "S" or Front_Park_Sensor= "S" or 
				Full_Park_Camera= "S" or Full_Park_Camera_wide= "S" or Parking_Assist= "S" or Rear_Park_Camera= "S" or 
				Rear_Park_Sensor= "S" then grp_Cam_Sensor = "S";
			else if CrossTrafficCamera_front= "NA" and CrossTrafficWarning_Rear= "NA" and Front_Park_Sensor= "NA" and 
				Full_Park_Camera= "NA" and Full_Park_Camera_wide= "NA" and Parking_Assist= "NA" and Rear_Park_Camera= "NA" and 
				Rear_Park_Sensor= "NA" then grp_Cam_Sensor = "Not_Avail";
			else							grp_Cam_Sensor = "O";

				 if Blind_Spot_Stop = "S" or Blind_Spot_Warning = "S" then grp_Blind_Spot = "S";
			else if Blind_Spot_Stop = "NA" and Blind_Spot_Warning = "NA" then grp_Blind_Spot = "Not_Avail";
			else							grp_Blind_Spot = "O";


			if Forward_Coll_Brake = "S" or Forward_Coll_Warn = "S" or Low_SPD_Coll_Prevent = "S" then grp_Accident_avoidance = "S";
			else if Forward_Coll_Brake = "NA" and Forward_Coll_Warn = "NA" and Low_SPD_Coll_Prevent = "NA" then grp_Accident_avoidance = "Not_Avail";
			else							grp_Accident_avoidance = "O";


				 if Lane_Departure_Prevent= "S" or Lane_Departure_Warn= "S" then grp_Lane_Depart = "S";
			else if Lane_Departure_Prevent= "NA" and Lane_Departure_Warn= "NA" then grp_Lane_Depart = "Not_Avail";
			else							grp_Lane_Depart = "O";

				*PD_AdaptiveCruise_AccAvoid  ;
				 if grp_Accident_avoidance= "S" or grp_Adaptive_Cruise_ctrl= "S" then grp_AdaptiveCruise_AccAvoid = "S";
			else if grp_Accident_avoidance= "Not_Avail" and grp_Adaptive_Cruise_ctrl= "Not_Avail" then grp_AdaptiveCruise_AccAvoid = "Not_Avail";
			else							grp_AdaptiveCruise_AccAvoid = "O";

			*grp_BlindSpot_LaneDept;
				 if grp_Blind_Spot= "S" or grp_Lane_Depart= "S" then grp_BlindSpot_LaneDept = "S";
			else if grp_Blind_Spot= "Not_Avail" and grp_Lane_Depart= "Not_Avail" then grp_BlindSpot_LaneDept = "Not_Avail";
			else							grp_BlindSpot_LaneDept = "O";



	*Manual corrections;
				 if MAKE_GRP = ''     then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = '12D'  then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'AUST' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'BUIK' then MAKE_GRP = 'BUIC';
			else if MAKE_GRP = 'CADD' then MAKE_GRP = 'CADI';
			else if MAKE_GRP = 'CHE'  then MAKE_GRP = 'CHEV';
			else if MAKE_GRP = 'CHEC' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'CHOO' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'COCL' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'COLT' then MAKE_GRP = 'DODG';
			else if MAKE_GRP = 'Choo' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'DATS' then MAKE_GRP = 'DAT';
			else if MAKE_GRP = 'DUES' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'FRE'  then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'HUMM' then MAKE_GRP = 'AMGL';
			else if MAKE_GRP = 'IHC'  then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'INTL' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'ISUZ' then MAKE_GRP = 'ISZU';
			else if MAKE_GRP = 'LEXU' then MAKE_GRP = 'LEXS';
			else if MAKE_GRP = 'MAC'  then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'MG'   then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'MRCY' then MAKE_GRP = 'MERC';
			else if MAKE_GRP = 'NISS' then MAKE_GRP = 'NSSN';
			else if MAKE_GRP = 'NSSA' then MAKE_GRP = 'NSSN';
			else if MAKE_GRP = 'OPEL' then MAKE_GRP = 'OTHR';
			else if MAKE_GRP = 'ROL'  then MAKE_GRP = 'ROLL';
			else if MAKE_GRP = 'SATU' then MAKE_GRP = 'SATN';
			else if MAKE_GRP = 'TOYO' then MAKE_GRP = 'TYTA';
			else if MAKE_GRP = 'VOL'  then MAKE_GRP = 'VLVO';
			else if MAKE_GRP = 'VOLK' then MAKE_GRP = 'VLKS';
			else if MAKE_GRP = 'VOLV' then MAKE_GRP = 'VLVO';
			else if MAKE_GRP = 'VW'   then MAKE_GRP = 'VLKS';
			else if MAKE_GRP = 'WIL'  then MAKE_GRP = 'OTHR';

	if model_name in ('!' '+' '+/!/SPORT') then model_name = "Sport";
	if model_name in ('(HAWAII)') then model_name = "HAWAII";
RUN;


/*Delete datasets to free up space and for clarity - comment out to keep & troubleshoot*/
proc delete data=
work.VCP_STEP01
;run;



%MEND VCP_MAPPING;

%VCP_MAPPING(
INPUT_DATA = work.&state._Rate_Car01
,OUTPUT_DATA = work.&state._Rate_Car02
,VIN_JOIN_VAR = VIN
,YEAR_JOIN_VAR = Year
,MAKE_JOIN_VAR =Maker
);
