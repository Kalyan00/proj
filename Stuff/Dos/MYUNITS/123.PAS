uses navigatr;

var nul : boolean;
   j,i,k:longint;
   n:array[0..4999]of byte;



begin
nul:=true;
k:=1;
for i:=0 to 4999 do
if ((not( navigator[0,i]=0))and (not nul)) or((navigator[0,i]=0 )and nul) then k:= k+1 else begin write(k,' ') ;k:=1;nul:=not
 nul; end;

readln;

end.