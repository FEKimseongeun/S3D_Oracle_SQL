
select
A.Oid,
JN7.ItemName as AREA,
JN6.ItemName as SUBID,
JN5.ItemName as SBorMoudle, 
JN1.ItemName as GroundPos,
JN4.ItemName as UNIT, 
N1.ItemName as LineNo, 
e.ItemName as RunNo, 
PN.ItemName as ITEMname,
ulc.userlogin as creator, 
ul.userlogin as lastmodifier,
JJ.datelastmodified as datelastmodified

from JPartOcc a

 left join XXX_RDB.XOwnsParts b on b.OidDestination=a.Oid
 left join JNamedItem PN on PN.Oid=a.Oid
 left join XXX_RDB.XSystemHierarchy e on e.OidDestination=b.OidOrigin
 left join JNamedItem e on e.Oid=b.OidOrigin
 left join JNamedItem f on f.Oid=e.OidOrigin
 left join JPipelineSystem i on i.Oid=f.Oid
 left join JNamedItem N1 on N1.Oid=i.Oid


 left join JDObject JJ on jj.oid = a.oid
 left join Juserlogin ul on ul.oid = jj.uidlastmodifier
 left join Juserlogin ulc on ulc.oid = jj.uidcreator
 left JOIN XXX_RDB.XSystemHierarchy XS1 ON XS1.OidDestination=F.Oid
 left JOIN JNamedItem JN1 ON JN1.Oid=XS1.OidOrigin
 left JOIN XXX_RDB.XSystemHierarchy XS2 ON XS2.OidDestination=JN1.Oid
 left JOIN JNamedItem JN2 ON JN2.Oid=XS2.OidOrigin
 left JOIN XXX_RDB.XSystemHierarchy XS3 ON XS3.OidDestination=JN2.Oid
 left JOIN JNamedItem JN3 ON JN3.Oid=XS3.OidOrigin
 left JOIN XXX_RDB.XSystemHierarchy XS4 ON XS4.OidDestination=JN3.Oid
 left JOIN JNamedItem JN4 ON JN4.Oid=XS4.OidOrigin
 left JOIN XXX_RDB.XSystemHierarchy XS5 ON XS5.OidDestination=JN4.Oid
 left JOIN JNamedItem JN5 ON JN5.Oid=XS5.OidOrigin
 left JOIN XXX_RDB.XSystemHierarchy XS6 ON XS6.OidDestination=JN5.Oid
 left JOIN JNamedItem JN6 ON JN6.Oid=XS6.OidOrigin
 left JOIN XXX_RDB.XSystemHierarchy XS7 ON XS7.OidDestination=JN6.Oid
 left JOIN JNamedItem JN7 ON JN7.Oid=XS7.OidOrigin

where ulc.userlogin like '%XXXXXX%'