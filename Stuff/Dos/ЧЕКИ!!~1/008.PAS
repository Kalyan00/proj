uses Crt,Dos,rmk,DRIVERS;
const
pp:array[0..4] of real=(1,10,100,1000,10000);
textattr1=48;
MMAAXX=200;
type
inter=0..MMAAXX;
 comb=array[inter]of boolean;













var
  F: text;
  c: string;
  si:array[inter] of real;
  sq,s:array[inter] of longint;
  i:longint;
  II, p:longint;
  Code,code1: Integer;
  min:longint;
  mini:real;
  minc: comb;
  find:longint;
  findi:real;
  cur:comb;
  curi:array[inter]of comb;
  qwer,obnov:integer;




function getsum(a:comb):longint;
var it:longint; t:longint;
begin it:=0;
for t:=0 to i do
if a[t] then it:=it+s[t];
getsum:=it;
end;













procedure pub(kon,stir:boolean);
var kk,k_,t:longint;
begin
if not stir then begin
Assign(F,'result.txt' );
  (*{$I-}Reset(F);{$I+}
  if IOResult = 0 then  Append(F) else*)
Rewrite(F);

  writeln(f,'浜様様様様様様様様様�');
  if kon then writeln(f,'�    ｪ����皀�讚�   �')
  else        writeln(f,'�   踳あ�爬皀�讚�  �');
  writeln(f,'� ----------------- �');
  for t:=1 to i do
   if minc[t] then
    writeln(f,'� No ',sq[t]:2,'   ',si[sq[t]]:8:2,'  �');
  writeln(f,'� ----------------- �');
  writeln(f,'� ��Л�痰� =',min/100:6:2,'  �');
  writeln(f,'� �祠��   ',getsum(minc)/100:8:2,'  �');
  writeln(f,'� �� ���� ',find/100:8:2,'  �');
  writeln(f,'藩様様様様様様様様様�');
  writeln(f);
  writeln(f);
  close(f);
end;
  k_:=0;
  for kk:=1 to i do
  if minc[kk] then k_:=k_+1;
  if K_<13 then begin
  ramka(30,5,50,12+k_);
  gotoxy(31,6);
  if kon then write('    ｪ����皀�讚�   ')
  else        write('   踳あ�爬皀�讚�  ');
  gotoxy(31,7);write(' ----------------- ');
k_:=0;
for t:=1 to i do
if minc[t] then begin
 gotoxy(31,8+k_);write(' No ',sq[t]:2,'   ',si[sq[t]]:8:2,'  ');k_:=k_+1;
end;
gotoxy(31,8+k_);write(' ----------------- ');
gotoxy(31,9+k_);write(' ��Л�痰� =',min/100:6:2,'  ');
gotoxy(31,10+k_);write(' �祠��   ',getsum(minc)/100:8:2,'  ');
gotoxy(31,11+k_);write(' �� ���� ',find/100:8:2,'  ');
end
else
begin
  ramka(30,5,50,13);
  gotoxy(31,6);
  if kon then write('    ｪ����皀�讚�   ')
  else        write('   踳あ�爬皀�讚�  ');
  gotoxy(31,7);write(' ----------------- ');
  gotoxy(31,8);write('腮���皀  RESULT.TXT');
  gotoxy(31,9);write(' ----------------- ');
  gotoxy(31,10);write(' ��Л�痰� =',min/100:6:2,'  ');
  gotoxy(31,11);write(' �祠��   ',getsum(minc)/100:8:2,'  ');
  gotoxy(31,12);write(' �� ���� ',find/100:8:2,'  ');
end;
end;



procedure srav (cura:comb);
var kk,k,k_,o:longint;
begin
if abs (getsum(cura)-find)<min then
begin
{textattr:=0; pub(false,true);}
minc:=cura;
min:=abs (getsum(cura)-find);
{textattr:=textattr1;
pub(false,false);textattr:=15;}
if min=0.0 then
begin
    WRITE(#7);pub(false,false);
  k:=0;
  for kk:=0 to i do
  if cura[kk] then k:=k+1;
  qwer:=k;
end;
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
    if min=0 then qwer:=k;
   { textattr:=0;    pub(false,true);}
    minc:=cura;
    WRITE(#7);pub(false,false);
   { textattr:=textattr1;    pub(false,false);textattr:=15;}
    end;
  end;
end;













procedure bar(curb:comb);
var k,u:longint;a:char;
begin
gotoxy(5,1);
{for k:=1 to i do
if curb[k] then write('x')
else write('*');}
if keypressed then begin
a:=readkey;
if a=#27 then halt else pub(false,false);
end;
end;









procedure step(w:longint;wer:integer);
var ww:longint;curc:comb;
begin
 if obnov=0 then bar(curi[wer]);obnov:=obnov+1;
 srav(curi[wer]);
 if  (getsum(curi[wer])<find)and(wer<qwer) then
 begin
  for ww:=w+1 to i do
  begin
   curi[wer+1]:=curi[wer];
   curi[wer+1][w]:=true;
   step(ww,wer+1);
  end;
 end;

end;




procedure gogog;
var ww,k:longint;curc:comb;
begin
writeln;
write('iskat na summu: ');
readln(findi);find:=round(findi*100);
for k:=0 to MMAAXX do cur[k]:=false;
minc:=cur;
min:=find;
   curc:=cur;
   curc[ww]:=true;
   step(0,0);
end;






procedure sort;
var k,j:longint;weo:boolean;
begin
for k:=0to i do
sq[k]:=k;
weo:=true;
while weo do
begin
weo:=false;
for k:=1 to i-1 do
if s[k]<s[k+1] then
begin
j:=s[k];
s[k]:=s[k+1];
s[k+1]:=j;
j:=sq[k];
sq[k]:=sq[k+1];
sq[k+1]:=j;
weo:=true;
end;
end;
end;


















begin
  qwer:=MMAAXX;
  textattr:=15;ClrScr;
  i:=1;
  si[0]:=0;s[0]:=0;
  Assign(F,'data.txt' );
  Reset(F);
  while (not Eof(F))and (i<mmaaxx) do
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
sort;
gogog;
gotoxy(70,2);textattr:=4*16+15;write(' Ok! ');
pub(true,false);
readkey;textattr:=15;
end.
