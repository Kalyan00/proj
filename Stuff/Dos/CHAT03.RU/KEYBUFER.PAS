unit keybufer;
interface
uses Dos;
var key_buffer : array[1..18] of word absolute $0040:$001A;
function writekey(a:word):boolean;
function write_string_to_buffer(s:string):boolean;

implementation
function writekey(a:word):boolean;
var regs:registers;
begin
inline($FA); {CLI}
with regs do begin
AH:=$05;
CX:=a;
intr($16,regs);
inline($FB); {STI}
writekey:=AL=$00;
end;
end;

function write_string_to_buffer(s:string):boolean;
var so:boolean; ca:word;
begin
so:=true;
while (s[0]<>#0)and so do
begin
if s[1]=#0then
begin
ca:=ord(s[2])*$100;
delete(s,1,1);
end else ca:=ord(s[1]);
so:=writekey(ca);
delete(s,1,1);
end;
write_string_to_buffer:=so;
end;

end.