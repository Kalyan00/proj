
type menu_type=record
     n:integer;
     s:array[1..10]of string;
     x1,y1,x2:integer;
     end;


function menu(a:menu_type):integer;
var i,j:integer;b:menu_type;exitt:boolean;c:char;
begin
textattr:=0;
clrscr;
textattr:=15*17;
b:=a;
with b do
begin
if(x1>=x2)then begin textattr:=15;write('error: x1>=x2');halt;end;
for i:=x1 to x2 do
for j:=y1 to y1+n+1 do
begin gotoxy(i,j); write(' ');end;
for i:=1 to n do
 if ord(s[i][0])>x2-x1-4 then
  s[i][0]:=chr(x2-x1-4);
j:=1;
exitt:=false;
while not exitt do
   begin
   for i:=1 to n do
     begin
     if i=j then textattr:=7*16 else textattr:=15*16;
     gotoxy(x1+2,y1+i);
     write(s[i]);
   end;
   c:=readkey;
   if c=#0 then
      begin
      c:=readkey;
      case c of
        #72:if j = 1 then j:=n else dec(j);
        #80:if j = n then j:=1 else inc(j);
      end;
   end else
      begin
      case c of
        #13:begin exitt:=true;menu:=j;  end;
        #27:begin exitt:=true;menu:=0;  end;
      end;
   end;
end;


end;
textattr:=15;
end;




procedure change_variable;
var a:menu_type;b:integer;ss:string;
begin
b:=1;
while b<>0 do
with a do
begin
n:=10;
x1:=15;y1:=5;x2:=x1+50;
s[1]:='изменить экспер. файл               '+  f_exp;
s[2]:='изменить резуль. файл               '+  f_rez;
 str (X_min:0:3,ss);
s[3]:='изменить X_min                      '+ss;
 str ( X_max:0:3,ss);
s[4]:='изменить  X_max                     '+ss;
 str ( dx:0:5,ss);
s[5]:='изменить dx                         '+ss;
 str ( N_max,ss);
s[6]:='кол-во точек для апроксимации       '+ss;
 str ( k:0:5,ss);
s[7]:='изменить мах случ. сост.            '+ss;
 str ( kz:0:1,ss);
s[8]:='изменить коэф. запаса               '+ss;
 str ( aproks,ss);
s[9]:='изменить степень апоксимации        '+ss;
s[10]:='ВЫХОД';
b:=menu(a);
textattr:=15*16;
gotoxy(10,22);
write('>');
case b of
  1:readln(f_exp);
  2:readln(f_rez);
  3:readln(X_min);
  4:readln(X_max);
  5:readln(dx);
  6:readln(N_max);
  7:readln(k);
  8:readln(kz);
  9:readln(aproks);
  10:b:=0;
end;
textattr:=15;
if X_min>X_max then begin write('ERROR: X_min>X_max');halt;end;
if N_max<1 then begin write('ERROR: N_max<1');halt;end;
if kz <=1 then begin write('ERROR: kz <=1 ');halt;end;
if (aproks<1)or(aproks>10) then begin write('ERROR: 1<=aproks<=10  ');halt;end;
end;
textattr:=7; clrscr;
end;






procedure menu1;
var a:menu_type;b:integer;
begin
b:=1;
while b<>0 do
with a do
begin
n:=4;
x1:=20;y1:=4;x2:=x1+40;
s[1]:='Установки';
s[2]:='Создать модель эксперимента';
s[3]:='Произвести обсчет файла  '+f_exp;
s[4]:='ВЫХОД';

b:=menu(a);
case b of
  1:change_variable;
  2:make_exp;
  3:obschet;
  4:b:=0;
end;
end;
textattr:=7; clrscr;
end;






begin
  f_exp:='data.exp';                       {}
  f_rez:='data.rez';                       {}
  dx:=0.01;                                {}
  X_min:=0;                                {}
  X_max:=1;                                {}
  N_max:=20;                               {}
  k:=0.0005;                               {}
  kz:=2.0;                                 {}
  aproks:=4;                               {}
menu1;
end.