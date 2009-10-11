unit abstimer;

INTERFACE
function  getabstime:longint; {sec100}
IMPLEMENTATION
function  getabstime:longint; {sec100}
          var a,b,c,d,e:byte;
          begin
          asm
          MOV   AH,2CH
          INT   $21
          MOV   a,CH            {; HOURS}
          MOV   b,CL            {; MINUTES}
          MOV   c,DH            {; SECONDS }
          MOV   d,DL            {; HUNDREDTHS}
          end;
          getabstime:=((a*60+b)*60+c)*100+d;
          end;
end.