unit chervtxt;
interface
   uses crt;
   procedure cherv_txt;
   procedure chervinit(x,y,xx,yy:byte;ck:longint);
implementation

const ch_vert       =  ord('º') ;
      ch_hor        =  ord('Í') ;
      ch_up_left    =  ord('¼') ;
      ch_up_right   =  ord('È') ;
      ch_down_left  =  ord('»') ;
      ch_down_right =  ord('É') ;
      ch_golova     =  ord('') ;
      ch_hvost_up   =  ord('') ;
      ch_hvost_down =  ord('') ;
      ch_hvost_left =  ord('') ;
      ch_hvost_right=  ord('') ;
      ch_eda        =  ord('') ;

var cherv_len:byte;
    cherv_table:array[0..2]of array[0..255]of byte;
    chervinit000_1:boolean;
    XX_XOLD, YY_YOLD,edax,eday:byte;
    ckopostb1:longint;
    ckopostb2:longint;
    xmax,ymax,xx_x,yy_y:byte;




{---------------------------------------------------------------}
function isthisspase(x,y:byte):boolean;
var i:word;
begin
isthisspase:=true;
for i:= 0 to cherv_len do
if (cherv_table[1,i]=x)and(cherv_table[2,i]=y)then
isthisspase:=false;
if (x>xmax )or(y>ymax)then
isthisspase:=false;
end;


procedure ramka(x,y,xx,yy:byte);
var qx,qy,i:byte;qxx,qyy:word;
begin
qx:=wherex;
qy:=wherey;
qxx:=windmax;
qyy:=windmin;
windmax:=25*$100+80;
windmin:=0;
for i:=x+1 to xx-1 do begin
gotoxy(i,y);write('Í') ;
gotoxy(i,yy);write('Í') ;
end;
for i:=y+1 to yy-1 do begin
gotoxy(x,i);write('º') ;
gotoxy(xx,i);write('º') ;
end;
gotoxy(x,y);write('É') ;
gotoxy(xx,y);write('»') ;
gotoxy(xx,yy);write('¼') ;
gotoxy(x,yy);write('È') ;
windmax:=qxx;
windmin:=qyy;
gotoxy(qx,qy);
end;




procedure cherv_init;
var x,y,i,j:byte;wm,wmm:word;
begin
x:=wherex;
y:=wherey;
wm:=windmin;
wmm:=windmax;

windmin:=0;
windmax:=25*$100+80;
ramka(xx_x-1,YY_Y-1,xx_x+xmax+1,yy_y+ymax+1);
for i:=0 to xmax do for j:=0 to ymax do begin
gotoxy(XX_X+i,YY_Y+j);write(' ');end;

edax:=(xmax div 2) ;
eday:=(ymax div 2) -1;
for j:=0to 255 do
for i:=0to 2 do
cherv_table[i,j]:=0;
cherv_len:=1;
cherv_table[0,0]:=ch_golova;
cherv_table[1,0]:=xmax div 2;
cherv_table[2,0]:=ymax div 2;
cherv_table[0,1]:=ch_hvost_down;
cherv_table[1,1]:=xmax div 2;
cherv_table[2,1]:=(ymax div 2 )+1;
chervinit000_1:=true;
windmin:=wm;
windmax:=wmm;
gotoxy(x,y);
end;



procedure cherv_print;
var x,y,i:byte;xx,yy:word;
begin
x:=wherex;
y:=wherey;
xx:=windmax;
yy:=windmin;
windmax:=25*$100+80;
windmin:=0;
gotoxy(XX_X+XX_Xold,YY_Y+YY_Yold);
write(' ');
for i:=0 to cherv_len do begin
gotoxy(cherv_table[1,i]+XX_X,cherv_table[2,i]+YY_Y);
write(chr(cherv_table[0,i])) ;
end;
gotoxy(edax+xx_x,eday+yy_y);
write(chr(ch_eda)) ;
windmax:=xx;
windmin:=yy;
gotoxy(x,y);

end;










procedure cherv_txt;
var x,y,k,i:byte;
begin
inc(ckopostb2);
if ckopostb2<ckopostb1 then exit;
ckopostb2:=0;
if not chervinit000_1 then cherv_init;
cherv_print;
k:=0;
repeat
x:=cherv_table[1,0];
y:=cherv_table[2,0];
i:=0;
if isthisspase(x-1,y)then inc(i);
if isthisspase(x+1,y)then inc(i);
if isthisspase(x,y-1)then inc(i);
if isthisspase(x,y+1)then inc(i);
if i=0 then chervinit000_1:=false;
i:=random(10);
if i=0 then x:=cherv_table[1,0]-1 else
if i=1 then x:=cherv_table[1,0]+1 else
if i=2 then y:=cherv_table[2,0]-1 else
if i=3 then y:=cherv_table[2,0]+1 else
begin
if abs( edax-cherv_table[1,0])>abs(eday-cherv_table[2,0]) then
 if edax>cherv_table[1,0] then x:=cherv_table[1,0]+1 else x:=cherv_table[1,0]-1
else
 if eday>cherv_table[2,0] then y:=cherv_table[2,0]+1 else y:=cherv_table[2,0]-1;


end;
until isthisspase(x,y) or not chervinit000_1;
if (x=edax)and(y=eday)then
begin
if   (cherv_table[0,cherv_len]=ch_hvost_up )or
     (cherv_table[0,cherv_len]=ch_hvost_down )then
     cherv_table[0,cherv_len]:=ch_vert else
     cherv_table[0,cherv_len]:=ch_hor;
inc(cherv_len);
repeat
edax:=random(xmax)+1;
eday:=random(ymax)+1;
until isthisspase(edax,eday);
end;
if((x>cherv_table[1,0])and(cherv_table[1,0]>cherv_table[1,1]))or
((x<cherv_table[1,0])and(cherv_table[1,0]<cherv_table[1,1])) then
  cherv_table[0,0]:=ch_hor else
if((y>cherv_table[2,0])and(cherv_table[2,0]>cherv_table[2,1]))or
((y<cherv_table[2,0])and(cherv_table[2,0]<cherv_table[2,1])) then
  cherv_table[0,0]:=ch_vert else
if(x>cherv_table[1,0])and(cherv_table[2,0]>cherv_table[2,1])
  or(y<cherv_table[2,0])and(cherv_table[1,0]<cherv_table[1,1])
  then   cherv_table[0,0]:=ch_up_right else
if(x>cherv_table[1,0])and(cherv_table[2,0]<cherv_table[2,1])
  or(y>cherv_table[2,0])and(cherv_table[1,0]<cherv_table[1,1])
  then  cherv_table[0,0]:=ch_down_right  else
if(x<cherv_table[1,0])and(cherv_table[2,0]<cherv_table[2,1])
  or(y>cherv_table[2,0])and(cherv_table[1,0]>cherv_table[1,1])
  then  cherv_table[0,0]:=ch_down_left else
if(x<cherv_table[1,0])and(cherv_table[2,0]>cherv_table[2,1])
  or(y<cherv_table[2,0])and(cherv_table[1,0]>cherv_table[1,1])
  then  cherv_table[0,0]:=ch_up_left  else cherv_init;
XX_Xold:=cherv_table[1,cherv_len];
YY_Yold:=cherv_table[2,cherv_len];
for i:=cherv_len downto 1do for k:=0to 2do
  cherv_table[k,i]:=cherv_table[k,i-1]; {-----------------------}
  cherv_table[0,0]:=ch_golova  ;
  cherv_table[1,0]:=x  ;
  cherv_table[2,0]:=y  ;
if  cherv_table[2,cherv_len-1]>cherv_table[2,cherv_len]then
  cherv_table[0,cherv_len]:=ch_hvost_up  ;
if  cherv_table[2,cherv_len-1]<cherv_table[2,cherv_len]then
  cherv_table[0,cherv_len]:=ch_hvost_down  ;
if  cherv_table[1,cherv_len-1]>cherv_table[1,cherv_len]then
  cherv_table[0,cherv_len]:=ch_hvost_left  ;
if  cherv_table[1,cherv_len-1]<cherv_table[1,cherv_len]then
  cherv_table[0,cherv_len]:=ch_hvost_right  ;
end;



procedure chervinit(x,y,xx,yy:byte;ck:longint);
begin
xx_x:=x;
YY_Y:=Y;
xmax:=XX-XX_X;
ymax:=YY-YY_Y;
ckopostb1:=ck;
end;





begin
chervinit000_1:=false;
ckopostb1:=100000;
xx_x:=65;
YY_Y:=2;
xmax:=12;
ymax:=6;
end.
