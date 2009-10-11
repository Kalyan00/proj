var s:string;
begin
s:='a:\';
chdir(s);
getdir(0,s);

writeln(s);

end.