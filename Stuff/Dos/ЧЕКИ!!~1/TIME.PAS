unit time;
INTERFACE
uses dos;
type
  TTime = record    Hour,Min,Sec,msec: Word;  end;
  TTimePTR=^TTime;

CONST  TM_HOUR=1;
       TM_MIN =2;
       TM_SEC =4;
       TM_MSEC=8;
       TM_HMS =        TM_SEC+TM_MIN+TM_HOUR;
       TM_MSM =TM_MSEC+TM_SEC+TM_MIN;
       TM_SM  =TM_MSEC+TM_SEC;
       TM_HMSM=TM_MSEC+TM_SEC+TM_MIN+TM_HOUR;



var starttime: ttime;
function getttime(var a:ttime):TTimePTR;
function TimeToMsec(a:ttime):Longint;
function MsecToTime(a:Longint;var b:ttime):TTimePTR;
function TimeToStr(a:ttime;flag:byte):string;


IMPLEMENTATION
procedure nullfill(var s:string);
  var k:byte; begin for k:=1 to ord(s[0]) do if s[k]=' ' then s[k]:='0';end;

function getttime(var a:ttime):TTimePTR;
  begin gettime(a.hour,a.min,a.sec,a.msec);
  a.msec:=a.msec*10; getttime:=@a;end;
function  TimeToMsec(a:ttime):Longint;
  begin TimeToMsec:=longint(longint(longint(a.hour)*60+a.min)*60+a.sec)*1000+a.msec;end;

function MsecToTime(a:Longint;var b:ttime):TTimePTR;
  begin
  with b do
   begin
    msec:=a mod 1000;
    sec  :=(a div 1000)  mod 60;
    min  :=(a div 60000) mod 60;
    hour :=(a div 3600000);
   end;
  MsecToTime:=@b;
  end;

function TimeToStr(a:ttime;flag:byte):string;
var s,k:string;
begin
with a do begin
s:='';
if( flag mod 2)        = 1 then begin str(hour:2,k);s:=s+k+':';end;
if((flag div 2) mod 2) = 1 then begin str( min:2,k);s:=s+k+':';end;
if((flag div 4) mod 2) = 1 then begin str( sec:2,k);s:=s+k+':';end;
if((flag div 8) mod 2) = 1 then begin str(msec:3,k);s:=s+k+':';end;
s[0]:=chr(ord(s[0])-1);nullfill(s);
end;
TimeToStr:=s;
end;


var a:ttime;

begin
starttime:=getttime(a)^;
end.