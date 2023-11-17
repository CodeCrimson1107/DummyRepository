SELECT
   PolicyLinkID,
   Company_Group,
   rateid,
   AVG(TotalPremium_Term_Adj)
   rowasc,RowDesc
FROM
(
   SELECT
      PolicyLinkID,
	  Company_Group,
	  Company_Group as CMP_Filt,
	  rateid,
      TotalPremium_Term_Adj,
      -- company_group in the ORDER BY is a disambiguator to break ties
      ROW_NUMBER() OVER (
         PARTITION BY PolicyLinkID
         ORDER BY TotalPremium_Term_Adj ASC, company_group ASC) AS RowAsc,
      ROW_NUMBER() OVER (
         PARTITION BY PolicyLinkID
         ORDER BY TotalPremium_Term_Adj DESC, company_group DESC) AS RowDesc
   FROM dbo.MB_FULL_NM SOH
) x
WHERE PolicyLinkID = 13338165 and
   RowAsc IN (RowDesc, RowDesc - 1, RowDesc + 1) 
   --Company_Group <> CMP_Filt
GROUP BY PolicyLinkID,RateId,Company_Group,rowasc,RowDesc
ORDER BY PolicyLinkID desc;