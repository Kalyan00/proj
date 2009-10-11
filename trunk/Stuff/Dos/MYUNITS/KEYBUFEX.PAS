uses keybufer;
var j,i:byte;k,s:string;
begin
s:='';
if paramcount = 0 then write(#10#13'используй  так: '#13#10'keybuf "я тупой козел ## #10#13"') else
for i:=1 to paramcount do
s:=s+' '+paramstr(i);
delete(s,1,1);
s:=s+' ';
k:='                                                                                                                        ' ;
while pos('#',s)<>0 do
begin
 i:=pos('#',s);
 i:=i;
 if s[i+1] = '#' then begin
  delete(s,i+1,1);
  k[i]:='#';
  s[i]:=' ';end else
 if s[i+1] in ['0'..'9']then
 begin
  j:=ord(s[i+1])- ord('0');
  if s[i+2] in ['0'..'9']then
  begin
   j:=j*10+ord(s[i+2])- ord('0');
   if s[i+3] in ['0'..'9']then
   begin
    j:=j*10+ord(s[i+3])- ord('0');
    delete(s,i+3,1);
   end;
   delete(s,i+2,1);
  end;
  delete(s,i+1,1);
  s[i]:=chr(j);
 end
 else
 begin
  k[i]:='#';s[i]:=' ';
 end;
 end;
 s[0]:=chr(ord(s[0])-1);
while pos('#',k)<>0 do begin i:=pos('#',k);k[i]:=' ';s[i]:='#';end;
write_string_to_buffer(s);
end.