SELECT
ni.ItemName Document, ni.ItemName as IsoDrawingName,
RPTHierarchyPathByChildOid(s.OidDestination, 'DrawingFolderHierarchy') Path
FROM JDDwgSheet d
JOIN JNamedItem ni ON ni.Oid = d.Oid
join JNamedItem jn on jn.Oid = j1.Oid
JOIN SnapInHasSheets s ON s.OidOrigin = d.Oida
JOIN PipelineSystem j3 on x1.OidDestination = j3.Oid
ORDER BY RPTHierarchyPathByChildOid(s.OidOrigin, 'DrawingFolderHierarchy')