unit CODER;
INTERFACE
var key:string;
function code(s:string):string;
function decode(s:string):string;

IMPLEMENTATION

function code(s:string):string;
var l,lkey,k,i:byte;
begin
k:=1;
i:=1;
l:=ord(s[0]);
lkey:=ord(key[0]);
while i<=l do
begin
if k>lkey then k:=1;
s[i]:=chr( ord(s[i])+ord(key[k]));
inc(k);
inc(i);
end;
code:=s;
end;


function decode(s:string):string;
var l,lkey,k,i:byte;
begin
k:=1;
i:=1;
l:=ord(s[0]);
lkey:=ord(key[0]);
while i<=l do
begin
if k>lkey then k:=1;
s[i]:=chr( ord(s[i])-ord(key[k]));
inc(k);
inc(i);
end;
decode:=s;
end;


begin
key:='123456';
end.