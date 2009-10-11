unit timer;

INTERFACE
var koef:longint;
var vartime:longint absolute $40:$6c;
procedure delay(a:word);{milisec}


IMPLEMENTATION
procedure initsec;
          var k,i,nach,tm:longint;
          begin
          k:=1;
          while true do
          begin
          nach:=vartime;
          for i:=0 to k do;
          tm:=vartime;
          tm:=tm-nach;
          if tm>=30 then break;
          k:=k*3;
          end;
          koef:=round((k*17.0)/tm);
          end;
procedure delay(a:word);
          var i,j:longint;
          begin
          j:=(a*koef)div 1000;
          for i:=0 to j do;
          end;
begin
initsec;
end.
