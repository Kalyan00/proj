program Lab_work;
Uses dos,crt;
label 10,20,30;
const
  nmax = 4;
  xmax = 100;
  Kz   = 2;
type
  mass1 = array[1..nmax+1] of real;
var
 x,
 ym,
 yr:mass1;
 a,b:real;
 sigmao,
 sigma:real;
 fill:text;
 i,j:integer;
 flag:boolean;
 ch:char;
 regul,
 sluch:mass1;
 fil2:text;
 kk:real;

procedure koef;
 var
  sum_x,
  sum_y,
  sum_xy,
  sum_x2:real;
  deto,deta,detb:real;
  j:integer;
begin
 sum_x:=0;
 sum_y:=0;
 sum_xy:=0;
 sum_x2:=0;
  for j :=1 to nmax do
   begin
   sum_x:=sum_x+x[j];
   sum_y:=sum_y+ym[j];
   sum_xy:=sum_xy+x[j]*ym[j];
   sum_x2:=sum_x2+sqr(x[j]);;
  end;
 deto := Nmax*sum_x2 - sqr(sum_x);
 deta := nmax*sum_xy - sum_y*sum_x;
 detb := sum_x2*sum_y -sum_x*sum_xy;
 a:=deta/deto;
 b:=detb/deto;
end;

procedure sdvig;
 Var
  j:integer;
begin
 for j:=1 to nmax do
  begin
  x[j]:=x[j+1];
  ym[j]:=ym[j+1];
  yr[j]:=yr[j+1];
 end;
end;

procedure Pogreshnost;
 var
  sum: real;
  j:integer;
 begin
  sum :=0;
   for j := 1 to nmax do
    sum := sum + sqr(yr[j]-ym[j]);
  sigma := sqrt(sum)/nmax;
end;


procedure znachenye;
 var
  i,j:integer;
  ks: real;
  k: integer;
 begin
  for j := 1 to nmax do
    begin
      if flag = false then ym[j] := a*x[j]+b;
     ks := random;
      if ks<=0.5 then k:=-1
         else  k :=1;
      if flag = true then kk := 0.05
         else kk:=0.0005;
     yr[j] := ym[j] + kk*x[j] + k*ks*ym[j]*0.0001;
     regul[j]:=kk*x[j];
     sluch[j]:=k*ks*ym[j]*0.0001;
  end;
end;

procedure znachenye1;
 var
  ks: real;
  k: integer;
 begin
  ym[i] := a*x[i] + b;
  ks := random;
   if ks<=0.5 then k:=-1
    else  k :=1;
  yr[i] := ym[i] + kk*x[i] + k*ks*ym[i]*0.0001;
  regul[i]:=kk*x[i];
  sluch[i]:=k*ks*ym[i]*0.0001;
end;



BEGIN
 clrscr;
 assign (fill,'parametr.nul');
 reset(fill);
  for i :=1 to nmax do
  begin
   x[i] := i;
   readln(fill,ym[i]);
  end;
 close(fill);
 assign(fil2,'parametr.002');
 rewrite(fil2);
 koef;
 flag:=true;
 znachenye;
 flag := false;
 pogreshnost;
 sigmao := sigma*kz;
 writeln('      точка  мат.модель  реал.процесс  регул.состав.  случ.состав.');
  for i :=1 to 80 do write('-');
 writeln(fil2,'      точка  мат.модель  реал.процесс  регул.состав.  случ.состав.');
  for i :=1 to 80 do write(fil2,'-');
  for i :=1 to nmax do
   writeln('     ',x[i]:3:0,'    ',ym[i]:8:3,'    ',yr[i]:8:3 ,'   ',regul[i]:8:5,'         ',sluch[i]:8:5);
  for i :=1 to 80 do write('-');
   writeln('коэффициенты : A=',a:14:11,' ,B = ',b:14:11,', sigma = ',sigma:7:4);
  for i :=1 to 80 do write('-');
  for i :=1 to nmax do
   writeln(fil2,'     ',x[i]:3:0,'    ',ym[i]:8:3,'    ',yr[i]:8:3 ,'   ',regul[i]:8:5,'         ',sluch[i]:8:5);
  for i :=1 to 80 do write(fil2,'-');
   writeln(fil2,'коэффициенты : A=',a:14:11,' ,B = ',b:14:11,', sigma = ',sigma:7:4);
  for i :=1 to 80 do write(fil2,'-');
 goto 20;

10: znachenye1;
 writeln('     ',x[i]:3:0,'    ',ym[i]:8:3,'    ',yr[i]:8:3 ,'   ',regul[i]:8:5,'         ',sluch[i]:8:5);
 writeln(fil2,'     ',x[i]:3:0,'    ',ym[i]:8:3,'    ',yr[i]:8:3 ,'   ',regul[i]:8:5,'         ',sluch[i]:8:5);
20: ch:=readkey;
i:=nmax+1;
x[i]:=x[i-1]+1;
 if x[i] > xmax then
  begin
  writeln('    конец расчета  ');
  writeln(fil2,'    конец расчета  ');
  ch:=readkey;
  halt;
 end;
znachenye1;
sdvig;
30: pogreshnost;
 if sigma > sigmao then
  begin
  kk:=kk+0.00001;
   for i :=1 to 80 do write('-');
   for i :=1 to 80 do write(fil2,'-');
   writeln('коэффициенты : A=',a:14:11,' ,B = ',b:14:11,', sigma = ',sigma:7:4);
   writeln(fil2,'коэффициенты : A=',a:14:11,' ,B = ',b:14:11,', sigma = ',sigma:7:4);
   writeln(' ...подправка... sigma = ',sigma:7:5,'   ',sigmao:7:5);
   writeln(fil2,' ...подправка... sigma = ',sigma:7:5,'   ',sigmao:7:5);
  koef;
  znachenye;
  goto 30;
  end
    else goto 10;
close(fil2);
end.
