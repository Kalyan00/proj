uses Crt,Dos,rmk,DRIVERS,time;
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
  lalala,nach,cred1,cred2,kon:ttime;
  cred_:boolean;


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
  {$I-}Reset(F);{$I+}
  if IOResult = 0 then  Append(F) else
Rewrite(F);

  writeln(f,'╔═══════════════════╗');
  if kon then writeln(f,'║    Окончательно   ║')
  else        writeln(f,'║   Предварительно  ║');
  writeln(f,'║ ----------------- ║');
  for t:=1 to i do
   if minc[t] then
    writeln(f,'║ No ',sq[t]:2,'   ',si[sq[t]]:8:2,'  ║');
  writeln(f,'║ ----------------- ║');
  writeln(f,'║ Разность =',min/100:6:2,'  ║');
  writeln(f,'║ Сумма   ',getsum(minc)/100:8:2,'  ║');
  writeln(f,'║ МЫ ИЩЕМ ',find/100:8:2,'  ║');
  writeln(f,'╚═══════════════════╝');
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
  if kon then write('    Окончательно   ')
  else        write('   Предварительно  ');
  gotoxy(31,7);write(' ----------------- ');
k_:=0;
for t:=1 to i do
if minc[t] then begin
 gotoxy(31,8+k_);write(' No ',sq[t]:2,'   ',si[sq[t]]:8:2,'  ');k_:=k_+1;
end;
gotoxy(31,8+k_);write(' ----------------- ');
gotoxy(31,9+k_);write(' Разность =',min/100:6:2,'  ');
gotoxy(31,10+k_);write(' Сумма   ',getsum(minc)/100:8:2,'  ');
gotoxy(31,11+k_);write(' МЫ ИЩЕМ ',find/100:8:2,'  ');
end
else
begin
  ramka(30,5,50,13);
  gotoxy(31,6);
  if kon then write('    Окончательно   ')
  else        write('   Предварительно  ');
  gotoxy(31,7);write(' ----------------- ');
  gotoxy(31,8);write('читайте  RESULT.TXT');
  gotoxy(31,9);write(' ----------------- ');
  gotoxy(31,10);write(' Разность =',min/100:6:2,'  ');
  gotoxy(31,11);write(' Сумма   ',getsum(minc)/100:8:2,'  ');
  gotoxy(31,12);write(' МЫ ИЩЕМ ',find/100:8:2,'  ');
end;
end;


procedure srav (cura:comb;Ggetsum:longint); {******}
var kk,k,k_,o:longint;
begin
if (Ggetsum-find=0)and(not cred_) then
begin
    getttime(cred1);cred2:=cred1;
    cred_:=true;
end;


if abs (Ggetsum-find)<min then
begin
textattr:=0; pub(false,true);
minc:=cura;
min:=abs (Ggetsum-find);
textattr:=textattr1;
pub(false,false);textattr:=15;
if min=0.0 then
begin
  k:=0;
  for kk:=0 to i do
  if cura[kk] then k:=k+1;
  qwer:=k;
end;
end else
if abs (Ggetsum-find)=min then
  begin
  k:=0;
  for kk:=0 to i do
  if cura[kk] then k:=k+1;
  k_:=0;
  for kk:=0 to i do
  if minc[kk] then k_:=k_+1;
  if k<k_ then
    begin
    if min=0 then begin qwer:=k;getttime(cred2);end;
    textattr:=0;    pub(false,true);
    minc:=cura;
    textattr:=textattr1;    pub(false,false);textattr:=15;
    end;
  end;
end;





procedure bar(curb:comb);
var k,u:longint;t:ttime;
begin
gotoxy(5,1);
for k:=1 to i do
if curb[k] then write('x')
else write('*');
if keypressed then
if readkey=#27 then
qwer:=1;
gotoxy(65,25); write(timetostr(msectotime(timetomsec(getttime(t)^)-timetomsec(nach),t)^,tm_hmsm));
end;









procedure step(w:longint;wer:integer;Ggetsum:longint);  {****}
var ww:longint;curc:comb;
begin
 if obnov=0 then bar(curi[wer]);obnov:=obnov+1;
 srav(curi[wer],Ggetsum);
 if  (Ggetsum<find)and(wer<qwer) then
 begin
  for ww:=w+1 to i do
  begin
   curi[wer+1]:=curi[wer];
   curi[wer+1][w]:=true;
   step(ww,wer+1,Ggetsum+s[w]);
  end;
 end;

end;




procedure gogog;
var ww,k:longint;curc:comb;summa:real;
begin
summa:=0;
for k:=0 to i do
summa:=summa+si[k];
writeln;
writeln('vsya summa:',summa:0:2);
write('iskat na summu: ');
readln(findi);find:=round(findi*100);
if findi>=summa then
begin
writeln('mnogovato...');halt;
end;

for k:=0 to MMAAXX do cur[k]:=false;
minc:=cur;
min:=10000;
   curc:=cur;
   curc[ww]:=true;
   getttime(nach);
   cred1:=nach;   cred2:=nach;
   step(0,0,getsum(curc));
   getttime(kon);
   gotoxy(1,20);
   writeln('first finding: ',timetostr(msectotime(timetomsec(cred1)-timetomsec(nach),lalala)^,TM_hmsm));
   if timetomsec(cred1)<>timetomsec(cred2) then
   writeln('last  finding: ',timetostr(msectotime(timetomsec(cred2)-timetomsec(nach),lalala)^,TM_hmsm));
   writeln('KOHEC finding: ',timetostr(msectotime(timetomsec(kon)  -timetomsec(nach),lalala)^,TM_hmsm));

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
  cred_:=false;
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
{i:=i-1;{123456}
sort;
gogog;
gotoxy(70,2);textattr:=4*16+15;write(' Ok! ');
pub(true,false);
readkey;textattr:=15;
end.
