SELECT 
 RTRIM("Agent Code") "Agent Code"
,RTRIM("Group Code") "Group Code"
,RTRIM("Agent Name") "Agent Name"
,RTRIM("Commission From Date")    "Commission From Date"
,RTRIM("Commission To Date")      "Commission To Date"
,RTRIM("State")      "State"
,RTRIM("Policy #")   "Policy #"
,RTRIM("Insured Name")     "Insured Name"
,RTRIM("Policy Effective Date")   "Policy Effective Date"
,RTRIM("Commission Type")  "Commission Type"
,RTRIM("Transaction Date") "Transaction Date"
,RTRIM("Transaction Type") "Transaction Type"
,RTRIM("Commission Premium")      "Commission Premium"
,RTRIM("Commission Percentage")   "Commission Percentage"
,RTRIM("Commission Amount") "Commission Amount"
,RTRIM("Activity Type")    "Activity Type"
,RTRIM("Endo Seq") "Endo Seq"
FROM OPENQUERY(DRAGON,'
SELECT 
 VCH_CONTR_CODE      "Agent Code"
,VCH_GROUP_CODE      "Group Code"
,VCH_AGENT_NAME      "Agent Name"
,VCH_FROM_DATE       "Commission From Date"
,VCH_TO_DATE  "Commission To Date"
,VCH_ADD_ST          "State"
,VCH_POLICY       "Policy #"
,VCH_INS_NAM  "Insured Name"
,VCH_POL_EFF  "Policy Effective Date"
,VCH_POM_TYP  "Commission Type"
,VCH_TRANS_DATE      "Transaction Date"
,VCH_TRANS_TYPE      "Transaction Type"
,VCH_APPTOVALUE      "Commission Premium"
,VCH_COM_PER  "Commission Percentage"
,VCH_COM_AMOUNT      "Commission Amount"
,VCH_ENDO_CODE  "Endo Seq"
,CASE  WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Cancellation'' THEN ''CAN''
            WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Prem - Comm. Chargeback'' THEN ''CCB''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''NSF Adjustments'' THEN ''NSF''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Reinstatement'' THEN ''REN''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Report Order Charge Backs'' THEN ''MVR''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_POM_TYP    = ''Adjustment'' THEN ''ADJ''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''OPENING BALANCE'' THEN ''OPENING BALANCE''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Commissions - Endorsement'' THEN ''END''
              WHEN VCH_ACT_TYPE = '' ''  
                                  AND VCH_TRANS_TYPE = ''Chargebacks - Endorsement'' THEN ''END''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Regular Commission'' 
                                  AND SUBSTRING(VCH_POLICY,14,2) = ''00''
                                  AND VCH_ENDO_CODE = ''0000'' THEN ''NEW''
              WHEN VCH_ACT_TYPE = '' '' 
                                  AND VCH_TRANS_TYPE = ''Regular Commission'' 
                                  AND SUBSTRING(VCH_POLICY,14,2) != ''00''
                                  AND VCH_ENDO_CODE = ''0000'' THEN ''REN''
              ELSE VCH_ACT_TYPE END "Activity Type"

FROM LDSNEWFIL.VUCOMDETPH
WHERE 1=1
--AND VCH_CONTR_CODE IN (''A42961'', ''A42959'', ''A43015'', ''A43017'', ''A42982'', ''A42983'', ''A42958'', ''A44991'', ''A43755'', ''A43016'', ''A55154'')
--AND VCH_POLICY like ''%03MGEP1283076%''
--AND VCH_GROUP_CODE 
AND VCH_FROM_DATE >= ''2020-09-01''
--AND VCH_TO_DATE = ''2020-09-01''
--AND VCH_TRANS_DATE = ''2020-06-30''
ORDER BY 4,5 DESC
')