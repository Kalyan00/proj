{$M $4000,0,$1000 }   { 16K stack, no heap }
uses com,crt,rmk,dos;
type comset = record
     ComNo : Byte;     BaudRate : Word;
     Config : Byte;     BufSize : Word;
     end;

const
     br:array[1..12]of word=(1040,768,384,192,96,48,24,12,6,3,2,1);
     brs:array[1..12]of longint=(110,150,300,600,1200,2400, 4800,9600,19200,38400,57600,115200);
     configs:array[1..3]of word=(3,11,27);
     configss:array[1..3]of string[3]=('8N1','8O1','8E1');
     mes:array[1..12]of string[3]=('jan','feb','mar','apr','maj','jun','jul','avg','sep','nov','okt','dec');
     comsetstr='comset.dat';
     spisokstr='proggs.txt';
     FTmpStr  ='result.tmp';
     FLogStr  ='reader.log';
     charrun  ='!';
     charcomment=';';
     charview ='@';

var f,ftmp,flog:text;
    f_cs:file of comset;
    cs:comset;
    cs_ok:boolean;
    sp:array[1..30]of record naz,nam:string[40];end;
    spkon,spm:byte;
    fsave,proga:string;
var koef:real;

{----add----}
    frunstr:array[0..10]of string;
    frunstri:byte;


{----end----}











procedure reads(var s:string);
var x,y,z:byte;c:char;qw,cc,sq:string;
begin
sq:=s;
x:=wherex;
y:=wherey;
z:=ord(s[0]);
while true do
begin
gotoxy(x,y);write(s,' ');
gotoxy(x+z,y);
c:=readkey;
case c of
#13:break;
#27:begin gotoxy(x,y);for z:=0 to ord(s[0]) do write(' ');  s:=sq;  z:=ord(s[0]);end;
#8:if z<>0 then begin delete(s,z,1);dec(z);end;
#0:begin
   c:=readkey;
   case c of
   #75: if z<>0 then dec(z);
   #77: begin if z>=ord(s[0]) then s:=s+' ';inc(z) end;
   #72,#73,#71:begin gotoxy(x,y);for z:=0 to ord(s[0]) do write(' '); z:=0; end;
   #80,#81,#79:z:=ord(s[0]);
   #83:delete(s,z+1,1);
   end;
   end;
else begin cc:=c;insert(cc,s,z+1);inc(z); end;
end;
while (z<ord(s[0]))and (s[ord(s[0])]=' ')do dec(s[0]);

end;
while s[ord(s[0])]=' ' do dec(s[0]);

end;






procedure initdelay;
var Hour2, Minute2, Second2, Sec1002: Word;
Hour, Minute, Second, Sec100: Word;k,i:longint;
begin
koef:=0;
k:=1;
while koef=0 do
begin
GetTime(Hour, Minute, Second, Sec100);
for i:=0 to k do;
GetTime(Hour2, Minute2, Second2, Sec1002);
koef:=((((hour2-hour)*60+Minute2-Minute)*60+Second2-Second)*100+Sec1002-Sec100)/k;
k:=k*10;
end;
GetTime(Hour, Minute, Second, Sec100);
for i:=0 to k do;
GetTime(Hour2, Minute2, Second2, Sec1002);
koef:=((((hour2-hour)*60+Minute2-Minute)*60+Second2-Second)*100+Sec1002-Sec100)*10/k;
end;

procedure delay(x:real);
var i:longint;
begin
if koef=0 then initdelay;
for i:=0 to round(x/20/koef) do;
end;

function str_(x:integer):string;
var s:string;
begin
str(x,s);
str_:=s;
end;







function yn:boolean;
var c:char;
begin
c:=#0;
while true do
  begin
  c:=readkey;if(c=#0)or(c=#13)then continue else write(c);
  if (c='y')or(c='Y') then begin c:='y';break;end;
  if (c='n')or(c='N') then break;
  gotoxy(wherex-1,wherey);
  end;
yn:=c='y';
writeln;
end;

function max(a,b:byte):byte;begin if a>b then max:=a else max:=b;end;




procedure err(s:string);
begin
gotoxy(1,24);
writeln;
writeln(s);
halt(1);
end;




procedure delprobel(var s:string);
begin
while pos(' ',s)<>0 do delete(s,pos(' ',s),1);
end;





procedure writecomstr(s:string);
var i:byte;
begin
s:=s+#13#10;
for i:=1 to ord(s[0]) do
writecom(cs.comno,s[i]);
end;













function readcomstr:string;
var s:string;c:char;
begin
s:='';
while ReceivedFromCom (cs.ComNo) > 0 do
Begin
readcom(cs.comno,c);if c<>#10 then s:=s+c else break;
delay(100);
end;
readcomstr:=s;
end;









function proverka_cs:boolean;
var a:char;x:boolean; sq:string;
begin
x:=false;
proverka_cs:=false;
if not cs.comno in [1..4] then exit;
with cs do begin
if not opencom(ComNo,BaudRate ,Config ,BufSize)then exit;
writecomstr('q1w'); delay(20000);
sq:=readcomstr;

if sq='ER3'#13 then begin
x:=true; proverka_cs:=true; End;
if not x then
closecom(cs.comno);
end;
end;



procedure perebor_cs;
label qwr1;
var baudr,conf:byte;
begin
with cs do begin
BufSize:=2048;
for baudr:=12 downto 1 do
for comno:=1 to 4 do
for Conf:=1 to 3 do
  begin
  config:=configs[conf];
  gotoxy(60,1);
  baudrate:=br[baudr];
  write('COM',comno,' ',brs[baudr],' ',configss[conf],'  ');
  if keypressed then if readkey=#27 then err('user interrupts');
  if proverka_cs then goto qwr1;
  end;

err('reader is not found');
qwr1:
 assign(f_cs,comsetstr);
 {$i-}rewrite(f_cs);{$i+}
 if ioresult=0 then
  begin  write(f_cs,cs);  close(f_cs);
  end else  err('I can not write the file');
end;
end;













procedure readcomset;
begin
 assign(f_cs,comsetstr);
 {$i-}reset(f_cs);{$i+}
 if ioresult=0 then
  begin
  read(f_cs,cs);
  close(f_cs);
  if  not proverka_cs  then
  perebor_cs  end
  else   perebor_cs;
end;








procedure selectsp;
  procedure sel;
  var b,k,i:byte;s:string;
  begin
    for i:=1 to spkon do
    begin
      s:=sp[i].naz;
      b:=(spm-ord(s[0])+1)div 2;
      for k:=1 to b do s:=' '+s;
      s:=s+'                          ';
      sp[i].naz:=s;
      sp[i].naz[0]:=chr(spm);
    end;

  end;

var i,x,y,xx,yy:byte;c:char;
begin
sel;
x:=40-(spm div 2);xx:=x+spm;y:=12-(spkon div 2);yy:=y+spkon;
textattr:= 15;
if spm < 16 then ramka(31,y-1,50,yy) else
ramka(x-1,y-1,xx+2,yy);
gotoxy(35,y-1); write(' ваш выбор: ');
for i:=1 to spkon do begin gotoxy(x+1,y+i-1);write(sp[i].naz);end;
c:=#0;i:=1;
textattr:=15*16;gotoxy(x+1,y+i-1);write(sp[i].naz);textattr:=15;
while true do begin
case c of
#13,' ':begin proga:=sp[i].nam;exit;end;
#27:err('good bye !-)');
#72:begin
     textattr:=15;
     gotoxy(x+1,y+i-1);
     write(sp[i].naz);
     if i=1 then i:=spkon else dec(i);
     textattr:=15*16;gotoxy(x+1,y+i-1);
     write(sp[i].naz);
     textattr:=15;
    end;
#80:begin
     textattr:=15;
     gotoxy(x+1,y+i-1);
     write(sp[i].naz);
     if i=spkon then i:=1 else inc(i);
     textattr:=15*16;gotoxy(x+1,y+i-1);
     write(sp[i].naz);
     textattr:=15;
    end;
end;
c:=readkey;
end;
end;







procedure readspisok;
var s:string; q:byte;
begin
spkon:=0;
assign(f,spisokstr);
{$i-}reset(f);{$i+}
if ioresult <>0 then begin rewrite(f);close(f); err('error: use "[na3vanie] file.prg" in file '+spisokstr );end;
while not eof(f) do begin
readln(f,s);
if s=''then continue;
if s[1]<>'[' then continue;
q:=pos('] ',s);
if q=0  then continue;
inc(spkon);
sp[spkon].naz:=s;
sp[spkon].naz[0]:=chr(q-1);
delete(sp[spkon].naz,1,1);
delete(s,1,q);delprobel(s);
sp[spkon].nam:=s;
spm:=max(spm,q-2);
end;
close(f);
if spkon=0  then err('error: use "[na3vanie] file.prg" in file '+spisokstr );

selectsp;
end;














procedure print;
var s:string;
begin
   begin
   s:= '/C copy '+fsave+' lpt1 ';
   SwapVectors;
   Exec(GetEnv('COMSPEC'),s);
   SwapVectors;
   if DosError <> 0 then err('Could not execute COMMAND.COM '+s);
   end;
end;









procedure runreader;
var s:string;x,y,ii:byte;c:char; h,m,se,s0:word;
    procedure prmake;
    begin
      rewrite(f);
      writeln(f,charcomment,'ВНИМАНИЕ:');
      writeln(f,charcomment,'---------');
      writeln(f,charcomment,'в программе управления reader''ом - ',proga,' используйте');
      writeln(f,charcomment);
      writeln(f,charcomment,charrun,'name_of_programm.exe для дальнейшего обсчета');
      writeln(f,charcomment,charcomment,'комментарий');
      writeln(f,charcomment,charview,'отображаемая команда reader''у');
      writeln(f,charcomment,'неотображаемая команда reader''у');
      writeln(f,charcomment);
      close(f);
    end;
label qwer;
begin
assign(f   ,proga  );{$I-}reset(f);     {$I+}if ioresult<>0 then begin prmake;err('file '+proga+' not fouund!'  );end;
assign(flog,Flogstr);{$I-}rewrite(flog);{$I+}if ioresult<>0 then err('can not write file '+Flogstr );
assign(ftmp,FTmpStr);{$I-}rewrite(ftmp);{$I+}if ioresult<>0 then err('can not write file '+FTmpStr);
clrscr;
writeln;writeln('  ...oooOOO o  ',proga,'  o OOOooo...'#13#10);
while not Eof(f) do
begin
  readln(f,s);
  writeln(flog,s);
  case s[1] of
    charrun:begin delete(s,1,1);inc(frunstri);frunstr[frunstri]:=s;end;
    charcomment:begin writeln(ftmp,s);delete(s,1,1);writeln(s) end;
    charview:
       begin
       delete(s,1,1);
       writecomstr(s);  while not dsr(cs.comno) do;
       while (ReceivedFromCom (cs.ComNo) = 0)and not keypressed do;
       while ReceivedFromCom (cs.ComNo) > 0 do
         begin
         s:=readcomstr;
         writeln(flog,s);
         writeln(ftmp,s);
         writeln(s);
         end;
       end;
    else
       begin
       writecomstr(s); delay(1000); while not dsr(cs.comno) do;
       while ReceivedFromCom (cs.ComNo) > 0 do begin
         writeln(flog,readcomstr);delay(100);end;
       end;
  end;
end;
writeln(flog,'...oooOOO o  END!  o OOOooo...');
close(f);
close(ftmp);
close(flog);



{----add----}

if frunstri <>0 then
for ii:=1 to frunstri do
if frunstr[ii]<>'' then
{if frunstr<>'' then}
{----end----}


   begin
   frunstr[ii]:= '/C ' + frunstr[ii]+' '+ftmpstr;
   SwapVectors;
   Exec(GetEnv('COMSPEC'), frunstr[ii]);
   SwapVectors;
   if DosError <> 0 then err('Could not execute COMMAND.COM '+frunstr[ii]);
   end;
while true do
  begin
  qwer:

  getdate(h,m,se,s0);
  s:= str_(se)+mes[m]+str_(h mod 100)+'.pla';


  write('Save as:');
  reads(s);
  if (s<>'')and(s<>'n')and(s<>'N') then break else
    begin
    write('Если не хотите сохранять нажмите n');
    s[0]:=#1;s[1]:=readkey;writeln;
    if (s[1]='n')or(s[1]='N') then begin s[0]:=#0;break;end;
    end;
  end;
if s<>'' then
  begin
  fsave:=s;
  assign(f,s);
  {$I-}reset(f);{$I+}
  if ioresult=0 then
     begin
     close(f);
     write('файл ',s,' уже существует, перезаписать? ');
     if yn then begin erase(f);rewrite(f);end else
     goto qwer;
     end;
  {$I-}rewrite(f);{$I+}   if ioresult<>0 then begin write('не могу создать файл ',s);goto qwer;end;
  x:=wherex;
  y:=wherey;
  gotoxy(25,25); write(#13#10#13#10#13#10#13#10#13#10#13#10#13#10#13#10);
  x:=10;y:=y-6;
  ramka(x-1,y-1,x+60,y+5);
  gotoxy(x+6,y-1); write('  Ваши комментарии: ');
  writeln(f,';---------------------------------------;');
  gotoxy(x,y); readln(s); writeln(f,';'+s);
  gotoxy(x,y+1); readln(s); writeln(f,';'+s);
  gotoxy(x,y+2); readln(s); writeln(f,';'+s);
  gotoxy(x,y+3); readln(s); writeln(f,';'+s);
  writeln(f,';---------------------------------------;');
  reset(ftmp);
  while not eof(ftmp) do begin readln(ftmp,s);writeln(f,s);end;
  close(f);close(ftmp);
  end else fsave:=ftmpstr;
writeln;
c:=#0;write(#13#10'распечатать?(y/n) ');
if Yn then print;

end;












begin
{----add----}

    frunstri:=0;
{----end----}

initdelay;
cs_ok:=false;
spm:=0;
clrscr;
proga:='';
readcomset;
readspisok;
runreader;


end.