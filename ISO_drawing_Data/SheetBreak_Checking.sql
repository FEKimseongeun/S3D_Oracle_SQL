select * from (
select 
  '최상위\'|| RPTHierarchyPathByChildOid(j2.oid,'SystemHierarchy') as "SystemPath",
      CASE 
            WHEN LENGTH(jn2.itemname) - LENGTH(REPLACE(jn2.itemname, '-', '')) >= 4 THEN
                SUBSTR(jn2.itemname, 1, INSTR(jn2.itemname, '-', -1) - 1)
            ELSE
                NULL
        END AS "Pipeline",
    RPTHierarchyPathByChildOid(x2.OidDestination, 'DrawingFolderHierarchy') as "DrawingHierarchy",
    jn1.ItemName as "SheetName",
    j3.RevMark as "Rev",
    j3.RevDate as "RevisionDate",
    jn3.ItemName as "RunNo",
    U1.특정table AS "PID NO"
    
    from JDDwgSheet2 j1
    join JNamedItem jn1 on jn1.oid = j1.oid            
    join XSheetToDrawingTarget x1 on x1.oidorigin = j1.oid
    join JPipelineSystem j2 on j2.oid = x1.oiddestination
    
    join JNamedItem jn2 on jn2.oid = j2.oid  
    JOIN XSnapInHasSheets x2 ON x2.OidOrigin = J1.Oid
    join YSheetToRevisions y1 on y1.oidOrigin = j1.oid
    join JDDwgRevision  j3 on j3.oid = y1.oidDestination and j3.RevRecordType=1
    join XSystemHierarchy x3 on x3.oidOrigin = j2.oid
    join JNamedItem jn3 on jn3.oid = x3.oidDestination  
   
)
WHERE "Pipeline" IS NOT NULL AND "SheetName" LIKE  '특정AREA%'
group by "SystemPath","Pipeline", "DrawingHierarchy", "SheetName", "Rev", "RevisionDate",  "RunNo", "PID NO"
order by "SheetName"