SELECT 
 RTRIM("Agent Code")	"Agent Code"
,RTRIM("Group Code")	"Group Code"
,RTRIM("Agent Name")	"Agent Name"
,RTRIM("Commission From Date")	"Commission From Date"
,RTRIM("Commission To Date")	"Commission To Date"
,RTRIM("State")	"State"
,RTRIM("Policy #")	"Policy #"
,RTRIM("Insured Name")	"Insured Name"
,RTRIM("Policy Effective Date")	"Policy Effective Date"
,RTRIM("Commission Type")	"Commission Type"
,RTRIM("Transaction Date")	"Transaction Date"
,RTRIM("Transaction Type")	"Transaction Type"
,RTRIM("Commission Premium")	"Commission Premium"
,RTRIM("Commission Percentage")	"Commission Percentage"
,RTRIM("Commission Amount")	"Commission Amount"
,RTRIM("Activity Type")	"Activity Type"
,RTRIM("Endo Seq") "Endo Seq"
FROM OPENQUERY(DRAGON,'
SELECT 
 VCD_CONTR_CODE	"Agent Code"
,VCD_GROUP_CODE	"Group Code"
,VCD_AGENT_NAME	"Agent Name"
,VCD_FROM_DATE	"Commission From Date"
,VCD_TO_DATE	"Commission To Date"
,VCD_ADD_ST		"State"
,VCD_POLICY	    "Policy #"
,VCD_INS_NAM	"Insured Name"
,VCD_POL_EFF	"Policy Effective Date"
,VCD_POM_TYP	"Commission Type"
,VCD_TRANS_DATE	"Transaction Date"
,VCD_TRANS_TYPE	"Transaction Type"
,VCD_APPTOVALUE	"Commission Premium"
,VCD_COM_PER	"Commission Percentage"
,VCD_COM_AMOUNT	"Commission Amount"
,VCD_ENDO_CODE  "Endo Seq"
,CASE	 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Cancellation'' THEN ''CAN''
	     WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Prem - Comm. Chargeback'' THEN ''CCB''
		 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''NSF Adjustments'' THEN ''NSF''
		 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Reinstatement'' THEN ''REN''
		 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Report Order Charge Backs'' THEN ''MVR''
		 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_POM_TYP    = ''Adjustment'' THEN ''ADJ''
		 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''OPENING BALANCE'' THEN ''OPENING BALANCE''
		 WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Commissions - Endorsement'' THEN ''END''
		WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Chargebacks - Endorsement'' THEN ''END''
		WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Regular Commission'' 
					AND SUBSTRING(VCD_POLICY,14,2) = ''00''
					AND VCD_ENDO_CODE = ''0000'' THEN ''NEW''
		WHEN VCD_ACT_TYPE = '' '' 
					AND VCD_TRANS_TYPE = ''Regular Commission'' 
					AND SUBSTRING(VCD_POLICY,14,2) != ''00''
					AND VCD_ENDO_CODE = ''0000'' THEN ''REN''
		ELSE VCD_ACT_TYPE END "Activity Type"

FROM LDSNEWFIL.VUCOMDETPF
WHERE 1=1
AND VCD_GROUP_CODE IN (''ACCEPT'', ''ACCPTC'', ''ACPTCC'', ''GAZ225'', ''GGA057'', ''GNM225'', ''GSC200'', ''GTX225'',''ACPTAL'')
ORDER BY 1,7 DESC
')

