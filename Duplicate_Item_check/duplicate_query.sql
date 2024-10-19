SELECT mt.oid AS Oid, ni.ItemName AS Tag, pg.Name AS PermissionGroup, RPTHierarchyPathByChildOid(mt.oid,'SystemHierarchy')
FROM JSmartEquipment mt
JOIN JNamedItem ni ON mt.oid = ni.oid
JOIN (
    SELECT ni2.itemname
    FROM JSmartEquipment mt2
    JOIN JNamedItem ni2 ON mt2.oid = ni2.oid
    GROUP BY ni2.ItemName
    HAVING COUNT(*) > 1
) gn ON ni.itemname = gn.itemname
LEFT OUTER JOIN JDObject ob ON mt.oid = ob.oid
LEFT OUTER JOIN JDPermissionGroup pg ON ob.ConditionID = pg.PermissionGroupID
where RPTHierarchyPathByChildOid(mt.oid,'SystemHierarchy')like 'No7 Facility%'