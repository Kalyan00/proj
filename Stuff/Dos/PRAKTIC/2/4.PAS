{$N+}
{$M 65000 0 655360}
program praktica;
uses Crt,graph,dos;
type
  masiv= array[1..1000] of extended;
var
  f_exp:string;                        { ����� ��ᯥਬ��� }
  f_rez:string;                        { १���� ࠡ��� �ணࠬ�� }
  dx:extended;                         { x[i]-x[i-1] }
  X_min:extended;                      { ������ �࠭�� ����७�� }
  X_max:extended;                      { ������ �࠭�� ����७�� }
  N_max:integer;                       { ���-�� �祪 ��� ��பᨬ�樨 }
  k:extended;                          { ���ᨬ��쭠� ��砩��� ��⠢�.}
  kz:extended;                         { ���ᨬ��쭠� ��砩��� ��⠢�.}
  f,f2:text;                           { 䠩�� }
  ym,yr,x:masiv;                       { ��ᨢ� ��� �㬬 ��� ��பᨬ�樨 }
  sigma,sigma0:extended;               { ����譮��� }
  aproks:integer;                      { �⥯��� ��பᨬ�樨 }
  koef:masiv;                          { ����-��� ���. �ࠢ����� y=A+Bx+C*x*x}
  paint_:boolean;                      { ᮯ஢������ �� ����� ��䨪�� ? }
  ymax,ymin:real;                      { ࠬ�� �� �ᮢ���� ��䨪� }




{------------------------------------  (���� ��।���⥫� ������) --}
const Q=7;                                                  { ����.ࠧ���.�.}
type                                                        {}
   vec=array[1..Q]of extended;                              { �����-�⮫��� }
   matr= record                                             { ����� }
     ii,jj:integer;                                         { ࠧ���. iixjj}
     a:array[1..Q] of vec;                                  { matr.a - �����}
   end;                                                     {}
                                                            {}
                                                            {}
function determ(a:matr):extended;                           { ��।���⥫� }
var x,i,j,f:integer; b:matr; det:extended;                  { ��६���� }
begin                                                       {}
  if (a.jj<>a.ii) or (a.jj<0)or (a.jj>Q) then               {�᫨ ����� ��}
     begin writeln('couldn''t count a determinal ');halt(1);{�����⭠� - ���}
  end;                                                      {}
  if a.jj=1 then determ:=a.a[1,1] else                      {�᫨ � ࠧ�����}
    begin                                                   {1�1 =>(a)=a[1,1]}
    fillchar(b,sizeof(matr),#0);                            {���㫥��� b}
    det:=0;b.ii:=a.ii-1;b.jj:=a.jj-1;                       { ��砫�� ����.}
    for x:=1 to a.ii do                                     {�᪫��뢠�� �.}
       begin f:=1;                                          { �� ������ ��થ}
       for i:=1 to a.ii-1 do                                {��।���⥫� = }
         begin                                              {�㬬� ����஢(b)}
         f:=1;                                              {㬭������� �� }
         for j:=1 to a.jj do                                {ᮮ�. ���祭��}
         if x<>j then                                       {}
           begin                                            {}
           b.a[i,f]:=a.a[i,j];                              {��������� �����}
           inc(f);                                          {}
         end;                                               {}
       end;                                                 {}
    if (a.ii+x) mod 2=0 then                                {�஢�ઠ �����}
    det:=det+a.a[a.ii,x]*determ(b) else                     {४��ᨢ�� �맮�}
    det:=det-a.a[a.ii,x]*determ(b) ;                        {�㭪. determ(b)}
  end;                                                      {}
  determ:=det;                                              {�����頥� det}
end;                                                        {}
end;                                                        {}
                                                            {}
{------------------------------------------------------------}




{-------------------------------------------------------------------------}
procedure make_exp;                        { ᬮ����஢��� ����� ��ᯥ�. }
var f:text;                                { 䠩� � ����� ��襬 ��ᯥ�. }
    x:extended;                                { � }
    y:extended;                                { � }

begin
 {$i-} assign(f,f_exp); rewrite(f);{$i+}   { ������ 䠩� ��� ����� ������ }
 if ioresult<>0 then begin writeln('������ ᮧ���� 䠩�',f_exp);halt(1) end;
 x:=X_min;
 while x<=X_max do
   begin

  {  y:=2*x+(2*random-1)*k;{}


  { y:=(3.5*x-20)+(2*random-1)*k;          { ���� ��ᯥ६��⠫��� ������ }
   {��騩 ���: y = f(x) +/- k      ���ਬ��:}
   {y:=(0.3*x*x + 10*x - 10 + 3*sin(x/10) )   +  (2*random-1)*k; }
   y:=sin(x)+(2*random-1)*k;{}

   writeln(f,y:0:5);                       { ������ ��ᯥ६��⠫��� ������ }
   x:=x+dx;
 end;
 close(f);                                 { �����⨥ 䠩�� }

 gotoxy(34,22); textattr:=7*16;           { �뢮��� ᮮ�饭�� }
 writeln(' ! ������ ! ');                  {  ' ! ������ ! ' }
 readkey;if keypressed then readkey;       { ��㧠 }
end;


{-------------------------------------------------------------------------}
function f_apr(x:extended):extended;               { �㭪�� ���� Ym}
var x_,s:extended;i:integer;               {  Ym=A+Bx+Cx*x+Dx*x*x}
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
procedure model;                           { o���� ��பᨬ�樨 � ����� �m}
var
   xx:extended;
   a,b:matr;                               { ������ ��� ��⮤� �ࠬ�� }
   i,j:integer;                            { ���稪� }
   Ex:array[0..100]of extended;
   Ey:vec;
   s,delta0:extended;
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
write(f2,'  ���� ����. ������ ');                                       {}
for i:=1 to aproks do write(f2,chr(ord('A')+i-1),'=',koef[i]:0:2,'  ');   {}
writeln(f2);                                                              {}
writeln(f2,'sigma0 = ',sigma0:0:5,'  kz = ',kz:0:2);                      {}
for i:=1 to 80 do write(f2,'-'); writeln(f2);                             {}
writeln(f2,'  �窠  ���.������  ॠ�.�����  ����譮���  sigma  ');    {}
for i:=1 to 80 do write(f2,'-'); writeln(f2);                             {}
for i:=1 to N_max do writeln(f2,x[i]:5:3,                                 {}
ym[i]:12:3,yr[i]:12:3,abs(ym[i]-yr[i]):12:3, '        ---  ');            {}
for i:=1 to 80 do write(f2,'-'); writeln(f2);    {-------------------------}

end;








{-------------------------------------------------------------------------}
procedure paint;                           { ���஥��� ��䨪� }
var i:integer;                             {}
begin                                      {}
setcolor(15);                              { ���� 梥� }
for i:=1 to N_max do                       { ��㥬 �窨 }
  circle(220+trunc(200* (x[i]-X_min)/(X_max-X_min)),        {}
         340-trunc(200*(yr[i]-ymin)/(ymax-ymin)),1);        {}
for i:=20 to 620 do                        { ��㥬 �ਢ�� }
  putpixel(i,340-trunc(200*                {   ���� 梥⮬    }
     (f_apr((i-220)*(X_max-X_min)/200+X_min)-ymin)/(ymax-ymin)),4);


if readkey=#27 then                        { �᫨ ����� ESC �४���� }
begin paint_:=false;closegraph;end         {   �ᮢ��� � ������� ��䨪� }
else begin                                 { ����}
setcolor(8);                               { ��� 梥� }
for i:=1 to N_max do                       { ��㥬 �窨 }
  circle(220+trunc(200* (x[i]-X_min)/(X_max-X_min)),        {}
         340-trunc(200*(yr[i]-ymin)/(ymax-ymin)),1);        {}
for i:=20 to 620 do                        { ��ࠥ� �ਢ��  }
  putpixel(i,340-trunc(200*                {   ��� 梥⮬ }
     (f_apr((i-220)*(X_max-X_min)/200+X_min)-ymin)/(ymax-ymin)),0);

end;                                       {}
if keypressed then                         { �᫨ ����� �����-� ������}
readkey;                                   {  -����� �� }
end;



{-------------------------------------------------------------------------}
procedure sdvig;                           { ���� ����� �窨 }
var i:integer;                             { c��稪 }
    s:extended;                                { ��६����� ��� ���. ����譮��}
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
if paint_ then paint;                      { ��楤�� �ᮢ���� ��䨪� }
end;










{-------------------------------------------------------------------------}
procedure obschet;
var i,gd,gm:integer;
begin
 {$i-} assign(f,f_exp); reset(f);{$i+}     { ���. 䠩� ��� c��. ������ ���}
 if ioresult<>0 then begin writeln('������ ������ 䠩�',f_exp);halt(1) end;
 {$i-} assign(f2,f_rez); rewrite(f2);{$i+} { ᮧ���� 䠩� ��� ����� १���.}
 if ioresult<>0 then begin writeln('������ ������ 䠩�',f_exp);halt(1) end;
for i:=1 to N_max do                       { ����㧪� �� ����� ������ Yr}
   readln(f,yr[i]);                        {}
for i:=1 to N_max do x[i]:=X_min+dx*(i-1); { ���� ����� � }
model;                                     { ���� ����� ym � ��பᨬ��� }


paint_:=true;
gd:=detect;
InitGraph(gD, gM,'');
if graphresult<>grok then
begin
writeln(' ��䨪� ��������� ���� ���� 䠩� EGAVGA.BGI ');
paint_:=false;
end;

while x[N_max]<X_max do                    {| ������� ����� ��������� }
begin                                      {| �믮������ 横� }
sdvig;                                     {| ��� ����뢠���� ���� ����.}
if sigma>sigma0*kz then model;             {| � �᫨ ����譮��� ������ ���-}
end;                                       {|  ����뢠���� ��பᨬ��� }

if paint_ then closegraph;                 { �����⨥ ��䨪� }
clrscr;
close(f);                                  { �����⨥ 䠩�� }
close(f2);                                 { �����⨥ 䠩�� }

gotoxy(34,22); textattr:=7*16;             { �뢮��� ᮮ�饭�� }
writeln(' ! ������ ! ');                   {  ' ! ������ ! ' }
readkey;if keypressed then readkey;        { ��㧠 }

end;








{-�� ���� �ணࠬ�� �� ��'������   (MENU) --------------------------}
type menu_type=record                                                  {}
     n:integer;                                                        {}
     s:array[1..30]of string;                                          {}
     x1,y1,x2:integer;                                                 {}
     end;                                                              {}
type qwers=array[0..43]of byte;                                        {}
var qwer:qwers absolute $B800:$0100;                                   {}
                                                                       {}
const rewq:qwers=(                                                     {}
 $4D, $04,$61, $04,$64, $04,$65, $04,$20,$04,                          {}
 $62, $04,$79, $04,$20, $04,$4E, $04,$69,$04,                          {}
 $63, $04,$6B, $04,$20, $04,$4E, $04,$61,$04,                          {}
 $76, $04,$69, $04,$67, $04,$61, $04,$74,$04,                          {}
 $6F, $04,$72, $04);                                                   {}
                                                                       {}
                                                                       {}
                                                                       {}
                                                                       {}
                                                                       {}
function menu(a:menu_type):integer;                                    {}
var i,j:integer;b:menu_type;exitt:boolean;c:char;                      {}
begin                                                                  {}
textattr:=0;                                                           {}
clrscr;                                                                {}
textattr:=7*17;                                                        {}
b:=a;                                                                  {}
qwer:=rewq;                                                            {}
with b do                                                              {}
begin                                                                  {}
if(x1>=x2)then begin textattr:=15;write('error: x1>=x2');halt;end;     {}
for i:=x1 to x2 do                                                     {}
for j:=y1 to y1+n+1 do                                                 {}
begin gotoxy(i,j); write(' ');end;                                     {}
for i:=1 to n do                                                       {}
 if ord(s[i][0])>x2-x1-4 then                                          {}
  s[i][0]:=chr(x2-x1-4);                                               {}
j:=1;                                                                  {}
exitt:=false;                                                          {}
while not exitt do                                                     {}
   begin                                                               {}
   for i:=1 to n do                                                    {}
     begin                                                             {}
     if i=j then textattr:=7*16+15 else textattr:=7*16;                {}
     gotoxy(x1+2,y1+i);                                                {}
     write(s[i]);                                                      {}
   end;                                                                {}
   c:=readkey;                                                         {}
   if c=#0 then                                                        {}
      begin                                                            {}
      c:=readkey;                                                      {}
      case c of                                                        {}
        #72:if j = 1 then j:=n else dec(j);                            {}
        #80:if j = n then j:=1 else inc(j);                            {}
      end;                                                             {}
   end else                                                            {}
      begin                                                            {}
      case c of                                                        {}
        #13:begin exitt:=true;menu:=j;  end;                           {}
        #27:begin exitt:=true;menu:=0;  end;                           {}
      end;                                                             {}
   end;                                                                {}
end;                                                                   {}
                                                                       {}
                                                                       {}
end;                                                                   {}
textattr:=15;                                                          {}
end;                                                                   {}
                                                                       {}
                                                                       {}
                                                                       {}
                                                                       {}
procedure change_variable;                                             {}
var a:menu_type;b:integer;ss:string;                                   {}
begin                                                                  {}
b:=1;                                                                  {}
while b<>0 do                                                          {}
with a do                                                              {}
begin                                                                  {}
n:=12;                                                                 {}
x1:=15;y1:=5;x2:=x1+50;                                                {}
s[1]:='�����';                                                         {}
s[2]:='�������� ��ᯥ�. 䠩�               '+  f_exp;                  {}
s[3]:='�������� १��. 䠩�               '+  f_rez;                  {}
 str (X_min:0:3,ss);                                                   {}
s[4]:='�������� X_min                      '+ss;                       {}
 str ( X_max:0:3,ss);                                                  {}
s[5]:='�������� X_max                      '+ss;                       {}
 str ( ymax:0:2,ss);                                                   {}
s[6]:='�������� ymax                       '+ss;                       {}
 str ( ymin:0:2,ss);                                                   {}
s[7]:='�������� ymin                       '+ss;                       {}
 str ( dx:0:5,ss);                                                     {}
s[8]:='�������� dx                         '+ss;                       {}
 str ( N_max,ss);                                                      {}
s[9]:='���-�� �祪 ��� ��பᨬ�樨       '+ss;                       {}
 str ( k:0:5,ss);                                                      {}
s[10]:='�������� ��� ���. ���.            '+ss;                      {}
 str ( kz:0:1,ss);                                                     {}
s[11]:='�������� ����. �����               '+ss;                      {}
 str ( aproks,ss);                                                     {}
s[12]:='�������� �⥯��� ����ᨬ�樨        '+ss;                      {}
b:=menu(a);                                                            {}
textattr:=7*16;                                                        {}
gotoxy(10,22);                                                         {}
write('>');                                                            {}
case b of                                                              {}
  1:b:=0;                                                              {}
  2:readln(f_exp);                                                     {}
  3:readln(f_rez);                                                     {}
  4:readln(X_min);                                                     {}
  5:readln(X_max);                                                     {}
  6:readln(ymax);                                                      {}
  7:readln(ymin);                                                      {}
  8:readln(dx);                                                        {}
  9:readln(N_max);                                                     {}
  10:readln(k);                                                        {}
  11:readln(kz);                                                       {}
  12:readln(aproks);                                                   {}
end;                                                                   {}
textattr:=15;                                                          {}
if X_min>X_max then begin write('ERROR: X_min>X_max');halt;end;        {}
if dx<=0 then begin write('ERROR: dx<=0');halt;end;                    {}
if N_max<1 then begin write('ERROR: N_max<1');halt;end;                {}
if kz <=1 then begin write('ERROR: kz <=1 ');halt;end;                 {}
if (aproks<1)or(aproks>7) then                                         {}
begin write('ERROR: 1<=aproks<=7   ');halt;end;                        {}
end;                                                                   {}
textattr:=7; clrscr;                                                   {}
end;                                                                   {}
                                                                       {}
                                                                       {}
                                                                       {}
procedure menu1;                                                       {}
var a:menu_type;b:integer;                                             {}
begin                                                                  {}
b:=1;                                                                  {}
while b<>0 do                                                          {}
with a do                                                              {}
begin                                                                  {}
n:=4;                                                                  {}
x1:=20;y1:=4;x2:=x1+40;                                                {}
s[1]:='��⠭����';                                                     {}
s[2]:='������� ������ ��ᯥਬ���';                                   {}
s[3]:='�ந����� ����� 䠩��  '+f_exp;                               {}
s[4]:='�����';                                                         {}
                                                                       {}
b:=menu(a);                                                            {}
case b of                                                              {}
  1:change_variable;                                                   {}
  2:make_exp;                                                          {}
  3:obschet;                                                           {}
  4:b:=0;                                                              {}
end;                                                                   {}
end;                                                                   {}
textattr:=7; clrscr;                                                   {}
qwer:=rewq;                                                            {}
end;                                                                   {}
{-----------------------------------------------------------------------}




{-----------------------------------------------------------------------}
begin                                      { ��砫�� ���祭�� }
  f_exp:='data.exp';                       {}
  f_rez:='data.rez';                       {}
  dx:=0.01;                                {}
  X_min:=-2;                               {}
  X_max:=2;                                {}
  N_max:=50;                               {}
  k:=0.005;                                {}
  kz:=4.0;                                 {}
  aproks:=4;                               {}
  ymax:=1;                                 {}
  ymin:=-1;                                {}

  randomize;                               { �����প� ��砩��� �ᥫ }
  clrscr;                                  { ������ ��࠭ }
  MENU1;                                    { �맮� ���� }
end.


