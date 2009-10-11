unit streal;

INTERFACE
function strtoreal(s:string):real;
IMPLEMENTATION
function strtoreal(s:string):real;
         var i:byte;
             sign,rr,r:real;
             min,zpt:boolean;
         begin
         strtoreal:=0;
         if s[0]=#0 then exit;
         i:=1;
         zpt:=true;
         min:=true;
         while i<=ord(s[0]) do
         case s[i] of
              '0'..'9':inc(i);
              '.',',':if zpt then begin zpt:=not zpt;inc(i)end else delete(s,i,1);
              '-'    :if min then begin min:=not min;inc(i)end else delete(s,i,1);
              else delete(s,i,1);end;
         if s[0]=#0 then exit;
         r:=0;
         sign:=1;
         if s[1]='-' then begin sign:=-1; delete(s,1,1);end;
         while ord(s[0])<>0 do if (s[1]='.')or(s[1]=',') then
         break
         else
         begin
         r:=r*10+ord(s[1])-ord('0');
         delete(s,1,1);
         end;
         rr:=1;
         while ord(s[0])<>0 do if (s[1]='.')or(s[1]=',') then delete(s,1,1)else
         begin
         rr:=rr/10;
         r:=r+rr*(ord(s[1])-ord('0'));
         delete(s,1,1);
         end;
         r:=r*sign;
         strtoreal:=r;
         end;
end.
