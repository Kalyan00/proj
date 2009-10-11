uses Crt,Dos,rmk,DRIVERS;
const
 pp:array[0..4] of real=(1,10,100,1000,10000);
textattr1=48;
type
 comb=array[0..200]of boolean;

var
  F: text;
  c: string;
  si:array[0..200] of real;
  s:array[0..200] of longint;
  i:longint;
  II, p:longint;
  Code,code1: Integer;
  min:longint;
  mini:real;
  minc: comb;
  find:longint;
  findi:real;
  cur:comb;
  obnov:integer;




function getsum(a:comb):longint;
var it:longint; t:longint;
begin it:=0;
for t:=0 to i do
if a[t] then it:=it+s[t];
getsum:=it;
end;




procedure pub;
var kk,k_,t:longint;
begin
  k_:=0;
  for kk:=1 to i do
  if minc[kk] then k_:=k_+1;
  ramka(30,5,50,12+k_);
  gotoxy(31,6);write('   Предварительно  ');
  gotoxy(31,7);write(' ----------------- ');


k_:=0;
for t:=1 to i do
if minc[t] then
begin
gotoxy(31,8+k_);write(' No ',t:2,'   ',si[t]:8:2,'  ');k_:=k_+1;
end;
gotoxy(31,8+k_);write(' ----------------- ');
gotoxy(31,9+k_);write(' Разность =',min/100:6:2,'  ');
gotoxy(31,10+k_);write(' Сумма   ',getsum(minc)/100:8:2,'  ');
gotoxy(31,11+k_);write(' МЫ ИЩЕМ ',find/100:8:2,'  ');

end;


procedure srav (cura:comb);
var kk,k,k_,o:longint;
begin
if abs (getsum(cura)-find)<min then
begin
textattr:=0; pub;
minc:=cura;
min:=abs (getsum(cura)-find);
textattr:=textattr1;
pub;textattr:=15;
end else
if abs (getsum(cura)-find)=min then
  begin
  k:=0;
  for kk:=0 to i do
  if cura[kk] then k:=k+1;
  k_:=0;
  for kk:=0 to i do
  if minc[kk] then k_:=k_+1;
  if k<k_ then
    begin
    textattr:=0;    pub;
    minc:=cura;
    textattr:=textattr1;    pub;textattr:=15;
    end;
  end;


end;

procedure bar(curb:comb);
var k,u:longint;
begin
gotoxy(1,1);
for k:=0 to i do
if curb[k] then write('x')
else write('*');
if keypressed then
if readkey=#27 then
halt;
end;


procedure step(w:longint; curb:comb);
var ww:longint;curc:comb;
begin
 if obnov=0 then bar(curb);obnov:=obnov+1;
 srav(curb);
 if  getsum(curb)<find then
 begin
  for ww:=w+1 to i do
  begin
   curc:=curb;
   curc[w]:=true;
   step(ww,curc);
  end;
 end;

end;



procedure gogog;
var ww,k:longint;curc:comb;
begin
writeln;
write('iskat na summu: ');
readln(findi);find:=round(findi*100);
for k:=0 to 200 do cur[k]:=false;
minc:=cur;
min:=find;
   curc:=cur;
   curc[ww]:=true;
   step(0,curc);
pub;
end;




begin
  textattr:=15;ClrScr;
  i:=1;
  si[0]:=0;s[0]:=0;
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
       si[i]:=ii;
     c[0]:=chr(p);
     delete(c,1,code);
       Val(c, Ii, Code1);
        if code1 <> 0 then
          Writeln('Error at positon: ', Code,'in line No',i+1,'  :',c )
        else
       si[i]:=si[i]+ii/pp[ord(c[0])];



    end else
    Writeln('Error at positon: ', Code,'in line No',i+1,'  :',c )
  else
    si[i]:=ii;
    s[i]:=round(si[i]*100.0);
   if si[i]<>0.0 then
   i:=i+1;
  end;

i:=i-1;
gogog;
gotoxy(70,2);textattr:=4*16+15;write(' Ok! ');
pub;
readkey;
end.
