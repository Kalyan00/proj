unit advread;
INTERFACE
uses crt_;
procedure reads(var s:string);

IMPLEMENTATION
procedure reads(var s:string);
var x,y,z:byte;c:char;qw,cc,sq:string;
begin
sq:=s;
x:=wherex;
y:=wherey;
z:=ord(s[0]);
while true do
begin
gotoxy(x,y);write(s,' ');
gotoxy(x+z,y);
c:=readkey;
case c of
#13:break;
#27:begin gotoxy(x,y);for z:=0 to ord(s[0]) do write(' ');  s:=sq;  z:=ord(s[0]);end;
#8:if z<>0 then begin delete(s,z,1);dec(z);end;
#0:begin
   c:=readkey;
   case c of
   #75: if z<>0 then dec(z);
   #77: begin if z>=ord(s[0]) then s:=s+' ';inc(z) end;
   #72,#73,#71:begin gotoxy(x,y);for z:=0 to ord(s[0]) do write(' '); z:=0; end;
   #80,#81,#79:z:=ord(s[0]);
   #83:delete(s,z+1,1);
   end;
   end;
else begin cc:=c;insert(cc,s,z+1);inc(z); end;
end;
while (z<ord(s[0]))and (s[ord(s[0])]=' ')do dec(s[0]);

end;
while s[ord(s[0])]=' ' do dec(s[0]);

end;

end.