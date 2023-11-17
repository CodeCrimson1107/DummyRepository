SELECT quoteid,sum(TOTPREM) as TPREM,
       AVG(TOTPREM) AS MEDIANVAL ,ROWASC,ROWDESC
FROM   (SELECT QUOTEID,
               TOTPREM,
               ROW_NUMBER() 
                 OVER ( 
                   PARTITION BY carrier 
                   ORDER BY QUOTEID,TOTPREM ASC, carrier ASC) AS ROWASC, 
               ROW_NUMBER() 
                 OVER ( 
                   PARTITION BY QUOTEID,carrier
                   ORDER BY QUOTEID,TOTPREM DESC)                   AS ROWDESC 
        FROM   dbo.UT_MB) X 
WHERE  ROWASC IN ( ROWDESC, ROWDESC - 1, ROWDESC + 1 ) 
GROUP  BY QUOTEID,TOTPREM,ROWASC,ROWDESC
ORDER  BY QUOTEID,TOTPREM;