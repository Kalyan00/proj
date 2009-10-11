{$S+}
uses crt;
type
  MASSIV= array[0..30]of byte;
  MASSIVPTR=^MASSIV;


const
  player_f1:array[0..7] of byte = (0 ,2 ,5,3,2,2 ,0,1);
  player_f2:array[0..7] of byte = (7,11,7,5,5,10,9,8);
  KOL_KL:byte=14;
  KOL_DOR:byte =1;
  HOD:byte=3;
var

  HODX:INTEGER;
  HODY:BYTE;

procedure LUB_HOD(I:WORD);
begin HODx:= i mod hod;HODY:= i div hod;end;


procedure hod_II3;
begin
write('THE  BEST HOD  IS  : ',HODY,'  ',HODX);
end;





function make_norm(N:BYTE;PPP:MASSIV;PPP_N:MASSIVPTR):byte;
var i,j:byte;
begin
j:=0;
for i:=0to N-1 do
if PPP[i]MOD(HOD+1) <> 0 then
begin PPP_N^[j]:=PPP[i];j:=j+1;end;
make_norm:=J;
end;





function HOD_II2(N:BYTE;PPP:MASSIV):boolean;
var N_N,N_N_N,i,j:byte;
   PPP_N:MASSIV;
   PPP_N_N:MASSIV;
label end0,endtrue,endfalse;
begin
  N_N:=N;
  N_N:=make_norm(N,ppp,@PPP_N);
if N_N=0 then goto endfalse;
  for i:=1 to HOD*N_N do
  begin
    LUB_HOD(i);
    if(PPP_N[HODy]>=hodx)then
    begin

      N_N_N:=make_norm(N_N,ppp_N,@PPP_N_N);
      for j:=1 to HOD*N_N_N do
      begin
        LUB_HOD(J);
        if(PPP_N_N[HODy]>=hodx)then
        begin
          PPP_N_N[HODy]:=PPP_N_N[HODy]-hodx;
          if not hod_II2(N_N_N,PPP_N_N) then goto endfalse;
        end;
      end;
    end;
  end;
  endtrue:
  hod_II2:=true;
  goto end0;
  endfalse:
  hod_II2:=false;
  end0:

end;




procedure HOD_II;
var savx,savy,i,j:word; PPP:MASSIV;
    rezult:boolean;
begin
rezult:=false;
j:=0;
for i:=0 to KOL_DOR-1 do
if (player_f2[i]-player_f1[i]-1) mod (HOD+1) <>0 then
begin
if player_f2[i]-player_f1[i]-1>2*(HOD+1) then
ppp[j]:=((player_f2[i]-player_f1[i]-1) mod (hod+1))+hod+1
else ppp[j]:=player_f2[i]-player_f1[i]-1;
j:=j+1;
end;

for i:=1 to hod*KOL_DOR do
begin
LUB_HOD(i);
if    PLAYER_F2[hody] >player_f1[hody] +hodx then begin
savx:=hodx;
savy:=hody;
if HOD_II2(j,ppp) then
begin
hodx:=savx;
hody:=savy;
i:=hod*KOL_DOR;
rezult:=true;
hod_II3;
end;
end;end;
if not rezult then
for i:=0 to KOL_DOR -1do
if(PLAYER_F2[hody] >player_f1[hody]+1)then
begin
hodx:=1;
hody:=i;
i:=KOL_DOR-1;
rezult:=true;
hod_II3;
end;

if not rezult then
for i:=0 to KOL_DOR-1 do
if(PLAYER_F2[hody] <KOL_KL-1)then
begin
hodx:=-1;
hody:=i;
i:=KOL_DOR-1;
rezult:=true;
hod_II3;
end;
if not rezult then write(chr(7));
end;






begin

clrscr;
hod_II;
end.
