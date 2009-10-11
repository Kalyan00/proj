uses crt,navigatr;

type x=1..78;
     y=1..15;
const hodmax = 50;

var
   delta:array[y] of x;
   koord1:array[y] of x;
   kol_kletok:x;
   kol_dor:y;
   pl_1_comp:boolean;
   pl_2_comp:boolean;
   pl_1_first:boolean;
   a:char;
   i:integer;
   maxhod:byte;
   dor,hod:byte;


procedure comp(play_1:boolean);
var P:array[0..hodmax]of byte;
    i:byte;
begin
  for i:=0 to HODMAX do P[i]:=0;           {чистка Р} {заполнение Р}
  for i:=1 to KOL_DOR  do
  inc( P [delta[i]mod(maxHOD+1)] );               {||||?||||}




end;
(*
procedure HOD_II;                          {ИСКУВСТВ ИНТЕЛ}
var i,j,k:byte;P:array[0..HODMAX] of byte;
begin
  for i:=0 to HODMAX do P[i]:=0;           {чистка Р} {заполнение Р}
  for i:=0 to KOL_DOR -1 do inc( P[(player_f2[i]-player_f1[i]-1)mod(HOD+1)] );
  i:=0;
  if((kol_dor-p[0])mod 2=1)then          { не закрытых дорожек нечетное?}
  begin
    K:=1;                                   {ДА}
    WHILE(P[k]mod 2=0)do k:=k+1;
    if(k<=hod) then
    while(player_f2[i]-player_f1[i]-1)mod(hod+1)<>k do inc(i)
    else while(player_f2[i]-player_f1[i]-1)mod(hod+1)=0 do inc(i);
    if(i<=KOL_DOR)then
      HOD_II2(i,(player_f2[i]-player_f1[i]-1)mod(hod+1))
    else
    begin
      i:=0;
      while(player_f2[i]=KOL_KL-1)do inc(i);
      if(i<kol_dor) then
        HOD_II2(i,-1)
      else  II_PROIGR;
    end;
  end
  else
  begin
    i:=1;
    while(p[i]mod 2=0)do inc(i);
    if(i<=hod)then
    begin
      j:=i+1;
      while(p[j]mod 2=0)do
      inc(j);
      if(j<=hod)then
      begin
        k:=0;
        while(player_f2[k]-player_f1[k]-1)mod(hod+1)<>j do inc(k);
        HOD_II2(k,j-i);
      end else write(chr(7),chr(7),chr(7),chr(7));
    end
    else
    begin
      i:=0;
      while(player_f2[i]-player_f1[i]-1)mod(hod+1)=0do inc(i);
      if(i<KOL_dor)then HOD_II2(i,1) else
      begin
        i:=0;
        while(player_f2[i]-player_f1[i]-1)=0do inc(i);
        if(i<KOL_dor)then HOD_II2(i,1) else
        begin
          i:=0;
          while(player_f2[i]=KOL_KL-1)do inc(i);
          if(i<kol_dor) then
            HOD_II2(i,-1)
          else  II_PROIGR;
        end;
      end;
    end;
  end;
end;


*)


procedure play(play_1:boolean);
var i:byte;
begin
if play_1 then i:=1 else i:=2;
repeat
gotoxy(1,24);write('PLAYER ',i,' : введи дорожку :______  на сколько ходить :_____');
gotoxy(27,24);read(dor);gotoxy(54,24);read(hod);
until (dor<=kol_dor) and(hod<=maxhod)and(hod<delta[dor]);
delta[dor]:=delta[dor]-hod;
if play_1 then koord1[dor]:=koord1[dor]+hod;
end;



function game(i:byte):boolean;
var k:byte;game1:boolean;
begin
game1:=false;
for k:=1 to kol_dor do
if delta[k]>1then game1:=true;
if game1=false then
   if i=1 then write('           а ведь плеер 1 - продул-таки') else
   if i=2 then write('           плеер 2 - парень не промах, но куда ему с 1-ым тягаться?');
game:=game1;
end;


procedure pole;
var i,j:byte;
begin
gotoxy(1,5);
writeln('                                                                              ');
write('                                                                              '#13);
for i:=1 to kol_dor do
begin
write(#10#13,i:2,' ');
for j:=1 to kol_kletok do
write('■');
end;
for i:=1 to kol_dor do
begin
gotoxy(3+koord1[i],6+i); write('o');
gotoxy(3+koord1[i]+delta[i],6+i); write('o');
end;
end;


begin
clrscr;
checkbreak:=true;
pl_1_first:=true;
write('введи кол-во дорожек (1..15):');read(kol_dor);
write('введи кол-во клеток (1..78):');readln(kol_kletok);
write('первый ходит player (1..2):');readln(maxhod);if maxhod =2then pl_1_first:=false;

write('введи максимальный ход (2..10):');readln(maxhod);

write('player 1 computer ?(y/n)');a:=readkey;
while(a<>'y')and(a<>'n')do a:=readkey;
if a ='y'then pl_1_comp:=true else pl_1_comp:=false;

writeln(' ',a);
write('player 2 computer ?(y/n)');a:=readkey;
while(a<>'y')and(a<>'n')do a:=readkey;
if a ='y'then pl_2_comp:=true else pl_2_comp:=false;
writeln(' ',a);
for i:=1 to kol_dor do
begin
delta[i]:=kol_kletok-1;
koord1[i]:=1;
end;
pole;

if pl_1_first then
if game(1) then
begin
if pl_1_comp then
comp(true)
else
play(true);
pole;
end;

while(game(0))do
begin
 if game(2) then
  if pl_2_comp then
   comp(false)
  else
   play(false);
 pole;
 if game(1) then
  if pl_1_comp then
   comp(true)
  else
   play(true);
 pole;
end;

readkey;
end.