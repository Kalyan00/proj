 {$N+}                                {ДОРОЖКИ 1.1}

program doroji1_1;

uses
  crt,
  DRIVERS,
  Graph;

const
  UP_KEY=ord('H');
  DOWN_KEY=ord('P');
  LEFT_KEY=ord('K');
  RIGHT_KEY=ord('M');
  ESC_KEY=27;
  ENTER_KEY=13;
  KEY_0=ord('0');
  PLAY_WHITH_KOMP=true;
  HODMAX=20;



var
  player_f1:array[0..50] of byte;
  player_f2:array[0..50] of byte;
  KOL_KL:byte;
  KOL_DOR:byte ;
  HOD:byte;

  kletka:byte;
  POLEX,POLEY:word;
  COLOR1,COLOR2,color3:ByTE;
  GAME:boolean;
  CURENT_DOR:byte;
  PLAYER_FIRST:boolean;







 {-----------------------------------------------------------------------------}
procedure initg;
var  grDriver,  grMode,  ErrCode: Integer;
begin  grDriver := Detect;  InitGraph(grDriver, grMode,'');
  ErrCode := GraphResult;   if ErrCode <>grOk then
  Writeln('Graphics error:', GraphErrorMsg(ErrCode));
end;

procedure HALT0;forward;











 {-----------------------------------------------------------------------------}
function str_int(a:byte):string;
var s:string[5];
begin
s:='';
if(a>=100)then s:=chr(a div 100 + Key_0);
if(a>=10)then s:=s+chr((a div 10) -(a div 100)*10 + Key_0);
s:=s+chr(a - (a div 10)*10+KEY_0);
str_int:=s;
end;










 {-----------------------------------------------------------------------------}
function vvod_int(a,b,e,f:byte):byte;
var c,d,i:byte;
begin
i:=a;
c:=0;
setcolor(4);
bar(e-10,f-2,e+30,f+10);
outtextxy(e,f,str_int(i));
d:=ord(readkey);
while((d<>ENTER_KEY) and (d<>ESC_KEY))do
begin
if d=0 then
begin
d:=ord(readkey);
if(d=DOWN_KEY)then i:=i-1;
if i<a then i:=b;
if(d=UP_KEY)then i:=i+1;
if i>b then i:=a;
if(d=LEFT_KEY)then i:=a;
if(d=RIGHT_KEY)then i:=b;
end;
setcolor(4);
bar(e-10,f-2,e+30,f+10);
outtextxy(e,f,str_int(i));
d:=ord(readkey);
end;
if d=ESC_KEY then
begin
vvod_int:=a;
setcolor(4);
bar(e-10,f-2,e+30,f+10);
outtextxy(e,f,str_int(a));
end;
if d=ENTER_KEY then vvod_int:=i;
setcolor(15);

end;


 {-----------------------------------------------------------------------------}
function GET_X(a:bYte):word; begin Get_X:=polex+a*kletka;end;

function GET_Y(a:bYte):word; begin Get_Y:=poley+a*kletka;end;

function GET_Y_center(a:bYte):word;
begin Get_Y_center:=(GET_Y(A) + GET_Y(a+1) -2 -kletka div 10)div 2;end;

function GET_X_center(a:bYte):word;
begin Get_X_center:=(GET_X(A) + GET_X(a+1) -2 -kletka div 10)div 2;end;

procedure sleep(a:word);
var i:double;
begin
i:=60000*a; while(i>2)and not keypressed do i:=i-1;
end;

PROCEDURE CLEAR_KEY; BEGIN while keypressed do readkey;END;


 {-----------------------------------------------------------------------------}
procedure vvod;
var iot,a,b:byte;
begin
moveto(280,80);outtext('GAME');
moveto(190,110);outtext(' .-= ON THE ROADS v1.1 =-.');
sleep(30);
CLEAR_KEY;

ClearDevice;

moveto(50,50);outtext('how long  is the  step');
HOD:=vvod_int(2,HODMAX,240,50);
moveto(50,80);outtext('how     many     roads');
KOL_DOR:=vvod_int(1,30,240,80);
moveto(50,110);outtext('how long  is the  road');
KOL_KL:=vvod_int(HOD+2,100,240,110);
moveto(50,140);outtext('who is the first [1/2]');
iot:=vvod_int(1,2,240,140);
if iot=1 then PLAYER_FIRST:=true else   PLAYER_FIRST:=false;

COLOR1:=12;
COLOR2:=4;
COLOR3:=14;
a:=(540 div KOL_KL);
b:=(400 div KOL_DOR);
if(a>b) then
begin
kletka:=b;
poleY:=40;
polex:=320-((KOL_KL*kletka) div 2);
end
else
begin
kletka:=a;
poley:=240-((KOL_DOR*kletka) div  2);
polex:=50;
end;

ClearDevice;
end;



 {-----------------------------------------------------------------------------}
procedure SIRCLE(a,b,c:byte);
var OldPattern : FillPatternType;
begin SetColor(c);
circle(get_x_center(a),get_y_center(b),KLETKA div 3);
GetFillPattern(OldPattern);setfillpattern(oldpattern,c);
floodfill(get_x_center(a),get_y_center(b),c);
end;




procedure SIRCLE_min(a,b,c:byte);
var OldPattern : FillPatternType;
begin SetColor(c);
circle(get_x_center(a),get_y_center(b),KLETKA div 5);
GetFillPattern(OldPattern);setfillpattern(oldpattern,c);
floodfill(get_x_center(a),get_y_center(b),c);
end;

 {-----------------------------------------------------------------------------}
procedure BAR2(a,b:byte);
var OldPattern : FillPatternType;
begin GetFillPattern(OldPattern);setfillpattern(oldpattern,15);
setcolor(15);bar(get_x(a),GET_Y(b),get_x(a+1)-2-kletka div 10,get_y(b+1)-2-kletka div 10);
end;














 {-----------------------------------------------------------------------------}
procedure pole;
var a,b:byte;
begin
a:=0;
b:=0;
while a<>KOL_KL  do
begin
while b<>KOL_DOR do
begin
bar2(a,b);
b:=b+1;
end;
b:=0;
a:=a+1;
end;
a:=0;
while a<>KOL_DOR DO
begin
player_f1[a]:=0;
player_f2[a]:=KOL_KL-1;
SIRCLE(0,a,COLOR1);
SIRCLE(KOL_KL-1,a,COLOR2);
a:=a+1;
end;
bar(8,10,100,25);
setcolor(15);
outtextxy(15,15,'Step: ');
outtextxy(80,14,str_int(HOD));

end;









 {-----------------------------------------------------------------------------}
procedure morgalka(player,dor:byte);
begin
while true do
begin
sleep(2);
if(player=1)then sircle_min(player_f1[dor],dor,color3);
if(player=2)then sircle_min(player_f2[dor],dor,color3);
sleep(1);
if(player=1)then sircle(player_f1[dor],dor,color1);
if(player=2)then sircle(player_f2[dor],dor,color2);
if not not keypressed then break;
end;



 end;



 {-----------------------------------------------------------------------------}
PROCEdure hod_pl2;
var a,X_old,Y,i,iii: byte;
    OldPattern : FillPatternType;
begin
Y:=CURENT_DOR; X_old:=player_f2[y];
iii:=0;
i:=0;
while iii<KOL_DOR do
begin
if(player_f1[iii]<>KOL_KL-2)then i:=1;
iii:=iii+1;
end;
if i=0 then
begin
setcolor(12);
GetFillPattern(OldPattern);setfillpattern(oldpattern,1);
BAR(270,230,420,250);
outtextxy(280,240,'PLAYER 2 IS OWER');
sleep(30);
clear_key;
HALT0;
end;
if game then morgalka(2,y);
if game then a:=ord(readkey);
if game then if a=13 then a:=1;
while (a<>ENTER_KEY )and game do
begin

if a=0 then
begin
   a:=ord(readkey);
   if a=up_key then
   begin
       bar2(player_f2[y],y);
       sircle(x_old,y,color2);
       player_f2[y]:=X_OLD;
       if(y>0)then  y:=y-1 else y:=KOL_DOR-1;
       sircle(player_f2[y],y,color2);
       X_old:=PLAYER_f2[y];
   end else
   if a=down_key then
   begin
       bar2(player_f2[y],y);
       sircle(x_old,y,color2);
       player_f2[y]:=X_OLD;
       if(y<KOL_DOR-1)then  y:=y+1 else y:=0;
       sircle(player_f2[y],y,color2);
       X_old:=PLAYER_f2[y];
   end else
   if a=left_key then
   begin
       if (player_f2[y]>player_f1[y]+1)and (x_old-player_f2[y]<HOD)then
       begin
       bar2(player_f2[y],y);
       player_f2[y]:=player_f2[y]-1;
       sircle(player_f2[y],y,color2);
       end;
   end else
   if a=right_key then
   begin
      if (player_f2[y]<KOL_KL-1)and (player_f2[y]-x_old<HOD) then
      begin
      bar2(player_f2[y],y);
      player_f2[y]:=player_f2[y]+1;
      sircle(player_f2[y],y,color2);
      end;
   end;

   a:=0;
end;
   if a=esc_key then HALT0;
morgalka(2,y);
if game then a:=ord(readkey);
if game and (a=ENTER_KEY) and (X_old=player_f2[y])then a:=1;
end;
CURENT_DOR:=y;

end;

 {-----------------------------------------------------------------------------}
PROCEdure hod_pl1;
var a,X_old,Y,i,iii: byte;
    OldPattern : FillPatternType;
begin
Y:=CURENT_DOR; X_old:=player_f1[y];
iii:=0;
i:=0;
while iii<KOL_DOR do
begin
if(player_f2[iii]<>1)then i:=1;
iii:=iii+1;
end;
if i=0 then
begin
setcolor(12);
GetFillPattern(OldPattern);setfillpattern(oldpattern,1);
BAR(270,230,420,250);
outtextxy(280,240,'PLAYER 1 IS OWER');
GAME:=False;
sleep(30);
clear_key;
HALT0;
end;

if game then morgalka(1,y);
if game then a:=ord(readkey);
if game then if a=13 then a:=1;
while a<>ENTER_KEY do
begin

if a=0 then
begin
   a:=ord(readkey);
   if a=up_key then
   begin
       bar2(player_f1[y],y);
       sircle(x_old,y,color1);
       player_f1[y]:=X_OLD;
       if(y>0)then  y:=y-1 else y:=KOL_DOR-1;
       sircle(player_f1[y],y,color1);
       X_old:=PLAYER_f1[y];
   end else
   if a=down_key then
   begin
       bar2(player_f1[y],y);
       sircle(x_old,y,color1);
       player_f1[y]:=X_OLD;
       if(y<KOL_DOR-1)then  y:=y+1 else y:=0;
       sircle(player_f1[y],y,color1);
       X_old:=PLAYER_f1[y];
   end else
   if a=left_key then
   begin
       if (player_f1[y]<>0)and (x_old-player_f1[y]<HOD)then
       begin
       bar2(player_f1[y],y);
       player_f1[y]:=player_f1[y]-1;
       sircle(player_f1[y],y,color1);
       end;
   end else
   if a=right_key then
   begin
      if (player_f1[y]<player_f2[y]-1)and (player_f1[y]-x_old<HOD) then
      begin
      bar2(player_f1[y],y);
      player_f1[y]:=player_f1[y]+1;
      sircle(player_f1[y],y,color1);
      end;
   end;

   a:=0;
end;
   if a=esc_key then halt0;
morgalka(1,y);
if game then a:=ord(readkey);
if game and (a=ENTER_KEY) and (X_old=player_f1[y])then a:=1;
end;
CURENT_DOR:=y;
end;

 {-----------------------------------------------------------------------------}
procedure II_PROIGR;                 {исскувств. интеллект}
var    OldPattern : FillPatternType;

begin                                {проиграл            }
setcolor(12);
GetFillPattern(OldPattern);setfillpattern(oldpattern,1);
BAR(270,230,420,250);
outtextxy(280,240,'PLAYER 2 IS OWER');
sleep(30);
clear_key;
HALT0;
end;







 {-----------------------------------------------------------------------------}
procedure HOD_II2(a:byte;b:integer); {графичес. процедура }
begin
CURENT_DOR:=a;                        {хода + PLAYER_F2[a]-=b   }
repeat
sircle_min(player_f2[a],a,color3);
sleep(1);
sircle(player_f2[a],a,color2);
sleep(1);
bar2(player_f2[a],a);
if(b>0)then begin b:=b-1; player_f2[a]:=player_f2[a]-1; end
else        begin b:=b+1; player_f2[a]:=player_f2[a]+1; end
until b=0;
clear_key;
morgalka(2,a);
{clear_key;}
end;



 {-----------------------------------------------------------------------------}
procedure HOD_II;                          {ИСКУВСТВ ИНТЕЛ}
var i,j,k:byte;P:array[0..HODMAX] of byte;
begin
  for i:=0 to HODMAX do P[i]:=0;           {чистка Р} {заполнение Р}
  for i:=0 to KOL_DOR -1 do inc( P[(player_f2[i]-player_f1[i]-1)mod(HOD+1)] );
  i:=0;
  if((kol_dor-p[0])mod 2=1)then          { не закрытых дорожек нечетное?}
  begin
    K:=1;                                   {ДА}
    WHILE(P[k]mod 2=0)do k:=k+1;
    if(k<=hod) then
    while(player_f2[i]-player_f1[i]-1)mod(hod+1)<>k do inc(i)
    else while(player_f2[i]-player_f1[i]-1)mod(hod+1)=0 do inc(i);
    if(i<=KOL_DOR)then
      HOD_II2(i,(player_f2[i]-player_f1[i]-1)mod(hod+1))
    else
    begin
      i:=0;
      while(player_f2[i]=KOL_KL-1)do inc(i);
      if(i<kol_dor) then
        HOD_II2(i,-1)
      else  II_PROIGR;
    end;
  end
  else
  begin
    i:=1;
    while(p[i]mod 2=0)do inc(i);
    if(i<=hod)then
    begin
      j:=i+1;
      while(p[j]mod 2=0)do
      inc(j);
      if(j<=hod)then
      begin
        k:=0;
        while(player_f2[k]-player_f1[k]-1)mod(hod+1)<>j do inc(k);
        HOD_II2(k,j-i);
      end else write(chr(7),chr(7),chr(7),chr(7));
    end
    else
    begin
      i:=0;
      while(player_f2[i]-player_f1[i]-1)mod(hod+1)=0do inc(i);
      if(i<KOL_dor)then HOD_II2(i,1) else
      begin
        i:=0;
        while(player_f2[i]-player_f1[i]-1)=0do inc(i);
        if(i<KOL_dor)then HOD_II2(i,1) else
        begin
          i:=0;
          while(player_f2[i]=KOL_KL-1)do inc(i);
          if(i<kol_dor) then
            HOD_II2(i,-1)
          else  II_PROIGR;
        end;
      end;
    end;
  end;
end;



 {-----------------------------------------------------------------------------}
PROCeDURE game_PLAY;
begin
while game do begin
if game then if  PLAY_WHITH_KOMP then HOD_II else HOD_PL2;
HOD_PL1;
END;
end;

procedure HALT0;
begin
sleep(2);
closegraph;
halt(0);
end;





 {-----------------------------------------------------------------------------}
begin
CURENT_DOR:=0;
CtrlBreakHit:= true;
GAME:=TRUE;
initg;
vvod;
POLE;
if PLAYER_FIRST then HOD_PL1;
GAME_PLAY;
CLEAR_KEY;
closegraph;
end.






{}