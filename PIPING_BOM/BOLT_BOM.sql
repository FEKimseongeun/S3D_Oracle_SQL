SELECT 
    (SELECT LISTAGG(Name, '\') WITHIN GROUP(ORDER BY CNT)
        FROM (SELECT (SELECT ItemName FROM XXXX_MDB.JNamedItem WHERE oid = oidParent) AS Name, (SELECT COUNT(*) FROM XXX_RDB.RPTALLPARENTSINHIERARCHY(oidParent, 'SystemHierarchy')) AS CNT 
            FROM XXX_RDB.RPTALLPARENTSINHIERARCHY(JN2.oid, 'SystemHierarchy')) PARENTS
    ) AS "System Path"
,JN2.itemname AS Pipeline
    --, JN1.itemname AS Part
    --, pipingA.oid  AS PartOID
    , RPB.oid AS BoltSetOID
    , JRP.NPD AS NPD, JRP.npdunittype AS "TYPE"
    , JPS.SPECName
    , JSBD.sizedcommoditycode  AS sizedcommoditycode
    , RPB.BoltQuantity AS BoltQuantity
, (SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
 WHERE TableName = 'BoltOption' AND CVV.ValueID = RPB.BoltOption) AS BoltOption
, ROUND (RPB.Diameter*1000/25.4, 2) AS BoltDia
, ROUND (RPB.RoundedLength*1000, 2) AS RoundedLength
, (SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
 WHERE TableName = 'ReportingRequirement' AND CVV.ValueID = JPB.BoltReportingRequirements) AS ReportingRequirement
 ,(SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
    WHERE TableName = 'ReportingType' AND CVV.ValueID = JPB.BoltReportingClassification) AS ReportingType 
FROM (SELECT oid FROM XXXX_MDB.ROUTEPipeOccur
	  UNION ALL
	  SELECT oid FROM XXXX_MDB.ROUTEPipeComponentOcc
	  UNION ALL
	  SELECT oid FROM XXXX_MDB.ROUTEPipeInstrumentOcc
	  UNION ALL
	  SELECT oid FROM XXXX_MDB.ROUTEPipeSpecialtyOcc) pipingA

INNER JOIN XXXX_MDB.XOwnsImpliedItems XIM1 ON pipingA.oid =  XIM1.oidOrigin
INNER JOIN XXXX_MDB.ROUTEPipeBoltSet RPB ON  XIM1.oidDestination = RPB.oid
INNER JOIN XXXX_MDB.JRteBolt JPB ON RPB.oid = JPB.oid
LEFT JOIN XXXX_MDB.JUASizedBoltData JSBD ON  RPB.oid = JSBD.oid

INNER JOIN XXXX_MDB.JDObject JDO ON  JDO.oid = pipingA.oid
INNER JOIN XXXX_MDB.XOwnsParts XOP ON  XOP.oiddestination = pipingA.oid
INNER JOIN XXXX_MDB.JRtePipeRun JRP ON  XOP.oidorigin = JRP.oid
INNER JOIN XXXX_MDB.XSystemHierarchy XSH1 ON XOP.oidorigin = XSH1.oiddestination
LEFT join XXX_RDB.XPathRunUsesSpec JPUS on JPUS.OidOrigin=XOP.OidOrigin
LEFT join XXX_CDB.JDPipeSpec JPS on JPS.Oid=JPUS.OidDestination

-- permission 
LEFT JOIN XXXX_MDB.JDPermissionGroup PG ON PG.PermissionGroupID = JDO.ConditionID
-- Pipe Item Name
INNER JOIN XXXX_MDB.JNamedItem JN1 ON pipingA.oid = JN1.OID
INNER JOIN XXXX_MDB.JNamedItem JN2 on XSH1.OidOrigin = JN2.oid

WHERE PG.NAME like 'XXXXX%' --AND (RPB.oid is NOT NULL OR RPG.oid is NOT NULL)
