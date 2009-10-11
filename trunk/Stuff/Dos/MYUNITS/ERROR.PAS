unit error;
INTERFACE
procedure err(s:string);
IMPLEMENTATION
var f:text;
procedure err(s:string);
          begin
          writeln(s);
          assign(f,'error.err');
          rewrite(f);
          writeln(f,s);
          writeln(f,'(*',paramstr(0),'*)');
          close(f);
          halt;
          end;
begin
assign(f,'error.err');
{$i-}erase(f);{$i+}
if ioresult <> 0 then;
end.