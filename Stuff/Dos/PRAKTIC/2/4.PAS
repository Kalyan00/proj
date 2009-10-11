{$N+}
{$M 65000 0 655360}
program praktica;
uses Crt,graph,dos;
type
  masiv= array[1..1000] of extended;
var
  f_exp:string;                        { данные експеримента }
  f_rez:string;                        { результат работы программы }
  dx:extended;                         { x[i]-x[i-1] }
  X_min:extended;                      { нижняя граница измерений }
  X_max:extended;                      { верхняя граница измерений }
  N_max:integer;                       { кол-во точек для апроксимации }
  k:extended;                          { максимальная случайная составл.}
  kz:extended;                         { максимальная случайная составл.}
  f,f2:text;                           { файлы }
  ym,yr,x:masiv;                       { масивы для сумм для апроксимации }
  sigma,sigma0:extended;               { погрешность }
  aproks:integer;                      { степень апроксимации }
  koef:masiv;                          { коэф-нты апр. уравнения y=A+Bx+C*x*x}
  paint_:boolean;                      { сопровождать ли обсчет графикой ? }
  ymax,ymin:real;                      { рамки при рисовании графика }




{------------------------------------  (расчет определителя матрицы) --}
const Q=7;                                                  { макс.размерн.м.}
type                                                        {}
   vec=array[1..Q]of extended;                              { вектор-столбец }
   matr= record                                             { матрица }
     ii,jj:integer;                                         { размер. iixjj}
     a:array[1..Q] of vec;                                  { matr.a - матрца}
   end;                                                     {}
                                                            {}
                                                            {}
function determ(a:matr):extended;                           { определитель }
var x,i,j,f:integer; b:matr; det:extended;                  { переменные }
begin                                                       {}
  if (a.jj<>a.ii) or (a.jj<0)or (a.jj>Q) then               {если матрица не}
     begin writeln('couldn''t count a determinal ');halt(1);{квадратная - вых}
  end;                                                      {}
  if a.jj=1 then determ:=a.a[1,1] else                      {если а размрнтью}
    begin                                                   {1х1 =>(a)=a[1,1]}
    fillchar(b,sizeof(matr),#0);                            {обнуление b}
    det:=0;b.ii:=a.ii-1;b.jj:=a.jj-1;                       { начальные знач.}
    for x:=1 to a.ii do                                     {раскладываем м.}
       begin f:=1;                                          { по нижней стрке}
       for i:=1 to a.ii-1 do                                {определитель = }
         begin                                              {сумме миноров(b)}
         f:=1;                                              {умноженных на }
         for j:=1 to a.jj do                                {соотв. значение}
         if x<>j then                                       {}
           begin                                            {}
           b.a[i,f]:=a.a[i,j];                              {заполнене минора}
           inc(f);                                          {}
         end;                                               {}
       end;                                                 {}
    if (a.ii+x) mod 2=0 then                                {проверка знака}
    det:=det+a.a[a.ii,x]*determ(b) else                     {рекурсивнй вызов}
    det:=det-a.a[a.ii,x]*determ(b) ;                        {функ. determ(b)}
  end;                                                      {}
  determ:=det;                                              {возвращаем det}
end;                                                        {}
end;                                                        {}
                                                            {}
{------------------------------------------------------------}




{-------------------------------------------------------------------------}
procedure make_exp;                        { смоделировать данные експер. }
var f:text;                                { файл в который пишем експер. }
    x:extended;                                { х }
    y:extended;                                { у }

begin
 {$i-} assign(f,f_exp); rewrite(f);{$i+}   { открыть файл для записи данных }
 if ioresult<>0 then begin writeln('немогу создать файл',f_exp);halt(1) end;
 x:=X_min;
 while x<=X_max do
   begin

  {  y:=2*x+(2*random-1)*k;{}


  { y:=(3.5*x-20)+(2*random-1)*k;          { расчет эксперементальных данных }
   {общий вид: y = f(x) +/- k      например:}
   {y:=(0.3*x*x + 10*x - 10 + 3*sin(x/10) )   +  (2*random-1)*k; }
   y:=sin(x)+(2*random-1)*k;{}

   writeln(f,y:0:5);                       { запись эксперементальных данных }
   x:=x+dx;
 end;
 close(f);                                 { закрытие файла }

 gotoxy(34,22); textattr:=7*16;           { выводим сообщение }
 writeln(' ! ГОТОВО ! ');                  {  ' ! ГОТОВО ! ' }
 readkey;if keypressed then readkey;       { пауза }
end;


{-------------------------------------------------------------------------}
function f_apr(x:extended):extended;               { функция расчета Ym}
var x_,s:extended;i:integer;               {  Ym=A+Bx+Cx*x+Dx*x*x}
begin                                      { }
x_:=1;                                     { х_ пробегает: 1; x; x*x; x*x*x;.}
s:=0;                                      { ну тут вроде все понятно }
for i:=1 to aproks do                      { и тут вроде все понятно }
   begin                                   { и тут вроде все понятно }
   s:=s+koef[i]*x_;                        { и тут вроде все понятно }
   x_:=x_*x;                               { и тут вроде все понятно }
end;                                       { и тут вроде все понятно }
f_apr:=s;                                  { возвращаем ответ }
end;







{-------------------------------------------------------------------------}
procedure model;                           { oбсчет апроксимации и новых Уm}
var
   xx:extended;
   a,b:matr;                               { матрицы для метода Крамера }
   i,j:integer;                            { счетчики }
   Ex:array[0..100]of extended;
   Ey:vec;
   s,delta0:extended;
begin
fillchar(Ex,sizeof(Ex),#0);                { обнуление сложной переменной }
fillchar(Ey,sizeof(Ey),#0);                { обнуление сложной переменной }
a.ii:=aproks; a.jj:=aproks;                { размерность матрицы A }
for i:=1 to N_max do                       { цикл для обсчета сумм }
  begin                                    {  Ех, Ех_2, Ех_3...}
  xx:=1;                                   {  причем Ех[0]=N_MAX, }
  for j:=0 to 2*aproks do                  {  а Ех[3]=сумме кубов }
    begin Ex[j]:=Ex[j]+xx;xx:=xx*x[i];end; { хх посл.принимает знач.1;x;x*x}
  xx:=1;                                   { аналогично расписываем }
  for j:=1 to aproks do                    { Еу, Еух, Еу(х_2), Еу(х_3)...}
    begin Ey[j]:=Ey[j]+Yr[i]*xx;xx:=xx*x[i];end;
end;
for i:=1 to a.ii do                        { идет         | N    Ex   Ex_2 | }
for j:=1 to a.jj do                        {  заполнение  | Ex   Ex_2 Ex_3 | }
a.a[i,j]:=Ex[i+j-2];                       {  матрицы     | Ex_2 Ex_3 Ex_4 | }
delta0:=determ(a);                         { ищем главный определитель }
if delta0=0 then begin writeln('err0r: determ = 0 ');halt(1); end;
for i:=1 to aproks do                      { ищем второстепенные определители}
begin                                      {  для расч.коэф-нтов методм Крам.}
b:=a;                                      { b- новая матрица в которой }
b.a[i]:=Ey;                                {  заменили i-й столбец }
koef[i]:=determ(b)/delta0;
end;

for j:=1 to N_max do                       { перерасчитываем }
   ym[j]:=f_apr(x[j]);                     {  Ym[1]..Ym[2]....Ym[N_max] }

s:=0;                                      { расчет погрешности }
for i:=1 to N_max do                       {             ___________       }
  s:=s+sqr(ym[i]-yr[i]);                   { sigma=  _  /        2 |    /  }
sigma0:=sqrt(s)/N_max;                     {          \/ E(ym-yr)     /  N }

for i:=1 to 80 do write(f2,'-'); writeln(f2);    { вывод резултатов в файл }
write(f2,'  расчет коэф. модели ');                                       {}
for i:=1 to aproks do write(f2,chr(ord('A')+i-1),'=',koef[i]:0:2,'  ');   {}
writeln(f2);                                                              {}
writeln(f2,'sigma0 = ',sigma0:0:5,'  kz = ',kz:0:2);                      {}
for i:=1 to 80 do write(f2,'-'); writeln(f2);                             {}
writeln(f2,'  точка  мат.модель  реал.процесс  погрешность  sigma  ');    {}
for i:=1 to 80 do write(f2,'-'); writeln(f2);                             {}
for i:=1 to N_max do writeln(f2,x[i]:5:3,                                 {}
ym[i]:12:3,yr[i]:12:3,abs(ym[i]-yr[i]):12:3, '        ---  ');            {}
for i:=1 to 80 do write(f2,'-'); writeln(f2);    {-------------------------}

end;








{-------------------------------------------------------------------------}
procedure paint;                           { потроение графика }
var i:integer;                             {}
begin                                      {}
setcolor(15);                              { белый цвет }
for i:=1 to N_max do                       { рисуем точки }
  circle(220+trunc(200* (x[i]-X_min)/(X_max-X_min)),        {}
         340-trunc(200*(yr[i]-ymin)/(ymax-ymin)),1);        {}
for i:=20 to 620 do                        { рисуем кривую }
  putpixel(i,340-trunc(200*                {   красным цветом    }
     (f_apr((i-220)*(X_max-X_min)/200+X_min)-ymin)/(ymax-ymin)),4);


if readkey=#27 then                        { если нажат ESC прекратить }
begin paint_:=false;closegraph;end         {   рисовать и закрыть графику }
else begin                                 { иначе}
setcolor(8);                               { серый цвет }
for i:=1 to N_max do                       { рисуем точки }
  circle(220+trunc(200* (x[i]-X_min)/(X_max-X_min)),        {}
         340-trunc(200*(yr[i]-ymin)/(ymax-ymin)),1);        {}
for i:=20 to 620 do                        { стираем кривую  }
  putpixel(i,340-trunc(200*                {   черным цветом }
     (f_apr((i-220)*(X_max-X_min)/200+X_min)-ymin)/(ymax-ymin)),0);

end;                                       {}
if keypressed then                         { если нажата какая-то клавиша}
readkey;                                   {  -считать ее }
end;



{-------------------------------------------------------------------------}
procedure sdvig;                           { расчет новой точки }
var i:integer;                             { cчетчик }
    s:extended;                                { переменная для расч. погрешности}
begin
for i:=1 to N_max-1 do                     { сдвиг таблици значений }
  begin                                    {}
  x[i]:=x[i+1];                            {}
  ym[i]:=ym[i+1];                          {}
  yr[i]:=yr[i+1];                          {}
end;
x[N_max]:=x[N_max-1]+dx;                   { расчет последнего х }
readln(f,yr[N_max]);                       { чтение из файла последнего Yr }

ym[N_max]:=f_apr(x[N_max]);                { расчет последнего Ym }

s:=0;                                      { расчет погрешности для }
for i:=1 to N_max do                       {  N_max  последних  Ym и Yr}
  s:=s+sqr(ym[i]-yr[i]);                   {}
sigma:=sqrt(s)/N_max;                      {}
writeln(f2,x[i]:5:3,ym[N_max]:12:3         { вывод резултатов в файл }
    ,yr[N_max]:12:3,abs(ym[N_max]-yr[N_max]):12:3, sigma:12:3);
if paint_ then paint;                      { процедура рисования графика }
end;










{-------------------------------------------------------------------------}
procedure obschet;
var i,gd,gm:integer;
begin
 {$i-} assign(f,f_exp); reset(f);{$i+}     { откр. файл для cчит. данных эксп}
 if ioresult<>0 then begin writeln('немогу открыть файл',f_exp);halt(1) end;
 {$i-} assign(f2,f_rez); rewrite(f2);{$i+} { создать файл для записи результ.}
 if ioresult<>0 then begin writeln('немогу открыть файл',f_exp);halt(1) end;
for i:=1 to N_max do                       { загрузка из вайла певрых Yr}
   readln(f,yr[i]);                        {}
for i:=1 to N_max do x[i]:=X_min+dx*(i-1); { расчет первых х }
model;                                     { расчет первых ym и апроксимация }


paint_:=true;
gd:=detect;
InitGraph(gD, gM,'');
if graphresult<>grok then
begin
writeln(' графика отсутствует нема найти файл EGAVGA.BGI ');
paint_:=false;
end;

while x[N_max]<X_max do                    {| ГЛАВНАЯ ЧАСТЬ ПРОГРАММЫ }
begin                                      {| выполняется цикл }
sdvig;                                     {| где расчитываятся новые знач.}
if sigma>sigma0*kz then model;             {| и если погрешность велика пере-}
end;                                       {|  расчитывается апроксимация }

if paint_ then closegraph;                 { закрытие графики }
clrscr;
close(f);                                  { закрытие файла }
close(f2);                                 { закрытие файла }

gotoxy(34,22); textattr:=7*16;             { выводим сообщение }
writeln(' ! ГОТОВО ! ');                   {  ' ! ГОТОВО ! ' }
readkey;if keypressed then readkey;        { пауза }

end;








{-эта часть программы не об'ясняется   (MENU) --------------------------}
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
s[1]:='ВЫХОД';                                                         {}
s[2]:='изменить экспер. файл               '+  f_exp;                  {}
s[3]:='изменить резуль. файл               '+  f_rez;                  {}
 str (X_min:0:3,ss);                                                   {}
s[4]:='изменить X_min                      '+ss;                       {}
 str ( X_max:0:3,ss);                                                  {}
s[5]:='изменить X_max                      '+ss;                       {}
 str ( ymax:0:2,ss);                                                   {}
s[6]:='изменить ymax                       '+ss;                       {}
 str ( ymin:0:2,ss);                                                   {}
s[7]:='изменить ymin                       '+ss;                       {}
 str ( dx:0:5,ss);                                                     {}
s[8]:='изменить dx                         '+ss;                       {}
 str ( N_max,ss);                                                      {}
s[9]:='кол-во точек для апроксимации       '+ss;                       {}
 str ( k:0:5,ss);                                                      {}
s[10]:='изменить мах случ. сост.            '+ss;                      {}
 str ( kz:0:1,ss);                                                     {}
s[11]:='изменить коэф. запаса               '+ss;                      {}
 str ( aproks,ss);                                                     {}
s[12]:='изменить степень апоксимации        '+ss;                      {}
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
s[1]:='Установки';                                                     {}
s[2]:='Создать модель эксперимента';                                   {}
s[3]:='Произвести обсчет файла  '+f_exp;                               {}
s[4]:='ВЫХОД';                                                         {}
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
begin                                      { начальные значения }
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

  randomize;                               { поддержка случайных чисел }
  clrscr;                                  { очистить зкран }
  MENU1;                                    { вызов МЕНЮ }
end.


