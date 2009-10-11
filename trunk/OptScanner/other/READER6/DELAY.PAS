uses dos;
var koef:real;
procedure initdelay;
var Hour2, Minute2, Second2, Sec1002: Word;
Hour, Minute, Second, Sec100: Word;k,i:longint;

begin
koef:=0;
k:=1;
while koef=0 do
begin
GetTime(Hour, Minute, Second, Sec100);
for i:=0 to k do;
GetTime(Hour2, Minute2, Second2, Sec1002);
koef:=((((hour2-hour)*60+Minute2-Minute)*60+Second2-Second)*100+Sec1002-Sec100)/k;
k:=k*10;
end;

GetTime(Hour, Minute, Second, Sec100);
for i:=0 to k do;
GetTime(Hour2, Minute2, Second2, Sec1002);
koef:=((((hour2-hour)*60+Minute2-Minute)*60+Second2-Second)*100+Sec1002-Sec100)*10/k;
end;


procedure delay(x:real);
var i:longint;
begin
for i:=0 to round(x/koef) do;
end;

begin
initdelay;

end.