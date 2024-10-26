select pr2.Oid, RPTHierarchyPathByChildOid(pr2.oid,'SystemHierarchy')
from(
select distinct pr.oid from JRtePipeRun pr
join XpathSpecification op on op.OidOrigin=pr.Oid
)main
right join JRtePipeRun pr2 on pr2.oid=main.oid
join JDObject o on o.Oid=pr2.oid
join JDPermissionGroup p on p.PermissionGroupID=o.ConditionID
join XPermissionGroupHasLocation pgl on pgl.OidOrigin=p.Oid
where main.oid is null

UNION ALL 

-- PipeLine
SELECT j1.Oid, j2.ITEMNAME, RPTHierarchyPathByChildOid(j1.oid,'SystemHierarchy')
FROM JPipelineSystem j1
JOIN JNamedItem j2 ON j2.oid = j1.oid
LEFT JOIN XSystemHierarchy x1 ON x1.OidOrigin = j1.Oid
WHERE x1.OidOrigin IS NULL;