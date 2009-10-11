unit vect;
INTERFACE
type vector=string[12];

     point=record
     case integer of
     0:(rezerved:byte;x,y:real);
     1:(v:vector);
     end;
const null:point=(rezerved:12;x:0;y:0); {v:#0#0#0#0#0#0#0#0#0#0#0#0}


function  modul(a:vector):real;
function  vectt__(var a:vector):vector;
function  pls(aa,bb:vector):vector;
function  mns(aa,bb:vector):vector;
function  mul(aa:vector;r:real):vector;
function  fi(a:vector):real;
function  fir(fi,r:real):vector;


IMPLEMENTATION
function  vectt__(var a:vector):vector;
          begin a[0]:=#12;vectt__:=a;end;
function  modul(a:vector):real;
          var aa:point;
          begin vectt__(a);aa.v:=a;modul:=sqrt(sqr(aa.x)+sqr(aa.y));end;
function  pls(aa,bb:vector):vector;
          var a,b:point;
          begin
          vectt__(aa);
          vectt__(bb);
          a.v:=aa;
          b.v:=bb;
          a.x:=a.x+b.x;
          a.y:=a.y+b.y;
          pls:=a.v;
          end;
function  mns(aa,bb:vector):vector;
          var a,b:point;
          begin
          vectt__(aa);
          vectt__(bb);
          a.v:=aa;
          b.v:=bb;
          a.x:=a.x-b.x;
          a.y:=a.y-b.y;
          mns:=a.v;
          end;

function  mul(aa:vector;r:real):vector;
          var a:point;
          begin
          vectt__(aa);
          a.v:=aa;
          a.x:=a.x*r;
          a.y:=a.y*r;
          mul:=a.v;
          end;
function  fi(a:vector):real;
          var b:point;f:real;
          begin
          vectt__(a);
          b.v:=a;
          if b.x<>0 then
          f:=arctan(abs(b.y/b.x))
          else f:=pi/2;
          if b.x<0 then f:=pi-f;{}
          if b.y<0 then f:=-f;{}
          fi:=f;
          end;
function  fir(fi,r:real):vector;
          var a:point;
          begin
          a.x:=0;
          if r<0 then a.x:=1/a.x;
          vectt__(a.v);
          a.x:=r*cos(fi);
          a.y:=r*sin(fi);
          fir:=a.v;
          end;

end.