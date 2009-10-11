uses time;
var a:ttime;
    b:longint;



begin
writeln;
writeln('start   time: ',TimeToStr(starttime,TM_hmsm));
for b:=0 to 10000000 do;
getttime(a);
writeln('current time: ',TimeToStr(a,TM_hmsm));
writeln('running time: ',TimeToStr(msectotime(timetomsec(a)-timetomsec(starttime),a)^,TM_sm));


end.