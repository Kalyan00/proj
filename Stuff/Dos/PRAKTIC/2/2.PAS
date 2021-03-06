program praktica;
uses Crt,matr_;
type
  masiv= array[1..1000] of real;
var
  f_exp:string;                        { ����� ��ᯥਬ��� }
  f_rez:string;                        { १���� ࠡ��� �ணࠬ�� }
  dx:real;                             { x[i]-x[i-1] }
  X_min:real;                       { ������ �࠭�� ����७�� }
  X_max:real;                       { ������ �࠭�� ����७�� }
  N_max:integer;                       { ���-�� �祪 ��� ��பᨬ�樨 }
  k:real;                              { ���ᨬ��쭠� ��砩��� ��⠢�.}
  kz:real;                             { ���ᨬ��쭠� ��砩��� ��⠢�.}
  f,f2:text;                           { 䠩�� }
  ym,yr,x:masiv;                       { ��ᨢ� ��� �㬬 ��� ��பᨬ�樨 }
  sigma,sigma0:real;                   { ����譮��� }
  aproks:integer;                      { �⥯��� ��பᨬ�樨 }
  koef:masiv;                          { ����-��� ���. �ࠢ����� y=A+Bx+C*x*x}



{-------------------------------------------------------------------------}
procedure make_exp;                        { ᬮ����஢��� ����� ��ᯥ�. }
var f:text;                                { 䠩� � ����� ��襬 ��ᯥ�. }
    x:real;                                { � }
    y:real;                                { � }

begin
 {$i-} assign(f,f_exp); rewrite(f);{$i+}   { ������ 䠩� ��� ����� ������ }
 if ioresult<>0 then begin writeln('������ ᮧ���� 䠩�',f_exp);halt(1) end;
 x:=X_min;
 while x<=X_max do
   begin

    y:=2*x+(2*random-1)*k;
  { y:=(3.5*x-20)+(2*random-1)*k;          { ���� ��ᯥ६��⠫��� ������ }
   {��騩 ���: y = f(x) +/- k      ���ਬ��:}
   {y:=(0.3*x*x + 10*x - 10 + 3*sin(x/10) )   +  (2*random-1)*k; }
  { y:=5*sin(x/2)+(2*random-1)*k;}

   writeln(f,y:0:5);                       { ������ ��ᯥ६��⠫��� ������ }
   x:=x+dx;
 end;
 close(f);                                 { �����⨥ 䠩�� }
end;


{-------------------------------------------------------------------------}
function f_apr(x:real):real;                       { �㭪�� ���� Ym}
var x_,s:real;i:integer;                   {  Ym=A+Bx+Cx*x+Dx*x*x}
begin                                      { }
x_:=1;                                     { �_ �஡�����: 1; x; x*x; x*x*x;.}
s:=0;                                      { �� ��� �த� �� ����⭮ }
for i:=1 to aproks do                      { � ��� �த� �� ����⭮ }
   begin                                   { � ��� �த� �� ����⭮ }
   s:=s+koef[i]*x_;                        { � ��� �த� �� ����⭮ }
   x_:=x_*x;                               { � ��� �த� �� ����⭮ }
end;                                       { � ��� �த� �� ����⭮ }
f_apr:=s;                                  { �����頥� �⢥� }
end;







{-------------------------------------------------------------------------}
procedure model;                           { ����� ��பᨬ�樨 � ����� �m}
var
   xx:real;
   a,b:matr;                               { ������ ��� ��⮤� �ࠬ�� }
   i,j:integer;                            { ���稪� }
   Ex:array[0..100]of real;
   Ey:vec;
   s,delta0:real;
begin
fillchar(Ex,sizeof(Ex),#0);                { ���㫥��� ᫮���� ��६����� }
fillchar(Ey,sizeof(Ey),#0);                { ���㫥��� ᫮���� ��६����� }
a.ii:=aproks; a.jj:=aproks;                { ࠧ��୮��� ������ A }
for i:=1 to N_max do                       { 横� ��� ����� �㬬 }
  begin                                    {  ��, ��_2, ��_3...}
  xx:=1;                                   {  ��祬 ��[0]=N_MAX, }
  for j:=0 to 2*aproks do                  {  � ��[3]=�㬬� �㡮� }
    begin Ex[j]:=Ex[j]+xx;xx:=xx*x[i];end; { �� ���.�ਭ����� ����.1;x;x*x}
  xx:=1;                                   { �������筮 �ᯨ�뢠�� }
  for j:=1 to aproks do                    { ��, ���, ��(�_2), ��(�_3)...}
    begin Ey[j]:=Ey[j]+Yr[i]*xx;xx:=xx*x[i];end;
end;
for i:=1 to a.ii do                        { ����         | N    Ex   Ex_2 | }
for j:=1 to a.jj do                        {  ����������  | Ex   Ex_2 Ex_3 | }
a.a[i,j]:=Ex[i+j-2];                       {  ������     | Ex_2 Ex_3 Ex_4 | }
delta0:=determ(a);                         { �饬 ������ ��।���⥫� }
if delta0=0 then begin writeln('err0r: determ = 0 ');halt(1); end;
for i:=1 to aproks do                      { �饬 ����⥯���� ��।���⥫�}
begin                                      {  ��� ���.����-�⮢ ��⮤� �ࠬ.}
b:=a;                                      { b- ����� ����� � ���ன }
b.a[i]:=Ey;                                {  �������� i-� �⮫��� }
koef[i]:=determ(b)/delta0;
end;

for j:=1 to N_max do                       { �������뢠�� }
   ym[j]:=f_apr(x[j]);                     {  Ym[1]..Ym[2]....Ym[N_max] }

s:=0;                                      { ���� ����譮�� }
for i:=1 to N_max do                       {             ___________       }
  s:=s+sqr(ym[i]-yr[i]);                   { sigma=  _  /        2 |    /  }
sigma0:=sqrt(s)/N_max;                     {          \/ E(ym-yr)     /  N }

for i:=1 to 80 do write(f2,'-'); writeln(f2);    { �뢮� १��⮢ � 䠩� }
write(f2,'  ���� ����. ������ ');
for i:=1 to aproks do write(f2,chr(ord('A')+i-1),'=',koef[i]:0:2,'  ');
writeln(f2);
writeln(f2,'sigma0 = ',sigma0:0:5,'  kz = ',kz:0:2);
for i:=1 to 80 do write(f2,'-'); writeln(f2);
writeln(f2,'  �窠  ���.������  ॠ�.�����  ����譮���  sigma  ');
for i:=1 to 80 do write(f2,'-'); writeln(f2);
for i:=1 to N_max do writeln(f2,x[i]:5:3,
ym[i]:12:3,yr[i]:12:3,abs(ym[i]-yr[i]):12:3, '        ---  ');
for i:=1 to 80 do write(f2,'-'); writeln(f2);

end;







{-------------------------------------------------------------------------}
procedure sdvig;                           { ���� ����� �窨 }
var i:integer;                             { c��稪 }
    s:real;                                { ��६����� ��� ���. ����譮��}
begin
for i:=1 to N_max-1 do                     { ᤢ�� ⠡��� ���祭�� }
  begin                                    {}
  x[i]:=x[i+1];                            {}
  ym[i]:=ym[i+1];                          {}
  yr[i]:=yr[i+1];                          {}
end;
x[N_max]:=x[N_max-1]+dx;                   { ���� ��᫥����� � }
readln(f,yr[N_max]);                       { �⥭�� �� 䠩�� ��᫥����� Yr }

ym[N_max]:=f_apr(x[N_max]);                { ���� ��᫥����� Ym }

s:=0;                                      { ���� ����譮�� ��� }
for i:=1 to N_max do                       {  N_max  ��᫥����  Ym � Yr}
  s:=s+sqr(ym[i]-yr[i]);                   {}
sigma:=sqrt(s)/N_max;                      {}
writeln(f2,x[i]:5:3,ym[N_max]:12:3         { �뢮� १��⮢ � 䠩� }
    ,yr[N_max]:12:3,abs(ym[N_max]-yr[N_max]):12:3, sigma:12:3);
end;










{-------------------------------------------------------------------------}
procedure obschet;
var i:integer;
begin
 {$i-} assign(f,f_exp); reset(f);{$i+}     { ���. 䠩� ��� c��. ������ ���}
 if ioresult<>0 then begin writeln('������ ������ 䠩�',f_exp);halt(1) end;
 {$i-} assign(f2,f_rez); rewrite(f2);{$i+} { ᮧ���� 䠩� ��� ����� १���.}
 if ioresult<>0 then begin writeln('������ ������ 䠩�',f_exp);halt(1) end;
for i:=1 to N_max do                       { ����㧪� �� ����� ������ Yr}
   readln(f,yr[i]);                        {}
for i:=1 to N_max do x[i]:=X_min+dx*(i-1); { ���� ����� � }
model;                                     { ���� ����� ym � ��பᨬ��� }


while x[N_max]<X_max do                    {| ������� ����� ��������� }
begin                                      {| �믮������ 横� }
sdvig;                                     {| ��� ����뢠���� ���� ����.}
if sigma>sigma0*kz then model;             {| � �᫨ ����譮��� ������ ���-}
end;                                       {|  ����뢠���� ��பᨬ��� }


close(f);                                  { �����⨥ 䠩�� }
close(f2);                                 { �����⨥ 䠩�� }

end;

{-------------------------------------------------------------------------}
procedure menu;
begin

end;


{-------------------------------------------------------------------------}
begin                                      { ��砫�� ���祭�� }
  f_exp:='data.exp';                       {}
  f_rez:='data.rez';                       {}
  dx:=0.01;                                {}
  X_min:=0;                                {}
  X_max:=1;                                {}
  N_max:=20;                               {}
  k:=0.0005;                               {}
  kz:=2.0;                                 {}
  aproks:=4;                               {}

  randomize;                               { �����প� ��砩��� �ᥫ }
  clrscr;                                  { ������ ��࠭ }
  MENU;                                    { �맮� ���� }
end.


