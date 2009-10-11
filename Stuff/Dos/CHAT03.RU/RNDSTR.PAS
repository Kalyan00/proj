var i:byte;
begin
randomize;
for i:=0 to 8 do
write(chr(random(20)+ord('a')));
writeln;
end.