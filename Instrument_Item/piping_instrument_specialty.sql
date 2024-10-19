SELECT j1.oid, RPTHierarchyPathByChildOid(j1.oid,'SystemHierarchy'), j2.ITEMNAME, j5.name, j6.LocationX*1000, j6.LocationY*1000, J6.LocationZ*1000 FROM JRteInstrument J1
JOIN JNAMEDITEM j2 ON j2.OID = j1.OID
join JDObject j3 on j3.oid = j1.oid
join JDPermissionGroup j5  on j5.PERMISSIONGROUPID = j3.CONDITIONID 
join xpathgeneratedparts X1 on X1.oidDestination = j1.oid
Left join JRtePathFeature j6 on J6.oid = X1.oidOrigin
where name like 'PP%' and RPTHierarchyPathByChildOid(j1.oid,'SystemHierarchy')like 'No7 Facility%'