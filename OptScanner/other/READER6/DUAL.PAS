uses crt;
const yach=15;fs='temp_432.tmp';
type  mass=record i:byte; z:array[1..yach]of real;end;
var   f,ftmp:text;
      ftmps:string;
      q1,q2,q3:mass;


procedure err(s:string);
begin
gotoxy(1,24);
writeln;
writeln(s);
halt(1);
end;

var sss:byte;


function strtoreal(s:string):real;
var i:byte;k,r:real;z,m:boolean;
begin
m:=s[1]='-';
if m then delete(s,1,1);
z:=false;
r:=0;  k:=1;
for i:=1 to ord(s[0]) do
begin
if s[i]='.' then begin  z:=true;k:=0.1;end;
if s[i] in ['0'..'9'] then
if z then r:=r+k*(ord(s[i])-ord('0'))
     else r:=r*10+ord(s[i])-ord('0') else continue;;
k:=k/10;

end;
if m then r:=-r;
strtoreal:=r;
end;


function sss_(s:string):boolean;
var ss:string; i:byte;r:real;
begin
sss_:=false;
if ord(s[0])<20 then begin if (sss mod 2)=1 then inc(sss); exit;end;
while ord(s[0])>5 do
begin ss:=s;  ss[0]:=#6;  delete(s,1,6);
for i:=1 to 6do
if not ((ss[i]in ['0'..'9'])or((i=1)and(ss[i]='-'))or(ss[i]='.')or(ss[i]=' '))
then begin if (sss mod 2)=1 then inc(sss); exit;end;
r:=strtoreal(ss);
if (sss mod 2)=0 then inc(sss);

if sss=1 then begin inc(q1.i);q1.z[q1.i]:=r end else
if sss=3 then begin inc(q2.i);q2.z[q2.i]:=r end ;
end;
sss_:=true;
end;



procedure readd;
var s,ss:string;
begin
assign(f,fs);
{$i-}rewrite(f);{$i+}
assign(ftmp,ftmps);
{$i-}reset(ftmp);{$i+}
if ioresult<>0 then err('файл '+ftmps+' не найден');
while not eof(ftmp) do
  begin
  readln(ftmp,s);
  if not ssS_(s)then writeln(f,s);
  end;
close(ftmp);

for ki:=1 to shir do
for i:=1 to shir do

end;


procedure delta;
var i:byte;
begin
for i:=1to q1.i do q3.z[i]:=q1.z[i]-q2.z[i];

end;

begin
if ParamCount<>1 then err('use dual.exe %%%%%%%%.%%%');
ftmps:=ParamStr(1);
fillchar(q1,sizeof(q1),0);
fillchar(q2,sizeof(q1),0);
sss:=0;
readd;
delta;
end.