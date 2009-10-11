program praktica;
uses Crt,matr_;
type
  masiv= array[1..1000] of real;
var
  f_exp:string;                        { данные експеримента }
  f_rez:string;                        { результат работы программы }
  dx:real;                             { x[i]-x[i-1] }
  X_min:real;                       { нижняя граница измерений }
  X_max:real;                       { верхняя граница измерений }
  N_max:integer;                       { кол-во точек для апроксимации }
  k:real;                              { максимальная случайная составл.}
  kz:real;                             { максимальная случайная составл.}
  f,f2:text;                           { файлы }
  ym,yr,x:masiv;                       { масивы для сумм для апроксимации }
  sigma,sigma0:real;                   { погрешность }
  aproks:integer;                      { степень апроксимации }
  koef:masiv;                          { коэф-нты апр. уравнения y=A+Bx+C*x*x}



{-------------------------------------------------------------------------}
procedure make_exp;                        { смоделировать данные експер. }
var f:text;                                { файл в который пишем експер. }
    x:real;                                { х }
    y:real;                                { у }

begin
 {$i-} assign(f,f_exp); rewrite(f);{$i+}   { открыть файл для записи данных }
 if ioresult<>0 then begin writeln('немогу создать файл',f_exp);halt(1) end;
 x:=X_min;
 while x<=X_max do
   begin

    y:=2*x+(2*random-1)*k;
  { y:=(3.5*x-20)+(2*random-1)*k;          { расчет эксперементальных данных }
   {общий вид: y = f(x) +/- k      например:}
   {y:=(0.3*x*x + 10*x - 10 + 3*sin(x/10) )   +  (2*random-1)*k; }
  { y:=5*sin(x/2)+(2*random-1)*k;}

   writeln(f,y:0:5);                       { запись эксперементальных данных }
   x:=x+dx;
 end;
 close(f);                                 { закрытие файла }
end;


{-------------------------------------------------------------------------}
function f_apr(x:real):real;                       { функция расчета Ym}
var x_,s:real;i:integer;                   {  Ym=A+Bx+Cx*x+Dx*x*x}
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
procedure model;                           { абсчет апроксимации и новых Уm}
var
   xx:real;
   a,b:matr;                               { матрицы для метода Крамера }
   i,j:integer;                            { счетчики }
   Ex:array[0..100]of real;
   Ey:vec;
   s,delta0:real;
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
write(f2,'  расчет коэф. модели ');
for i:=1 to aproks do write(f2,chr(ord('A')+i-1),'=',koef[i]:0:2,'  ');
writeln(f2);
writeln(f2,'sigma0 = ',sigma0:0:5,'  kz = ',kz:0:2);
for i:=1 to 80 do write(f2,'-'); writeln(f2);
writeln(f2,'  точка  мат.модель  реал.процесс  погрешность  sigma  ');
for i:=1 to 80 do write(f2,'-'); writeln(f2);
for i:=1 to N_max do writeln(f2,x[i]:5:3,
ym[i]:12:3,yr[i]:12:3,abs(ym[i]-yr[i]):12:3, '        ---  ');
for i:=1 to 80 do write(f2,'-'); writeln(f2);

end;







{-------------------------------------------------------------------------}
procedure sdvig;                           { расчет новой точки }
var i:integer;                             { cчетчик }
    s:real;                                { переменная для расч. погрешности}
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
end;










{-------------------------------------------------------------------------}
procedure obschet;
var i:integer;
begin
 {$i-} assign(f,f_exp); reset(f);{$i+}     { откр. файл для cчит. данных эксп}
 if ioresult<>0 then begin writeln('немогу открыть файл',f_exp);halt(1) end;
 {$i-} assign(f2,f_rez); rewrite(f2);{$i+} { создать файл для записи результ.}
 if ioresult<>0 then begin writeln('немогу открыть файл',f_exp);halt(1) end;
for i:=1 to N_max do                       { загрузка из вайла певрых Yr}
   readln(f,yr[i]);                        {}
for i:=1 to N_max do x[i]:=X_min+dx*(i-1); { расчет первых х }
model;                                     { расчет первых ym и апроксимация }


while x[N_max]<X_max do                    {| ГЛАВНАЯ ЧАСТЬ ПРОГРАММЫ }
begin                                      {| выполняется цикл }
sdvig;                                     {| где расчитываятся новые знач.}
if sigma>sigma0*kz then model;             {| и если погрешность велика пере-}
end;                                       {|  расчитывается апроксимация }


close(f);                                  { закрытие файла }
close(f2);                                 { закрытие файла }

end;

{-------------------------------------------------------------------------}
procedure menu;
begin

end;


{-------------------------------------------------------------------------}
begin                                      { начальные значения }
  f_exp:='data.exp';                       {}
  f_rez:='data.rez';                       {}
  dx:=0.01;                                {}
  X_min:=0;                                {}
  X_max:=1;                                {}
  N_max:=20;                               {}
  k:=0.0005;                               {}
  kz:=2.0;                                 {}
  aproks:=4;                               {}

  randomize;                               { поддержка случайных чисел }
  clrscr;                                  { очистить зкран }
  MENU;                                    { вызов МЕНЮ }
end.


