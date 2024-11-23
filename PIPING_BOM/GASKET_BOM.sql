SELECT 
    (SELECT LISTAGG(Name, '\') WITHIN GROUP(ORDER BY CNT)
        FROM (SELECT (SELECT ItemName FROM XXX_MDB.JNamedItem WHERE oid = oidParent) AS Name, (SELECT COUNT(*) FROM XXXX_RDB.RPTALLPARENTSINHIERARCHY(oidParent, 'SystemHierarchy')) AS CNT 
            FROM XXXX_RDB.RPTALLPARENTSINHIERARCHY(JN2.oid, 'SystemHierarchy')) PARENTS
    ) AS "System Path"
,JN2.itemname AS Pipeline
, RPG.OID AS GasketOID
, JRP.NPD AS NPD, JRP.npdunittype AS "TYPE"
, JPS.SPECName
,(SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
    WHERE TableName = 'GasketOption' AND CVV.ValueID = RPG.GasketOption) AS GasketOption 
,(SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
    WHERE TableName = 'FabricationTypeBasis' AND CVV.ValueID = RPG.GasketSelectionBasis) AS GasketSelectionBasis 
   ,RGPV.ClientCommodityCode AS IDENTCODE
,(SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
    WHERE TableName = 'ReportingRequirement' AND CVV.ValueID = RPG.GasketReportingRequirements) AS ReportingRequirement 
,(SELECT CVV.ShortStringValue FROM XXX_CDB_SCHEMA.CodelistValueView CVV
    WHERE TableName = 'ReportingType' AND CVV.ValueID = RPG.GasketReportingClassification) AS ReportingType 
FROM (SELECT oid FROM XXX_MDB.ROUTEPipeOccur
	  UNION ALL
	  SELECT oid FROM XXX_MDB.ROUTEPipeComponentOcc
	  UNION ALL
	  SELECT oid FROM XXX_MDB.ROUTEPipeInstrumentOcc
	  UNION ALL
	  SELECT oid FROM XXX_MDB.ROUTEPipeSpecialtyOcc) pipingA

INNER JOIN XXX_MDB.XOwnsImpliedItems XIM2 ON pipingA.oid =  XIM2.oidOrigin
INNER JOIN XXX_MDB.ROUTEPipeGasket RPG ON  XIM2.oidDestination = RPG.oid
INNER JOIN XXX_MDB.Xmadefrom  XMF ON XIM2.oidOrigin =  XMF.oidOrigin
INNER JOIN XXX_MDB.XImpliedMatingParts  XIMP ON RPG.OID =  XIMP.oidOrigin
INNER JOIN (SELECT DISTINCT (OID), ClientCommodityCode FROM  XXX_CDB.REFDATGasketPartsWithPPDView ) RGPV ON XIMP.oiddestination = RGPV.OID

INNER JOIN XXX_MDB.JDObject JDO ON  JDO.oid = pipingA.oid
INNER JOIN XXX_MDB.XOwnsParts XOP ON  XOP.oiddestination = pipingA.oid
INNER JOIN XXX_MDB.JRtePipeRun JRP ON  XOP.oidorigin = JRP.oid
INNER JOIN XXX_MDB.XSystemHierarchy XSH1 ON XOP.oidorigin = XSH1.oiddestination
LEFT join XXXX_RDB.XPathRunUsesSpec JPUS on JPUS.OidOrigin=XOP.OidOrigin
LEFT join XXX_CDB.JDPipeSpec JPS on JPS.Oid=JPUS.OidDestination
-- permission 
LEFT JOIN XXX_MDB.JDPermissionGroup PG ON PG.PermissionGroupID = JDO.ConditionID
-- Pipe Item Name
INNER JOIN XXX_MDB.JNamedItem JN1 ON pipingA.oid = JN1.OID
INNER JOIN XXX_MDB.JNamedItem JN2 on XSH1.OidOrigin =  JN2.oid

WHERE PG.NAME like 'XXXX%'
