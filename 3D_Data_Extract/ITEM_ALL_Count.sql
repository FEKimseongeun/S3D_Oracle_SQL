select
o.oid,
o.ItemName as ObjectName,
ul.UserLogin as UserLastModified,
ni.DateLastModified,
pg.Name as ObjectPG,
XXXX_RDB.RPTHierarchyPathByChildOid(o.oid,'SystemHierarchy') as path
from Jnameditem o
join JDObject ni on ni.Oid = o.Oid
join JDPermissionGroup pg on pg.PermissionGroupID = ni.ConditionID
join JUserLogin ul on ul.oid = ni.UIDLastModifier
Where Name Like '%xxx_%'

---

with item as

(

select oid, ItemName,

	   (select XXXX_RDB.RPTHierarchyPathByChildOid(oid,'SystemHierarchy') from dual) as path,

	   (select REGEXP_SUBSTR(XXXX_RDB.RPTHierarchyPathByChildOid(oid,'SystemHierarchy'),'[^\]+', 1, 2) from dual) as pos

  from Jnameditem

)

select o.oid,

	   o.ItemName as ObjectName,

	   ul.UserLogin as UserLastModified,

	   ni.DateLastModified,

	   pg.Name as ObjectPG,

	   o.path

  from item o,

	   JDObject ni,

	   (select * from JDPermissionGroup where instr(Name, 'xxx_') > 0) pg,

	   JUserLogin ul

where 1=1

   and ni.Oid = o.Oid

   and pg.PermissionGroupID = ni.ConditionID 

   and ul.oid = ni.UIDLastModifier

   and o.pos = 'xxxxxxx'

;