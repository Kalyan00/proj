uses crt,graph;

const maxpuz=10;
      maxtrav=10;
      maxrib=10;
type puz=record
     r,c,x,k:integer;
     y,dy,a,da:real;
     end;
type trav=record
     dx,x:integer;
     y,dy,a,da,day:real;
     end;
type rib=record
     dir,y,b,c:integer;
     x,dx:real;
     end;
procedure zaptrav(var a:trav);
          begin
          with a do begin
          dx:=random(5)+5;
          a:=random*2*pi;
          da:=random/10+0.03;
          x:=random(640);
          y:=480;
          dy:=random/100+0.005;
          day:=random*0.05+0.01;
          end;
          end;
procedure zap(var a:puz);
          begin
          a.x:=random(640);
          a.r:=10+random(40);
          a.y:=480+a.r;
          a.c:=1+random(15);
          a.a:=0;
          a.da:=random/10+0.1;
          a.dy:=random+0.5;
          a.k:=random(10)+2;
          end;
procedure zaprib(var a:rib);
          begin
          with a do
          begin
          dir:=random(2)*2-1;
          b:=5+random(20);
          y:=random(440)+20;
          c:=1+random(15);
          dx:=random+0.5;
          x:=320+dir*320;
          end;
          end;
procedure hodtrav(var b:trav);
          begin
          with b do
          begin
          y:=Y-dy;
          a:=a-da;
          end;
          end;
procedure hod(var b:puz);
          begin
          with b do
          begin
          y:=Y-dy;
          a:=a+da;
          end;
          end;
procedure hodrib(var b:rib);
          begin
          with b do x:=x-dir*dx;
          end;
procedure ristrav(var b:trav);
          var c:integer;
          const t=1;
          procedure rr(b:trav);
                    var i,yy:integer;
                    begin
                    with b do begin
                    yy:=round(y);
                    for i:=0 to (480-yy)*t do
                    putpixel(x+round(dx*sin(a+day*(i/t))),480-i div t,c);
                    end;end;
          begin
          c:=0;
          rr(b);
          if b.y<0 then zaptrav(b);
          hodtrav(b);
          c:=2;
          rr(b);
          end;
procedure ris(var b:Puz);
          begin
          with b do
               begin
               setcolor(0);
               circle(round(x+k*sin(a)),round(y),r);
               circle(round(x+k*sin(a)-r/4),round(y-r/1.6),round(r/10));
               if y<-r then zap(b);
               hod(b);
               setcolor(c);
               circle(round(x+k*sin(a)),round(y),r);
               circle(round(x+k*sin(a)-r/4),round(y-r/1.6),round(r/10));

               end;
          end;
procedure risrib(var a:rib);
          procedure ribb(var a:rib);
          var xx:integer;
          begin
          with a do
               begin
               xx:=round(x);
               moveto(xx,y);
               lineto(xx+dir*2*b,y-2*b);
               lineto(xx+dir*4*b,y-2*b);
               lineto(xx+dir*8*b,y+2*b);
               lineto(xx+dir*8*b,y-b);
               lineto(xx+dir*4*b,y+b);
               lineto(xx+dir*b,y+b);
               lineto(xx,y);
               circle(xx+dir*((3*b) div 2),y-b,b div 5);
               end;
          end;

          begin
          with a do
               begin
               setcolor(0);
               ribb(a);
               if dir*x+8*b<dir*320-320 then zaprib(a);
               hodrib(a);
               setcolor(c);
               ribb(a);
               end;
          end;
procedure igr;
          var
            grDriver: Integer;
            grMode: Integer;
            ErrCode: Integer;
          begin
            grDriver := Detect;
            InitGraph(grDriver, grMode,'');
            ErrCode := GraphResult;
            if ErrCode <> grOk then
            begin  writeln('error: initgr');halt end;
            setcolor(4);
            outtextxy(270,240,'hello Mashka!');
            end;

var r:array[0..maxpuz]of puz;
var ri:array[0..maxrib]of rib;
var rt:array[0..maxtrav]of trav;
    i,j:byte;
    maxp,maxr,maxt:byte;
begin
randomize;
igr;
maxt:=random(maxtrav)+1;
maxp:=random(maxpuz)+1;
maxr:=random(maxrib)+1;
for i:=0 to maxp do zap(r[i]);
for i:=0 to maxr do zaprib(ri[i]);
for i:=0 to maxt do zaptrav(rt[i]);
while not keypressed do begin
for i:=0 to maxp do ris(r[i]);
for i:=0 to maxr do risrib(ri[i]);
for i:=0 to maxt do ristrav(rt[i]);
end;
readkey;
closegraph;
end.
