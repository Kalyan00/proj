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
if s[i] in ['�'..'�'] then s[i]:=chr(ord(s[i])-ord('�')+ord('�'))else
if s[i] in ['�'..'�'] then s[i]:=chr(ord(s[i])-ord('�')+ord('�'))else
if s[i] ='�' then s[i]:='�';
upcase_:=s;
end;

function downcase_(s:string):string;
var i:byte;
begin
for i:=1 to ord(s[0])+1 do
if s[i] in ['A'..'Z'] then s[i]:=chr(ord(s[i])+ord('a')-ord('A'))else
if s[i] in ['�'..'�'] then s[i]:=chr(ord(s[i])+ord('�')-ord('�'))else
if s[i] in ['�'..'�'] then s[i]:=chr(ord(s[i])+ord('�')-ord('�'))else
if s[i] ='�' then s[i]:='�';
downcase_:=s;
end;



end.