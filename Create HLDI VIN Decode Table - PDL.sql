USE [HLDI - Highway Loss Data Institute]
GO

/****** Object:  View [dbo].[v_VIN_Detail_BI]    Script Date: 4/10/2025 9:43:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[v_VIN_Detail_PDL] as (

	--PDL_2018
	select 
		'PDL' [COV]
		,PD18.modelYear,	PD18.calendarYear,	PD18.makeNumber,	PD18.seriesNumber,	PD18.modelNumber,	PD18.engineNumber,	PD18.vin_pat,	PD18.decode,	PD18.state,	PD18.zip,	PD18.zipStateMatch,	PD18.density,	PD18.risk,	PD18.yob,	PD18.age,	PD18.age_code_id,	PD18.gender,	PD18.marital,	PD18.days,	PD18.claims,	PD18.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2018_1024 PD18 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD18.vin_pat 
		and V8.ModelYear = PD18.modelYear 
		and V8.MakeNumber = PD18.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD18.modelYear,	PD18.calendarYear,	PD18.makeNumber,	PD18.seriesNumber,	PD18.modelNumber,	PD18.engineNumber,	PD18.vin_pat,	PD18.decode,	PD18.state,	PD18.zip,	PD18.zipStateMatch,	PD18.density,	PD18.risk,	PD18.yob,	PD18.age,	PD18.age_code_id,	PD18.gender,	PD18.marital,	PD18.days,	PD18.claims,	PD18.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2018_1024 PD18 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD18.vin_pat 
		and V11.ModelYear = PD18.modelYear 
		and V11.MakeNumber = PD18.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11

	union all 

	--PDL_2019

	select 
		'PDL' [COV]
		,PD19.modelYear,	PD19.calendarYear,	PD19.makeNumber,	PD19.seriesNumber,	PD19.modelNumber,	PD19.engineNumber,	PD19.vin_pat,	PD19.decode,	PD19.state,	PD19.zip,	PD19.zipStateMatch,	PD19.density,	PD19.risk,	PD19.yob,	PD19.age,	PD19.age_code_id,	PD19.gender,	PD19.marital,	PD19.days,	PD19.claims,	PD19.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2019_1024 PD19 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD19.vin_pat 
		and V8.ModelYear = PD19.modelYear 
		and V8.MakeNumber = PD19.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD19.modelYear,	PD19.calendarYear,	PD19.makeNumber,	PD19.seriesNumber,	PD19.modelNumber,	PD19.engineNumber,	PD19.vin_pat,	PD19.decode,	PD19.state,	PD19.zip,	PD19.zipStateMatch,	PD19.density,	PD19.risk,	PD19.yob,	PD19.age,	PD19.age_code_id,	PD19.gender,	PD19.marital,	PD19.days,	PD19.claims,	PD19.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2019_1024 PD19 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD19.vin_pat 
		and V11.ModelYear = PD19.modelYear 
		and V11.MakeNumber = PD19.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11

	union all 

	--PDL_2020
	select 
		'PDL' [COV]
		,PD20.modelYear,	PD20.calendarYear,	PD20.makeNumber,	PD20.seriesNumber,	PD20.modelNumber,	PD20.engineNumber,	PD20.vin_pat,	PD20.decode,	PD20.state,	PD20.zip,	PD20.zipStateMatch,	PD20.density,	PD20.risk,	PD20.yob,	PD20.age,	PD20.age_code_id,	PD20.gender,	PD20.marital,	PD20.days,	PD20.claims,	PD20.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2020_1024 PD20 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD20.vin_pat 
		and V8.ModelYear = PD20.modelYear 
		and V8.MakeNumber = PD20.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD20.modelYear,	PD20.calendarYear,	PD20.makeNumber,	PD20.seriesNumber,	PD20.modelNumber,	PD20.engineNumber,	PD20.vin_pat,	PD20.decode,	PD20.state,	PD20.zip,	PD20.zipStateMatch,	PD20.density,	PD20.risk,	PD20.yob,	PD20.age,	PD20.age_code_id,	PD20.gender,	PD20.marital,	PD20.days,	PD20.claims,	PD20.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2020_1024 PD20 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD20.vin_pat 
		and V11.ModelYear = PD20.modelYear 
		and V11.MakeNumber = PD20.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11

	union all

	--PDL_2021
	select 
		'PDL' [COV]
		,PD21.modelYear,	PD21.calendarYear,	PD21.makeNumber,	PD21.seriesNumber,	PD21.modelNumber,	PD21.engineNumber,	PD21.vin_pat,	PD21.decode,	PD21.state,	PD21.zip,	PD21.zipStateMatch,	PD21.density,	PD21.risk,	PD21.yob,	PD21.age,	PD21.age_code_id,	PD21.gender,	PD21.marital,	PD21.days,	PD21.claims,	PD21.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2021_1024 PD21 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD21.vin_pat 
		and V8.ModelYear = PD21.modelYear 
		and V8.MakeNumber = PD21.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD21.modelYear,	PD21.calendarYear,	PD21.makeNumber,	PD21.seriesNumber,	PD21.modelNumber,	PD21.engineNumber,	PD21.vin_pat,	PD21.decode,	PD21.state,	PD21.zip,	PD21.zipStateMatch,	PD21.density,	PD21.risk,	PD21.yob,	PD21.age,	PD21.age_code_id,	PD21.gender,	PD21.marital,	PD21.days,	PD21.claims,	PD21.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2021_1024 PD21 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD21.vin_pat 
		and V11.ModelYear = PD21.modelYear 
		and V11.MakeNumber = PD21.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11

	union all 

	--PDL_2022
	select 
		'PDL' [COV]
		,PD22.modelYear,	PD22.calendarYear,	PD22.makeNumber,	PD22.seriesNumber,	PD22.modelNumber,	PD22.engineNumber,	PD22.vin_pat,	PD22.decode,	PD22.state,	PD22.zip,	PD22.zipStateMatch,	PD22.density,	PD22.risk,	PD22.yob,	PD22.age,	PD22.age_code_id,	PD22.gender,	PD22.marital,	PD22.days,	PD22.claims,	PD22.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2022_1024 PD22 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD22.vin_pat 
		and V8.ModelYear = PD22.modelYear 
		and V8.MakeNumber = PD22.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD22.modelYear,	PD22.calendarYear,	PD22.makeNumber,	PD22.seriesNumber,	PD22.modelNumber,	PD22.engineNumber,	PD22.vin_pat,	PD22.decode,	PD22.state,	PD22.zip,	PD22.zipStateMatch,	PD22.density,	PD22.risk,	PD22.yob,	PD22.age,	PD22.age_code_id,	PD22.gender,	PD22.marital,	PD22.days,	PD22.claims,	PD22.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2022_1024 PD22 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD22.vin_pat 
		and V11.ModelYear = PD22.modelYear 
		and V11.MakeNumber = PD22.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11

	union all 

	--PDL_2023
	select 
		'PDL' [COV]
		,PD23.modelYear,	PD23.calendarYear,	PD23.makeNumber,	PD23.seriesNumber,	PD23.modelNumber,	PD23.engineNumber,	PD23.vin_pat,	PD23.decode,	PD23.state,	PD23.zip,	PD23.zipStateMatch,	PD23.density,	PD23.risk,	PD23.yob,	PD23.age,	PD23.age_code_id,	PD23.gender,	PD23.marital,	PD23.days,	PD23.claims,	PD23.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2023_1024 PD23 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD23.vin_pat 
		and V8.ModelYear = PD23.modelYear 
		and V8.MakeNumber = PD23.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD23.modelYear,	PD23.calendarYear,	PD23.makeNumber,	PD23.seriesNumber,	PD23.modelNumber,	PD23.engineNumber,	PD23.vin_pat,	PD23.decode,	PD23.state,	PD23.zip,	PD23.zipStateMatch,	PD23.density,	PD23.risk,	PD23.yob,	PD23.age,	PD23.age_code_id,	PD23.gender,	PD23.marital,	PD23.days,	PD23.claims,	PD23.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2023_1024 PD23 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD23.vin_pat 
		and V11.ModelYear = PD23.modelYear 
		and V11.MakeNumber = PD23.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11

	union all 

	--PDL_2024
	select 
		'PDL' [COV]
		,PD24.modelYear,	PD24.calendarYear,	PD24.makeNumber,	PD24.seriesNumber,	PD24.modelNumber,	PD24.engineNumber,	PD24.vin_pat,	PD24.decode,	PD24.state,	PD24.zip,	PD24.zipStateMatch,	PD24.density,	PD24.risk,	PD24.yob,	PD24.age,	PD24.age_code_id,	PD24.gender,	PD24.marital,	PD24.days,	PD24.claims,	PD24.payments
		,V8.Pos1to8 [VinPos],V8.MakeName,V8.SeriesName,V8.ModelName,	V8.EngineName,	V8.MinHorse,	V8.MaxHorse,	V8.TransmissionName,	V8.EngineCylinders,	V8.EngineDisplacement,	V8.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2024_1024 PD24 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_8 V8 
		on V8.Pos1to8 = PD24.vin_pat 
		and V8.ModelYear = PD24.modelYear 
		and V8.MakeNumber = PD24.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC on 
		VSPEC.ModelYear = v8.ModelYear 
		and VSPEC.MakeNumber = V8.MakeNumber 
		and VSPEC.SeriesNumber = V8.SeriesNumber
	where decode = 8 

	union all 

	select 
		'PDL' [COV]
		,PD24.modelYear,	PD24.calendarYear,	PD24.makeNumber,	PD24.seriesNumber,	PD24.modelNumber,	PD24.engineNumber,	PD24.vin_pat,	PD24.decode,	PD24.state,	PD24.zip,	PD24.zipStateMatch,	PD24.density,	PD24.risk,	PD24.yob,	PD24.age,	PD24.age_code_id,	PD24.gender,	PD24.marital,	PD24.days,	PD24.claims,	PD24.payments
		,V11.Pos11 [VinPos], V11.MakeName,		V11.SeriesName,	V11.ModelName,	V11.EngineName,	V11.MinHorse,	V11.MaxHorse,	V11.TransmissionName,	V11.EngineCylinders,	V11.EngineDisplacement,	V11.PatPercent
		,VSPEC.VehicleClassId,	VSPEC.VehicleClassName,	VSPEC.VehicleSizeId,	VSPEC.VehicleSizeName,	VSPEC.CurbWeight,	VSPEC.Wheelbase,	VSPEC.Length,	VSPEC.Width,	VSPEC.Height,	VSPEC.BasePrice,	VSPEC.DoorID,	VSPEC.DriveTypeID,	VSPEC.BodyConstructionID,	VSPEC.GroundClearanceMin,	VSPEC.EPAMileageCity,	VSPEC.EPAMileageHighway,	VSPEC.EPAInteriorVolume,	VSPEC.EPALuggageVolume,	VSPEC.WebMakeName,	VSPEC.WebSeriesName,	VSPEC.SuperSeriesNumber,	VSPEC.SuperSeriesName,	VSPEC.RedesignYear
	from [HLDI - Highway Loss Data Institute].dbo.HLDI_PDL_2024_1024 PD24 
	left join [HLDI - Highway Loss Data Institute].dbo.VINPatterns_11 V11 
		on V11.Pos11 = PD24.vin_pat 
		and V11.ModelYear = PD24.modelYear 
		and V11.MakeNumber = PD24.makeNumber
	left join [HLDI - Highway Loss Data Institute].dbo.VehicleSpecsMaster VSPEC 
		on VSPEC.ModelYear = V11.ModelYear 
		and VSPEC.MakeNumber = V11.MakeNumber 
		and VSPEC.SeriesNumber = V11.SeriesNumber
	where decode = 11
)

GO


