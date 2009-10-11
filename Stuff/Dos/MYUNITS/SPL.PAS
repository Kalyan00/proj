HEDODELAH
uses vect;
procedure spline(a1,b1,c1,d1:vector);
          var a,b,c,d,a2,b2,c2,d2:point;
          begin
          a2.v:=a1;
          b2.v:=b1;
          c2.v:=c1;
          d2.v:=d1;
          a.v:=fir(0,0);
          b.v:=fir(fi(mns(b2.v,a2.v))-fi(mns(d2.v,a2.v)),modul(mns(b2.v,a2.v)));
          c.v:=fir(fi(mns(c2.v,a2.v))-fi(mns(d2.v,a2.v)),modul(mns(c2.v,a2.v)));
          d.v:=fir(fi(mns(d2.v,a2.v))-fi(mns(d2.v,a2.v)),modul(mns(d2.v,a2.v)));


          end;
begin

end.
