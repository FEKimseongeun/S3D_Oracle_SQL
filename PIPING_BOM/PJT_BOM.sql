select
A.Oid,
JN7.ItemName as AREA,
JN6.ItemName as SUBAREA,
JN5.ItemName as BorMoudle, 
JN1.ItemName as GroundPos,
JN4.ItemName as UNIT, 
N1.ItemName as LineNo, 
e.ItemName as RunNo, 
j.shortstringValue as FluidCode, 
d.SPECName,
SC.shortcode,
SC.OptionCode, 
PN.ItemName as ITEMname,
H.ShortMaterialDescription, 
CLInsu.SHORTSTRINGVALUE, 
( Insu.INSULATIONTHICKNESS*1000  ) AS INSULTHK,
N.PrimarySize AS MSIZE, 
N.SecondarySize AS BSIZE,
round(j.CutLength * 1000, 2),
REP1.SHORTSTRINGVALUE AS MTO, 
U1.OperatingTemperature, 
U1.PIDNo, 
U1.NDEMT,
U1.NDEPAUT,
U1.NDEPT,
U1.NDERT,
U1.DEUT,
U1.PWHT,
U1.PaintCode,
U1.TOXIC,
U1.StressPKGNO,
K.partnumber,
jnote3.TEXT, 
ulc.userlogin as creator, 
ul.userlogin as lastmodifier,
JJ.datelastmodified as datelastmodified

from JPartOcc a

left join XOwnsParts b on b.OidDestination=a.Oid
left join JNamedItem PN on PN.Oid=a.Oid
left join XPathRunUsesSpec c on c.OidOrigin=b.OidOrigin
left join JDPipeSpec d on d.Oid=c.OidDestination
left join XSystemHierarchy e on e.OidDestination=b.OidOrigin
left join JNamedItem e on e.Oid=b.OidOrigin
left join JNamedItem f on f.Oid=e.OidOrigin
left join XPartOccToMaterialControlData g on g.OidOrigin=a.Oid
left join JRtePartData SC on SC.oid = a.oid
left join JGenericMaterialControlData h on h.Oid=g.OidDestination
left join JPipelineSystem i on i.Oid=f.Oid
left join JNamedItem N1 on N1.Oid=i.Oid
left join CL_FluidCode j on j.ValueID=i.FluidCode
left JOIN JRtePipeRun L ON L.Oid=B.OidOrigin
left join JRteInsulation Insu on Insu.oid = L.Oid
left join CL_InsulationPurpose CLInsu on CLInsu.ValueID = Insu.INSULATIONPURPOSE
left JOIN XmadeFrom M ON M.OidOrigin=A.Oid
left JOIN JDPipeComponent N ON N.Oid=M.OidDestination
left join JRteStockPartOccur j on j.Oid=a.Oid
--'Part Number'
left join JdPart K on K.Oid=a.Oid
left join JRange JR on JR.oid = a.OID


left join JDObject JJ on jj.oid = a.oid
left join Juserlogin ul on ul.oid = jj.uidlastmodifier
left join Juserlogin ulc on ulc.oid = jj.uidcreator
left JOIN XSystemHierarchy XS1 ON XS1.OidDestination=F.Oid
left JOIN JNamedItem JN1 ON JN1.Oid=XS1.OidOrigin
left JOIN XSystemHierarchy XS2 ON XS2.OidDestination=JN1.Oid
left JOIN JNamedItem JN2 ON JN2.Oid=XS2.OidOrigin
left JOIN XSystemHierarchy XS3 ON XS3.OidDestination=JN2.Oid
left JOIN JNamedItem JN3 ON JN3.Oid=XS3.OidOrigin
left JOIN XSystemHierarchy XS4 ON XS4.OidDestination=JN3.Oid
left JOIN JNamedItem JN4 ON JN4.Oid=XS4.OidOrigin

left JOIN XSystemHierarchy XS5 ON XS5.OidDestination=JN4.Oid
left JOIN JNamedItem JN5 ON JN5.Oid=XS5.OidOrigin
left JOIN XSystemHierarchy XS6 ON XS6.OidDestination=JN5.Oid
left JOIN JNamedItem JN6 ON JN6.Oid=XS6.OidOrigin
left JOIN XSystemHierarchy XS7 ON XS7.OidDestination=JN6.Oid
left JOIN JNamedItem JN7 ON JN7.Oid=XS7.OidOrigin
left JOIN XSystemHierarchy XS8 ON XS8.OidDestination=JN7.Oid
left JOIN JNamedItem JN8 ON JN8.Oid=XS8.OidOrigin

LEFT Join XContainsNote Xnote1 on Xnote1.oidOrigin = a.oid
LEFT Join JGeneralNote jnote3 on jnote3.oid = Xnote1.OidDestination

LEFT JOIN  MTOinfo M2 ON M2.OID = A.OID
LEFT JOIN ReportingRequirement REP1 ON REP1.VALUEID  = M2.REPORTINGREQUIREMENTS

where jn7.itemname like '%%'