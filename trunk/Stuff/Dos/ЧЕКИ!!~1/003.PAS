uses Crt,Dos;
const
 pp:array[0..4] of real=(1,10,100,1000,10000);
type
 comb=array[0..200]of boolean;

var
  F: text;
  c: string;
  s:array[0..200] of real;
  i:integer;
  II, p,Code,code1: Integer;
  min:real;
  minc: comb;
  find:real;
  cur:comb;


function getsum(a:comb):real;
var it:real; t:integer;
begin it:=0;
for t:=0 to i do
if a[t] then it:=it+s[t];
getsum:=it;
end;




procedure pub;
var t:integer;
begin
writeln;
writeln('raznost=',min:2:2);
t:=0;
while t<=i do begin
if minc[t] then
writeln('No',t+1,'   ',s[t]:2:2);t:=t+1; end;
writeln('Summa ',getsum(minc):2:2);
halt;
end;



procedure gogog;
var k:integer;
begin
writeln;
write('iskat na summu: ');
readln(find);
for k:=0 to 200 do cur[k]:=false;
minc:=cur;
min:=find;
cur[0]:=true;

while true do begin
if getsum(cur)<find then
  begin
   k:=i;
   while (not cur[k])and (k>=0) do k:= k-1;
   if k<>i then
       cur[k+1]:=true
   else
       begin
        while (    cur[k])and (k>=0) do begin cur[k]:=false; k:=k-1;end;
        while (not cur[k])and (k>=0) do k:= k-1;
        if k<>-1 then cur[k+1]:=true;
       end;
  end
  else
if getsum(cur)>find then
  begin
   k:=i;
   while (not cur[k])and (k>=0) do k:= k-1;
   if k<>i then
       begin
        cur[k+1]:=true;
        cur[k]:=false;
       end
   else
       begin
        while (    cur[k])and (k>=0) do begin cur[k]:=false;k:=k-1; end;
        while (not cur[k])and (k>=0) do k:= k-1;
        cur[k+2]:=true;k:=1;
       end;
  end
  else
if getsum(cur)=find then pub;
if( k=-1)and (not cur[0] ) then pub;
if abs (getsum(cur)-find)<min then
begin
minc:=cur;
min:=abs (getsum(cur)-find);
end;

end;
end;






begin
  i:=0;
  Assign(F,'data.txt' );
  Reset(F);
  while not Eof(F) do
  begin
    Readln(F, c);
    if c[0]=#0 then continue;
    Val(c, Ii, Code);
  if code <> 0 then
   if (c[code] = '.')or(c[code] = ',') then
    begin
    p:=ord(c[0]);
    c[0]:=chr(code-1);
       Val(c, Ii, Code1);
        if code1 <> 0 then
          Writeln('Error at positon: ', Code,'in line No',i+1,'  :',c )
        else
       s[i]:=ii;
     c[0]:=chr(p);
     delete(c,1,code);
       Val(c, Ii, Code1);
        if code1 <> 0 then
          Writeln('Error at positon: ', Code,'in line No',i+1,'  :',c )
        else
       s[i]:=s[i]+ii/pp[ord(c[0])];



    end else
    Writeln('Error at positon: ', Code,'in line No',i+1,'  :',c )
  else
    s[i]:=ii;
   i:=i+1;
  end;

i:=i-1;
gogog;

end.
