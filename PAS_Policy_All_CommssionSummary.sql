
SELECT   
		 Ag.Name AS [AGENCY NAME]
		,CA.AgentReference AS [Agency ID]
		,A.AccountReference AS [PolicyNumber]
		,A.CreationDate AS [Account Creation Date]
		,CA.AuthorizedAmount AS [Commission Amount]
		,CA.PlanId AS [CommissionPlan ID]
		,P.UserKey1 AS [Commission User Key]
		,CA.BillItemId AS [Bill Item]
		,CA.TierAmount AS [Item Amount]
		,BI.TransactionTypeCode AS [Transaction Type]
		,BI.ReceivableTypeCode AS [Receivable Type]		
	 FROM DC_BIL_CommissionAuthorization CA WITH(NoLock)
	 LEFT JOIN DC_PLT_Plan P WITH(NoLock) ON CA.PlanId = P.PlanId
	 LEFT JOIN DC_BIL_Account A WITH(NoLock) ON A.AccountId=CA.AccountId
	 LEFT JOIN Agency Ag WITH(NoLock) ON AG.AgencyID = CA.AgentReference
	 LEFT JOIN DC_BIL_BillItem BI WITH(NoLock) ON BI.ItemId = Ca.BillItemId 
	 WHERE 1=1
		AND A.CreationDate > '2021-12-01 00:00:00' 
		AND CA.AuthorizationDate > '2021-12-00 00:00:00' 
		AND CA.CommissionType <> 'NULL' 
	 ; 
