uses crt;
type pla=array[1..96]of real;
var q1,q2:pla;
const ftmps2='tmp_dual.tmp';
var cur:integer; ftmps:string;






procedure err(s:string);
begin
gotoxy(1,24);
writeln;
writeln(s);
halt(1);
end;





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



procedure readdd(var q:pla;s:string);
var ss:string;
begin
while s[0]<>#0 do
begin
ss:=s;
ss[0]:=#6;
delete(s,1,6);
if cur<=96 then q[cur]:=strtoreal(ss);
inc(cur);
end;

end;







procedure readd;
var f1,f2:text;ss,s:string;
var i,q:byte;
begin
assign(f1,ftmps);
assign(f2,ftmps2);
{$i-}reset(f1);{$i+}
if ioresult <>0 then err('файл '+ftmps +' не найден');
rewrite(f2);
readln(f1,s);
while s<>';start' do
 begin if eof(f1) then err('err ;start'); writeln(f2,s);readln(f1,s);end;
readln(f1,s);
cur:=1;

while s<>';mid' do
 begin if eof(f1) then err('err ;mid');  readdd(q1,s);readln(f1,s);end;
readln(f1,s);

cur:=1;
while s<>';end' do
 begin if eof(f1) then err('err ;end'); readdd(q2,s);readln(f1,s);end;
readln(f1,s);


{-------------------------------------------------------}
for i:=1 to 96 do q1[i]:=q2[i]-q1[i];
for i:=1 to 8  do begin s:='';
for q:=1 to 12 do begin
str( q1[(i-1)*12+q]:6:6,ss);
while ss[0]=' ' do delete(ss,1,1);
if ss[0]<>'-' then ss:=' '+ss;
ss[0]:=#6;
s:=s+ss;
end;
writeln(f2,s);
end;
{-------------------------------------------------------}




while not eof(f1) do
begin writeln(f2,s);readln(f1,s);end;
close(f1);
close(f2);

s:=ftmps;
delete(s,pos(s,'.'),1); s:=s+'             ';
s[0]:=#8;s:=s+'.bak';
erase(f1);
assign(f2,ftmps2);
rename(f2,ftmps);

end;







begin
if ParamCount<>1 then err('use dual.exe %%%%%%%%.%%%');
ftmps:=ParamStr(1);
fillchar(q1,sizeof(q1),0);
fillchar(q2,sizeof(q1),0);
readd;


end.