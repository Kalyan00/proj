 {$N+}unit matr_;

INTERFACE
const Q=10;
type
   vec=array[1..Q]of real;
   matr= record
     ii,jj:integer;
     a:array[1..Q] of vec;
   end;

function determ(a:matr):real;

IMPLEMENTATION



function determ(a:matr):real;
var x,i,j,f:integer; b:matr; det:real;
begin
  if (a.jj<>a.ii) or (a.jj<0)or (a.jj>Q) then
     begin writeln('couldn''t count a determinal ');halt(1);
  end;
  if a.jj=1 then determ:=a.a[1,1] else
    begin
    fillchar(b,sizeof(matr),#0);
    det:=0;b.ii:=a.ii-1;b.jj:=a.jj-1;
    for x:=1 to a.ii do
       begin f:=1;
       for i:=1 to a.ii-1 do
         begin
         f:=1;
         for j:=1 to a.jj do
         if x<>j then
           begin
           b.a[i,f]:=a.a[i,j];
           inc(f);
         end;
       end;
    if (a.ii+x) mod 2=0 then
    det:=det+a.a[a.ii,x]*determ(b) else
    det:=det-a.a[a.ii,x]*determ(b) ;
  end;
  determ:=det;
end;
end;

end.