USE [Construct]
GO

/****** Object:  UserDefinedFunction [dbo].[Search_Diamond]    Script Date: 4/4/2025 2:33:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Search_Diamond](@search_column varchar(max), @exclude_column varchar(max), @search_table varchar(max), @exclude_table varchar(max))
RETURNS TABLE
AS
RETURN

SELECT
	TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME [TABLE_NAME],
	[ORDINAL_POSITION],
	[COLUMN_NAME],
	[DATA_TYPE],
	[CHARACTER_MAXIMUM_LENGTH],
	[NUMERIC_PRECISION],
	[NUMERIC_SCALE],
	[DOMAIN_NAME],
	'SELECT TOP 1000 ' + COLUMN_NAME + ', * FROM ' + TABLE_CATALOG + '.' + TABLE_SCHEMA + '.' + TABLE_NAME [QUERY]
FROM
	Diamond.INFORMATION_SCHEMA.COLUMNS 
WHERE
	1 = (CASE
		WHEN @search_column = '' and @search_table = '' THEN 0
		ELSE 1
		END)
	and 1 =
		(CASE
			WHEN @search_column = '' THEN 1
			WHEN COLUMN_NAME like @search_column THEN 1
			ELSE 0
			END)
	and 1 =
		(CASE
			WHEN @exclude_column = '' THEN 1
			WHEN COLUMN_NAME like @exclude_column THEN 0
			ELSE 1
			END)
	and 1 =
		(CASE
			WHEN @search_table = '' THEN 1
			WHEN TABLE_NAME like @search_table THEN 1
			ELSE 0
			END)
	and 1 =
		(CASE
			WHEN @exclude_table = '' THEN 1
			WHEN TABLE_NAME like @exclude_table THEN 0
			ELSE 1
			END)
;
GO


