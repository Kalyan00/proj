unit getdir;
INTERFACE
type dir = record
    Attr: Byte;
    Time: Longint;
    Size: Longint;
    Name: string [14];
  end;
     adir=array[0..255]of dir;
function getdir_(s:string;var a:array of dir):word;

IMPLEMENTATION
uses Dos;
function getdir_(s:string;var a:array of dir):word;
var q:byte;
  D: SearchRec;
begin
q:=0;
if s[ord(s[0])]<>'\' then s:=s+'\';
s:=s+'*.*';
FindFirst(s, $F3,d);
  while DosError = 0 do
  begin
    inc(q);
    a[q].Attr:=d.Attr;
    a[q].Time:=d.Time;
    a[q].Size:=d.Size;
    a[q].Name:=d.Name;
    FindNext(D);
  end;
  a[0].attr:=q;
getdir_:=q;
end;

end.

ReadOnly       $01
Hidden         $02
SysFile        $04
VolumeID       $08
Directory      $10
Archive        $20
