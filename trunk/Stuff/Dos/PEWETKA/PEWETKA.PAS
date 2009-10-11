uses graph,crt;
type circ_= record
           x,y,vx,vy,fx,fy,m:real;
           end;
var
circ: array[1..200] of circ_;
n:byte;
const
dt=3;
g=10;{коэфф при силе притяж}
g1=10000;{коэфф при силе отталк}
r=5;
fr=0.5;

procedure ctir(i:byte);
begin
     setcolor(0);
     circle(round(circ[i].x),round(circ[i].y),round(r*circ[i].m));
end;


procedure ris(i:byte);
begin
     setcolor(12);
     circle(round(circ[i].x),round(circ[i].y),round(r*circ[i].m));
end;

procedure born;
var i:byte;
begin
     randomize;
     n:=61;
     for i:=1 to n do
         begin
              circ[i].x:=random(640-2*r)+r;
              circ[i].y:=random(480-2*r)+r;
              circ[i].vx:=0;
              circ[i].vy:=0;
              circ[i].m:=0.3+random(2);
        end;
end;

function rasst(a,b:byte):real;
begin
     rasst:=sqrt(sqr(circ[a].x-circ[b].x)+sqr(circ[a].y-circ[b].y));
end;

function fskal(l,m1,m2:real):real;
begin       {положительная сила - притягиваются}
     fskal:=(g*m1*m2/(l*l))-(g1*m1*m2/(l*l*l*l))
end;

procedure sily;
var i,k:byte;
df,l:real;
begin
     for i:=1 to n do
         begin
          circ[i].fx:=0;
          circ[i].fy:=0;
         end;
     for i:=1 to n-1 do
         for k:=i+1 to n do
             begin
                  l:=rasst(i,k);
                  df:=fskal(l,circ[i].m,circ[k].m)/l;
                  circ[k].fx:=circ[k].fx+df*(circ[i].x-circ[k].x);
                  circ[i].fx:=circ[i].fx-df*(circ[i].x-circ[k].x);
                  circ[k].fy:=circ[k].fy+df*(circ[i].y-circ[k].y);
                  circ[i].fy:=circ[i].fy-df*(circ[i].y-circ[k].y);
             end;
end;

procedure step;
var i:byte;
begin
     for i:=1 to n do
         begin
          ctir(i);
          circ[i].vx:=circ[i].vx+circ[i].fx*dt/circ[i].m;
          circ[i].vy:=circ[i].vy+circ[i].fy*dt/circ[i].m;
          circ[i].x:=circ[i].x+circ[i].vx*dt;
          circ[i].y:=circ[i].y+circ[i].vy*dt;
          ris(i);
         end;
end;

procedure  frost;
var i:byte;
begin
if random<fr then
for i:=1 to n do
with circ[i] do
begin
vx:=0.9*vx;
vy:=0.9*vy;
end;
end;


var Gd, Gm: Integer;
begin
  Gd := Detect;
  InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then
    Halt(1);

born;

repeat
sily;
step;
frost;
until keypressed;

{closegraph;{}
end.

