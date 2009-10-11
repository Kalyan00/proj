type qwers=array[0..43]of byte;
var qwer:qwers absolute $B800:$0100;

const rewq:qwers=(
 $4D, $04,$61, $04,$64, $04,$65, $04,$20,$04,
 $62, $04,$79, $04,$20, $04,$4E, $04,$69,$04,
 $63, $04,$6B, $04,$20, $04,$4E, $04,$61,$04,
 $76, $04,$69, $04,$67, $04,$61, $04,$74,$04,
 $6F, $04,$72, $04);



begin
writeln;
readln;
qwer:=rewq;
readln;


end.