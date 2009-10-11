unit upcas;
INTERFACE
function upcase_(s:string):string;
function downcase_(s:string):string;

IMPLEMENTATION
function upcase_(s:string):string;
var i:byte;
begin
for i:=1 to ord(s[0])+1 do
if s[i] in ['a'..'z'] then s[i]:=chr(ord(s[i])-ord('a')+ord('A'))else
if s[i] in ['†'..'Ø'] then s[i]:=chr(ord(s[i])-ord('†')+ord('Ä'))else
if s[i] in ['‡'..'Ô'] then s[i]:=chr(ord(s[i])-ord('‡')+ord('ê'))else
if s[i] ='Ò' then s[i]:='';
upcase_:=s;
end;

function downcase_(s:string):string;
var i:byte;
begin
for i:=1 to ord(s[0])+1 do
if s[i] in ['A'..'Z'] then s[i]:=chr(ord(s[i])+ord('a')-ord('A'))else
if s[i] in ['Ä'..'è'] then s[i]:=chr(ord(s[i])+ord('†')-ord('Ä'))else
if s[i] in ['ê'..'ü'] then s[i]:=chr(ord(s[i])+ord('‡')-ord('ê'))else
if s[i] ='' then s[i]:='Ò';
downcase_:=s;
end;



end.