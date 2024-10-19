SELECT j1.oid, RPTHierarchyPathByChildOid(j1.oid,'SystemHierarchy'), j2.ITEMNAME, j5.name, Round(X2.o0*1000,0) AS X, Round(X2.o1*1000,0) AS Y, Round(X2.o2*1000,0) AS Z FROM JSmartEquipmentOcc J1
JOIN JNAMEDITEM j2 ON j2.OID = j1.OID
join JDObject j3 on j3.oid = j1.oid
join JDPermissionGroup j5  on j5.PERMISSIONGROUPID = j3.CONDITIONID
LEFT JOIN JEQUIPMENT x2 ON x2.OID=j1.OID
where name like 'IN%' and RPTHierarchyPathByChildOid(j1.oid,'SystemHierarchy')like 'No7 Facility%' and RPTHierarchyPathByChildOid(j1.oid,'SystemHierarchy')like '%%'