USE [Construct]
GO

/****** Object:  StoredProcedure [dbo].[IFPolicyList]    Script Date: 4/4/2025 2:28:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Stephen Ger
-- Create date: 2016-08-02
-- Description:	In-Force Policy List using Diamond in AHI-S06 v1
-- Edit Date: 2017-05-22
-- =============================================
CREATE PROCEDURE [dbo].[IFPolicyList] 
	@sp_IFD date = null, --Runs query for given date at beginning of the day, 12:00 AM midnight
	@sp_state varchar(2) = '', --Select a state using abbreviation such as 'TX'
	@sp_lob int = 0  --1 for Auto, 2 for Renters, 0 for Both
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	/*** Stephen's Inforce list ***/
	SET @sp_IFD = ISNULL(nullif(@sp_IFD,''),GETDATE())
	DECLARE @sp_SD date = dateadd(dd,-1,@sp_ifd) --don't touch
	DECLARE @sp_ED date = dateadd(dd,1,@sp_ifd) --don't touch


	--gathers all transactions for auto policies before @sp_ED
	SELECT
		vp.policy,
		vp.policy_id,
		vp.policyimage_num,
		vp.premium_fullterm,
		CASE
			WHEN vp.transtype_id = 1 THEN 1
			ELSE 0
			END cancelled,
		vp.teff_date,
		vp.texp_date,
		vp.exp_date,
		(SELECT
			MIN(a.policyimage_num)
			FROM
				Diamond.dbo.vpolicyimagexml a
			WHERE
				a.policy_id = vp.policy_id
				and a.policyimage_num > vp.policyimage_num
				and a.policystatuscode_id not in (4, 5, 8, 9, 10, 11, 12, 13, 14) --Pending P, Renewal Offer O, Pending OOS Q, Reapplied R, Void Due to OOS Cancel X, Offset Due to OOS Cancel Z, Quote QT, Archived Quote AQ, Renewal Underwriting U
				and a.premium_fullterm <> 0
				and a.teff_date <> a.texp_date
			) next_policyimage_num,
		(SELECT
			MIN(a.teff_date)
			FROM
				Diamond.dbo.vpolicyimagexml a
			WHERE
				a.policy_id = vp.policy_id
				and a.policyimage_num < vp.policyimage_num
				and a.transtype_id = 1 --cancel
				and a.policystatuscode_id not in (4, 5, 8, 9, 10, 11, 12, 13, 14) --Pending P, Renewal Offer O, Pending OOS Q, Reapplied R, Void Due to OOS Cancel X, Offset Due to OOS Cancel Z, Quote QT, Archived Quote AQ, Renewal Underwriting U
				and a.premium_fullterm <> 0
				and a.teff_date <> a.texp_date
			) next_cxl_date
	INTO #sp_prePolicyList1
	FROM
		Diamond.dbo.vpolicyimageXML vp
  		LEFT JOIN Diamond.dbo.Version v on v.version_id=vp.version_id
		LEFT JOIN Diamond.dbo.vCompanyStateLOB csl on csl.companystatelob_id=v.companystatelob_id
		LEFT JOIN Diamond.dbo.CompanyState cs on cs.companystate_id=csl.companystate_id
		LEFT JOIN Diamond.dbo.CompanyLOB CL ON CL.companylob_id = CSL.companylob_id
		LEFT JOIN Diamond.dbo.Lob LOB ON CL.lob_id = LOB.lob_id
		LEFT JOIN Diamond.dbo.State s on cs.state_id = s.state_id
	WHERE
		vp.teff_date < @sp_ED --transactions happen before @sp_ED
		and vp.policystatuscode_id not in (4, 5, 8, 9, 10, 11, 12, 13, 14) --Pending P, Renewal Offer O, Pending OOS Q, Reapplied R, Void Due to OOS Cancel X, Offset Due to OOS Cancel Z, Quote QT, Archived Quote AQ, Renewal Underwriting U
		and vp.premium_fullterm <> 0
		and vp.teff_date <> vp.texp_date
		and vp.agency_id not in (select distinct agency_id from product_dsql2.dbo.test_agency_index)
		and 1 = (CASE
					WHEN @sp_state = '' THEN 1
					WHEN s.state = @sp_state THEN 1
					ELSE 0
					END) --State selection
		and 1 = (CASE
					WHEN @sp_lob = 0 THEN 1
					WHEN lob.lob_id = @sp_lob THEN 1
					ELSE 0
					END) --LOB selection


	--Pulls in next teff/texp/exp dates
	SELECT
		r.policy,
		r.policy_id,
		r.policyimage_num,
		r.premium_fullterm,
		r.cancelled,
		r.teff_date,
		r.texp_date,
		r.exp_date,
		r.next_policyimage_num,
		vp2.teff_date next_teff_date,
		vp2.texp_date next_texp_date,
		vp2.exp_date next_exp_date,
		r.next_cxl_date
	INTO #sp_prePolicyList2
	FROM
		#sp_prePolicyList1 r	 
		--LEFT JOIN Diamond.dbo.vpolicyimagexml vp1
		--	on r.policy_id = vp1.policy_id
		--	and r.last_policyimage_num = vp1.policyimage_num
		LEFT JOIN Diamond.dbo.vpolicyimagexml vp2
			on r.policy_id = vp2.policy_id
			and r.next_policyimage_num = vp2.policyimage_num




	--Chooses exposure begDate and endDate
	SELECT
		r.policy,
		r.policy_id,
		r.policyimage_num,
		r.premium_fullterm,
		r.cancelled,
		r.teff_date,
		r.texp_date,
		r.exp_date,
		r.next_policyimage_num,
		r.next_teff_date,
		r.next_texp_date,
		r.next_exp_date,
		r.next_cxl_date,
		CASE
			WHEN r.teff_date <= @sp_SD THEN @sp_SD
			ELSE r.teff_date
			END begDate,
		CASE
			WHEN r.cancelled = 1 THEN (CASE
				WHEN r.teff_date <= @sp_SD THEN @sp_SD
				ELSE r.teff_date
				END) --if cancelled, then set endDate = startDate
			WHEN (CASE
				WHEN r.texp_date <= ISNULL(r.next_teff_date, @sp_ED) and r.texp_date <= ISNULL(r.next_cxl_date, @sp_ED) THEN r.texp_date
				WHEN ISNULL(r.next_teff_date, @sp_ED) <= r.texp_date and ISNULL(r.next_teff_date, @sp_ED) <= ISNULL(r.next_cxl_date, @sp_ED) THEN ISNULL(r.next_teff_date, @sp_ED)
				ELSE ISNULL(r.next_cxl_date, @sp_ED)
				END) >= @sp_ED THEN @sp_ED --if least of texp_date/next_teff_date/next_cxl_date after @sp_ED then set @sp_ED as endDate
			WHEN (CASE
				WHEN r.texp_date <= ISNULL(r.next_teff_date, @sp_ED) and r.texp_date <= ISNULL(r.next_cxl_date, @sp_ED) THEN r.texp_date
				WHEN ISNULL(r.next_teff_date, @sp_ED) <= r.texp_date and ISNULL(r.next_teff_date, @sp_ED) <= ISNULL(r.next_cxl_date, @sp_ED) THEN ISNULL(r.next_teff_date, @sp_ED)
				ELSE ISNULL(r.next_cxl_date, @sp_ED)
				END) <= @sp_SD THEN @sp_SD --if least of texp_date/next_teff_date/next_cxl_date before @sp_SD then set @sp_SD as endDate
			ELSE (CASE
				WHEN r.texp_date <= ISNULL(r.next_teff_date, @sp_ED) and r.texp_date <= ISNULL(r.next_cxl_date, @sp_ED) THEN r.texp_date
				WHEN ISNULL(r.next_teff_date, @sp_ED) <= r.texp_date and ISNULL(r.next_teff_date, @sp_ED) <= ISNULL(r.next_cxl_date, @sp_ED) THEN ISNULL(r.next_teff_date, @sp_ED)
				ELSE ISNULL(r.next_cxl_date, @sp_ED)
				END) --else set least of texp_date/next_teff_date/next_cxl_date as endDate
			END endDate
	INTO #sp_prePolicyList3
	FROM
		#sp_prePolicyList2 r




	--Creates policylist
	SELECT
	distinct
		r.policy_id,
		min(r.policyimage_num) policyimage_num
	INTO #sp_PolicyList
	FROM
		#sp_prePolicyList3 r
	WHERE
		@sp_ifd > r.begDate
		and @sp_ifd <= r.endDate
	GROUP BY
		r.policy,
		r.policy_id
	order by policy_id, policyimage_num




	select * from #sp_policylist




	drop table #sp_prePolicyList1
	drop table #sp_prePolicyList2
	drop table #sp_prePolicyList3
	drop table #sp_policylist
	

END

GO


