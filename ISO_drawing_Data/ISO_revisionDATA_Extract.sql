select
       ySheetToRev.OidOrigin DwgOID,
       j3.ItemName DwgName,
       j2.RevMark,
       j2.RevAppBy,
       j2.RevAppByDate,
       j2.RevChkBy,
       j2.RevChkByDate,
       j2.RevDate,
       j2.RevDesc,
       j2.RevMinorNumber,
       j2.RevRecordType,
       j2.RevRevBy,
       j2.RevVersion,
       j4.DateCreated
from YSheetToRevision ySheetToRev
join JNamedItem j3 on j3.Oid = ySheetToRev.OidOrigin
join JDDwgRevision j2 on j2.Oid = ySheetToRev.OidDestination and j2.RevRecordType=1
join JDObject j4 on j4.Oid = j2.Oid