unit timemetr;
INTERFACE
uses dos;
var p_:procedure;
function time:longint;

IMPLEMENTATION
procedure nulproc;far; begin end;
function time:longint;
         var Hour, Minute, Second, Sec100: Word;
             aour, ainute, aecond, aec100: Word;
             t:longint;
         begin
         GetTime(Hour, Minute, Second, Sec100);
         p_;
         GetTime(aour, ainute, aecond, aec100);
         t:=aec100-Sec100+100*(aecond-Second+60*(ainute-Minute+60*(aour-hour)));
         time:=t;


         end;

begin
p_:=nulproc;
end.