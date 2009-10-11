{$M $4000,0,10000 }   { 16K stack, no heap }
uses kolcom,crt_,dos,advread;

const nachman=1;nachch=18;konch=25;
const maxdir=620;
type  str12=string[14];
const FC=1;
type  FC_=(FCFC,GD,PD,cEND);
      sost_=(exit_,manchat_);


type dir = record
            Attr: Byte;
            Time: Longint;
            Size: Longint;
            Name: str12;
           end;
type adir=array[0..255]of dir;
type q=(up,down,left,right);

const   SIZ=61+3*2;
type    fls=record
              name:string[60];                      {WARNING:}
              n,c,nach:integer;                 {if changed then  SIZ!!!}
              q:array[0..maxdir]of dir;          {}
              select:array[0..maxdir]of boolean;
              end;
type    nastroyki=record
              temp:string;
              com,cattr:byte;
              speed:word;
              maydel:boolean;
              end;








var mytmp,mydir,yotmp:fls;
    nocom,oopp,chatchar,ctrlrl,ctrlrr,mypan,refresh:boolean;
    sost:sost_;
var vartime:longint absolute $40:$6c;
    nast:nastroyki;




procedure nastroyka(qwerr:string);forward;










function downcase_(s:string):string;
var i:byte;
begin
for i:=1 to ord(s[0])+1 do
if s[i] in ['A'..'Z'] then s[i]:=chr(ord(s[i])+ord('a')-ord('A'))else
if s[i] in ['€'..''] then s[i]:=chr(ord(s[i])+ord(' ')-ord('€'))else
if s[i] in [''..''] then s[i]:=chr(ord(s[i])+ord('เ')-ord(''))else
if s[i] ='๐' then s[i]:='๑';
downcase_:=s;
end;










function getdir_(s:string;var a:array of dir;max:word):word;
var q:word;  D: SearchRec;
begin
q:=0;
if s[ord(s[0])]<>'\' then s:=s+'\';
s:=s+'*.*';
FindFirst(s, AnyFile-VolumeID,d);
  while (DosError = 0)and(q<max-2) do
  begin  inc(q);
    a[q].Attr:=d.Attr;
    a[q].Time:=d.Time;
    a[q].Size:=d.Size;
    a[q].Name:=d.Name;
    if a[q].name='.'then dec(q);
    FindNext(D);
  end;
  a[0].attr:=q;
getdir_:=q;
end;

procedure sortdir(d:word;var a:array of dir);
          var j,n:word;
          FUNCTION  min(var a,b):byte;begin if byte(a)>byte(b) then min:=byte(b) else min:=byte(a)                    end;
          function  bigger(var s,ss:dir):boolean;
                    var q,qq:str12;w:byte;
                    begin
                    if s.name='..' then
                    begin bigger:=true; exit;end;
                    if ss.name='..' then
                    begin bigger:=false; exit;end;
                    if ($10 and s.attr)<>($10 and ss.attr)then
                    if ($10 and s.attr)> ($10 and ss.attr)then
                    begin bigger:=true; exit;end else
                    begin bigger:=false; exit;end;
                    q:=s.name;
                    qq:=ss.name;
                    if (pos('.',q)<>0)=(pos('.',qq)<>0) then
                    begin
                    delete(q,1,pos('.',q));q:=q+' ';
                    delete(qq,1,pos('.',qq));qq:=qq+' ';

                    for w:=1 to min(q[0],qq[0]) do
                    if ord(upcase(q[w]))<ord(upcase(qq[w]))then
                    begin bigger:=true; exit;end else
                    if ord(upcase(q[w]))>ord(upcase(qq[w]))then
                    begin bigger:=false; exit;end;

                    q:=s.name;
                    qq:=ss.name;
                    q[0]:=chr(pos('.',q)-1);q:=q+' ';
                    qq[0]:=chr(pos('.',qq)-1);q:=q+' ';

                    for w:=1 to min(q[0],qq[0]) do
                    if ord(upcase(q[w]))<ord(upcase(qq[w]))then
                    begin bigger:=true; exit;end else
                    if ord(upcase(q[w]))>ord(upcase(qq[w]))then
                    begin bigger:=false; exit;end;

                    end else
                    if pos('.',q)=0then
                    begin bigger:=true; exit;end else
                    begin bigger:=false; exit;end;


                    end;
          var b:dir;
          begin
          if d<3 then exit;
          for j:=1 to d-1 do
          for n:=1 to d-1 do
          if not bigger(a[n],a[n+1]) then
             begin b:=a[n];a[n]:=a[n+1];a[n+1]:=b;end;
          for n:=1 to a[0].attr do
          if ($10 and a[n].attr)=0 then a[n].name:=downcase_(a[n].name)
          end;





function  getabstime:longint; {sec100}
          var a,b,c,d,e:byte;
          begin
          asm
          MOV   AH,2CH
          INT   $21
          MOV   a,CH            {; HOURS}
          MOV   b,CL            {; MINUTES}
          MOV   c,DH            {; SECONDS }
          MOV   d,DL            {; HUNDREDTHS}
          end;
          getabstime:=((a*60+b)*60+c)*100+d;
          end;







procedure writexy(a,b:byte;s:string);
          var x,y,i:byte;
          begin
          for i:=1 to ord(s[0]) do
          begin     textbuffer[b-1,a-2+i,0]:=ord(s[i]);
                    textbuffer[b-1,a-2+i,1]:=textattr;
          end;
          end;












procedure colorxy(a,b,s,c:byte);
          var i:byte;
          begin
          for i:=0 to s-1 do
               textbuffer[b-1,a+i,1]:=c;
          end;














function  normfls(s:str12):str12;
          var sss,ss:str12;
          begin
          if s='..' then begin normfls:=s;exit end;
          ss:=s;
          sss:='             ';
          if pos('.',s)=0 then
          begin      sss:=s;
                     sss[0]:=#12;
                     normfls:=sss;  exit;
          end;
          ss[0]:=chr(pos('.',s)-1);
          delete(s,1,pos('.',s));
          sss:=ss;
          sss[0]:=#9;
          sss:=sss+s;
          sss[0]:=#12;
          normfls:=sss;
          end;

procedure panels;
          procedure lines;
                    procedure linevert(a,b,c:byte);
                    var i:byte;
                    begin
                    for i:=b+1 to c-1 do
                    textbuffer[i,a,0]:=ord('ณ');
                    textbuffer[b,a,0]:=ord('ั');
                    textbuffer[c,a,0]:=ord('ฯ');
                    end;
                    begin
                    linevert(13,nachman-1,nachch-1);
                    linevert(26,nachman-1,nachch-1);
                    linevert(53,nachman-1,nachch-1);
                    linevert(66,nachman-1,nachch-1);
                    end;
          var i,j:byte;
          begin
          for i:=0 to 79 do
          for j:=0 to 25 do begin
          textbuffer[j,i,0]:=32;
          textbuffer[j,i,1]:=textattr;end;
          for i:=nachman-1 to konch-1do
          begin
          textbuffer[i,0,0]:=ord('บ');
          textbuffer[i,39,0]:=ord('บ');
          textbuffer[i,40,0]:=ord('บ');
          textbuffer[i,79,0]:=ord('บ');
          end;
          for i:=0 to 79do
          begin
          textbuffer[nachman-1,i,0]:=ord('อ');
          textbuffer[nachch-1,i,0]:=ord('อ');
          textbuffer[konch-1,i,0]:=ord('อ');
          end;
          textbuffer[nachman-1,0,0]:=ord('ษ');
          textbuffer[konch-1,0,0]:=ord('ศ');
          textbuffer[nachman-1,79,0]:=ord('ป');
          textbuffer[konch-1,79,0]:=ord('ผ');
          textbuffer[nachman-1,40,0]:=ord('ษ');
          textbuffer[konch-1,40,0]:=ord('ศ');
          textbuffer[nachman-1,39,0]:=ord('ป');
          textbuffer[konch-1,39,0]:=ord('ผ');

          textbuffer[nachch-1,0,0]:=ord('ฬ');
          textbuffer[nachch-1,79,0]:=ord('น');
          textbuffer[nachch-1,40,0]:=ord('ฬ');
          textbuffer[nachch-1,39,0]:=ord('น');

lines;
end;









procedure getmyfls(var a:fls);
          begin
          a.n:=getdir_(a.name,a.q,maxdir);
          a.nach:=1;
          a.c:=1;
          fillchar(a.select,sizeof(a.select),false);
          sortdir(a.n,a.q);{}
          end;












procedure sendblock(var a;s:integer);
          type q=array[0..65534]of byte;
          var i:integer;
          begin
          for i:=0 to s do
          begin
          send(q(a)[i]);
          if q(a)[i]=fc then send(byte(FCFC));
          end;
          comwrite(chr(fc)+chr(byte(cEND)));
          end;









procedure getblock(var a;s:integer);
          type q=array[0..65534]of byte;
          var i:integer;k:byte;
          begin
          fillchar(a,s,0);
          i:=0;
          while true do
          if read(k) then
          if k=fc then begin
             while not read(k) do;
             case fc_(k) of
                  cEND:exit;
                  FCFC:begin q(a)[i]:=fc;inc(i)end;
             end;
          end else begin q(a)[i]:=k;inc(i)end;
          end;




procedure GD_(we:boolean);
          var w,s:string;c:byte;
          begin
          s:='';
          w:=nast.temp;
          if w[ord(w[0])]='\'then dec(byte(w[0]));
          if we then begin
          while ((ord(s[ord(s[0])])<>byte(cEND))and(ord(s[ord(s[0])-1])<>byte(FC)))or(ord(s[0])<2)do
          if read(c) then s:=s+chr(c);
          s[0]:=chr(ord(s[0])-2);
          mytmp.name:=w+s;end else mytmp.name:=w;
          getmyfls(mytmp);
          delete(mytmp.name,1,ord(w[0]));
          comwrite(chr(fc)+chr(byte(PD)));
          sendblock(mytmp,SIZ+sizeof(mytmp.q[1])*(mytmp.n+2));
          oopp:=true;
          end;





procedure getyofls(s:string);
          begin
          if not nocom then
          comwrite(chr(fc)+chr(byte(GD))+s+chr(fc)+chr(byte(cEND)));
          end;















procedure updir;
          function  u(var a:fls):boolean;
                    var s:string;
                    begin
                    s:=a.name;
                    u:=true;
                    if (s[0]=#3)and(s[3]='\')and(s[2]=':')then u:=false;
                    while (s[0]<>#0) do
                    if s[ord(s[0])]='\'then
                       begin s[0]:=chr(ord(s[0])-1); break;end
                       else s[0]:=chr(ord(s[0])-1);
                    if s[ord(s[0])]=':' then s:=s+'\';
                    if not mypan then getyofls(s) else a.name:=s;
                    end;
          var w:boolean;
          begin
          if mypan then w:=u(mydir)else w:=u(yotmp);
          if not w then exit;
          if mypan then ctrlRl:=true; end;

procedure enter;
          procedure u(var a:fls);
                    var ss,s:string;
                    begin
                    s:=a.q[a.c].name;
                    ss:=a.name;
                    if a.q[a.c].attr and $10 =0 then exit;
                    if s='..' then begin updir;exit; end;
                    if ss[ord(ss[0])]<>'\'then ss:=ss+'\';
                    ss:=ss+s;
                    if not mypan then getyofls(ss) else a.name:=ss;
                    end;
          begin
          if mypan then u(mydir)else u(yotmp);
          if mypan then if mydir.q[mydir.c].attr and $10 <>0then ctrlRl:=true;
          end;




procedure mov(qq:q);
          procedure u(var a:fls);
          begin
          case qq of
          up   : dec(a.c);
          down : inc(a.c);
          left : a.c:=a.c-(nachch-nachman-1);
          right: a.c:=a.c+(nachch-nachman-1);
          end;
          if a.c<1 then a.c:=1;
          if a.c>a.n then a.c:=a.n;
          if a.nach>a.c then a.nach:=a.c;
          if a.nach<=(a.c-3*(nachch-nachman-1)) then a.nach:=a.c-3*(nachch-nachman-1)+1;
          chatchar:=false;
          end;
          begin
          if mypan then u(mydir)else u(yotmp);
          refresh:=true;
          end;

function cases(var a:char):boolean;
         begin
         cases:=true;
         case ord(a) of
         13:if chatchar then exit else enter;
         10:nastroyka(mydir.name);
         0: case ord(readkey) of
            80:mov(down);
            72:mov(up);
            75:mov(left);
            77:mov(right);
            105,60,95:nastroyka(nast.temp);
            end;
         27:;
         19:nastroyka(nast.temp);
         18:begin chatchar:=false;ctrlrr:=true; ctrlrl:=true;end;
         9:begin chatchar:=false;refresh:=true;mypan:=not mypan; end;
         8:begin chatchar:=false; updir;end;
         else begin chatchar:=true; exit;end;
         end;   cases:=false;
         end;

var FCFCC:boolean;
function casein(var a:byte):boolean;
         begin
         if FCFCC then
            begin
            FCfcc:=not FCFCC;
            casein:=false;
            case FC_(a) of
                 FCFC:begin casein:=true; a:=FC;end;
                 GD:GD_(true);
                 PD:begin refresh:=true;getblock(yotmp,sizeof(fls));end;
            end;
            exit;
            end;
         casein:=true;
         if a=fc then begin FcFCC:=true;casein:=false; exit;end;

         end;


procedure manchat;
          var c:char;cc,x,y,xx,yy:byte;
          function  date(a:longint):string;
                    var ss,s:string; DT: DateTime;
                    begin
                    s:='';
                    unpacktime(a,DT);
                    str(dt.Year:4,ss);s:=s+ss+'/';
                    str(dt.Month:2,ss);s:=s+ss+'/';
                    str(dt.Day:2,ss);s:=s+ss;
                    while pos(' ',s)<>0 do s[pos(' ',s)]:='0';
                    date:=s;
                    end;
          function  time(a:longint):string;
                    var ss,s:string; DT: DateTime;
                    begin
                    s:='';
                    unpacktime(a,DT);
                    str(dt.Hour:2,ss);s:=s+ss+':';
                    str(dt.Min:2,ss);s:=s+ss+':';
                    str(dt.Sec:2,ss);s:=s+ss;
                    while pos(' ',s)<>0 do s[pos(' ',s)]:='0';
                    time:=s;
                    end;
          function  size(a:longint):string;
                    var s:string;
                    begin
                    if a>1024*1024 then begin str(a div (1024*1024),s);s:=s+'M'end else
                    if a>1024      then begin str(a div (1024     ),s);s:=s+'k'end else
                    str(a,s);
                    size:=s;
                    end;
          function  attr(a:byte):string;
                    var s:string;
                    begin
                    s:='';
                    if (a and 1  )<>0 then s:=s+'R'else s:=s+'อ';
                    if (a and 2  )<>0 then s:=s+'H'else s:=s+'อ';
                    if (a and 4  )<>0 then s:=s+'S'else s:=s+'อ';
                    if (a and $20)<>0 then s:=s+'A'else s:=s+'อ';
                    attr:=s;
                    end;
          procedure w2(var a:fls;oop:byte);
                    var i,j:integer;ss:string;
                    begin
                    j:=0; ss:=a.name;
                    if ord(ss[0])>38 then begin delete(ss,10,ord(ss[0])-33);insert('...',ss,10);end;
                    writexy(2+oop,nachman,'ออออออออออออัออออออออออออัออออออออออออป');
                    writexy(2+oop,nachman,ss);
                    for i:=0 to 3*(nachch-nachman-1) -1do
                    writexy(2+oop+(i div(nachch-nachman-1))*13,nachman+1+(i mod (nachch-nachman-1)),'            ');
                    with a do
                    if nach<=n then
                    for i:=a.nach to a.n do
                    if (i-nach) div (nachch-nachman-1)<3then
                    writexy(2+oop+((i-nach) div (nachch-nachman-1))*13,nachman+1+(i-nach) mod (nachch-nachman-1)
                                               ,normfls(q[i].name));
                    with a do if ((oop=0)and mypan)or((oop<>0)and not mypan) then
                    colorxy(1+oop+((c-nach) div (nachch-nachman-1))*13,1+nachman+(c-nach) mod (nachch-nachman-1),12,8+7*16);
                    writexy(1+oop,nachch,'ฬออออออออออออฯออออออออออออฯออออออออออออน');
                    if a.q[a.c].name<>'' then begin
                    if a.q[a.c].attr and $10 <>0 then
                    writexy(3+oop,nachch,'Dir')else
                    writexy(3+oop,nachch,size(a.q[a.c].size));
                    writexy(10+oop,nachch,attr(a.q[a.c].attr));
                    writexy(17+oop,nachch,date(a.q[a.c].time));
                    writexy(30+oop,nachch,time(a.q[a.c].time));
                    end;
                    end;

          procedure w(a:char;oop:byte;var x,y:byte);
                    var i,j:byte;
                    begin
                    case a of
                    #0,#10,#27:;
                    #13:begin inc(y); x:=oop;end;
                    else begin textbuffer[y,x,0]:=ord(a); end;
                    end;
                    inc(x);
                    if x=39+oop then begin x:=1+oop;inc(y);end;
                    if y= konch-1 then
                     begin dec(y);
                      for j:=nachch to konch-3 do
                       for i:=1+oop to 38+oop do
                        textbuffer[j,i,0]:=textbuffer[j+1,i,0];
                      for i:=1+oop to 38+oop do
                       textbuffer[konch-2,i,0]:=32;
                     end;
                    end;

          var chwea:boolean;
          begin
          ctrlRl:=true;
          ctrlRr:=true;
          yotmp.name:='';
          yotmp.n:=0;
          x:=1;y:=nachch;xx:=41;yy:=nachch;
          gotoxy(x+1,y+1);
          panels;
          oopp:=false;
          yotmp.q[1].attr:=$FF;
          repeat
                if (yotmp.q[1].attr=$FF)and oopp then begin getyofls(yotmp.name); oopp:=not oopp;end;
                if ctrlrl then begin
                   refresh:=true;
                   getmyfls(mydir);
                   ctrlRl:=not ctrlRl;
                   end;
                if ctrlrr then begin
                   refresh:=true;
                   getyofls(yotmp.name);
                   ctrlRr:=not ctrlRr;
                   end;
                if refresh then begin
                   w2(mydir,0);
                   w2(yotmp,40);
                   refresh:=not refresh;
                   end;
                if keypressed then
                   begin chwea:=chatchar;if c=#13 then chwea:=false; c:=readkey;
                   if cases(c) then begin chatchar:=true;w(c,0,x,y);gotoxy(x+1,y+1);
                      if not nocom then
                      if c=chr(fc)then comWrite(chr(fc)+chr(byte(fcfc))) else send(ord(c));
                   end else if chwea then begin
                   w(#13,0,x,y);gotoxy(x+1,y+1);
                      if not nocom then
                      send(13);

                   end;
                   end;
                if not nocom then
                if kolcom.read(cc) then begin
                   if casein(cc) then w(char(cc),40,xx,yy);end;
          until (c=#27)or(sost<>manchat_);
          if c=#27 then sost:=exit_;
          end;












procedure doit;
          begin
          while true do
          case sost of
          manchat_:manchat;
          else exit;
          end;
          end;












procedure savenast;
          var f:file of nastroyki;
          begin
          {$I-}
          assign(f,'set.dat');
          rewrite(f);
          {$I+}
          if ioresult=0 then begin
          system.write(f,nast);
          close(f);
          end;
          end;








procedure getnast;
          var f:file of nastroyki;
          begin
          with nast do begin
                       temp:='c:\temp';
                       com:=com1;
                       cattr:=NONE+D8+S2;
                       speed:=B115200;
                       maydel:=false;
                       end;
          {$I-}
          assign(f,'set.dat');
          reset(f);
          {$I+}
          if ioresult=0 then begin
          system.read(f,nast);
          close(f);
          end else savenast;
          end;

procedure nastroyka;
          var n:nastroyki;u,uu:string;
          const x=10; y=5;xx=70;yy=20; max=5;
          var q:array [0..yy-y,0..xx-x,0..1]of byte;a,i,j,tattr:byte;
          const par:array[0..4]of byte=(0,$18,$28,$08,$38);
          function gtp:byte;var i:byte; begin for i:=4 downto 0 do if par[i]=(n.cattr div 8)*8then break;gtp:=i;end;
          procedure incc(opo:byte);
                    const we:array[0..6]of word=($0001,$0002,$0003,$0006,$0008,$000C,$0030);
                    function gt :byte;var i:byte;begin for i:=0 to 6 do if we[i]=n.speed then break; gt:=i; end;
                    begin
                    case a of
                    0: begin n.com:=n.com+2*opo-1;case n.com of com4+1:n.com:=com1;255:n.com:=com4 end end;
                    1: case byte(gt+2*opo-1) of 255:n.speed:=we[6];7:n.speed:=we[0];else n.speed:=we[gt+2*opo-1] end;
                    2: begin if (n.cattr mod 4 = 3)and (opo=1)then n.cattr:=n.cattr-3 else if (n.cattr mod 4 = 0)and (opo=0)
                             then n.cattr:=n.cattr+3  else n.cattr:=n.cattr+2*opo-1;end;
                    3:case byte(gtp+2*opo-1) of 255:n.cattr:=n.cattr -par[gtp] +par[4];5:n.cattr:=n.cattr -par[gtp] + par[0];
                                             else n.cattr:=n.cattr -par[gtp]+ par[byte(gtp+2*opo-1)];end;
                    4: n.cattr:=(n.cattr xor 4);
                    end;end;

          function  c0:string;begin case n.com of com1:c0:='com1';com2:c0:='com2';com3:c0:='com3';com4:c0:='com4';
                                    else begin n.com:=com1; c0:='com1'end;end;end;
          function  c1:string;begin case n.speed of 1:c1:='115200';2:c1:='57600 ';3:c1:='38400 ';6:c1:='19200 ';8:c1:='14400 ';
                                    $C:c1:='9600  ';$30:c1:='2400  ';else begin n.speed:=$0001;c1:='115200';end;end;end;
          function  c2:string;begin case n.cattr mod 4 of 0:c2:='5';1:c2:='6';2:c2:='7';3:c2:='8';end;end;
          function  c3:string;begin case gtp of 0:c3:='N';1:c3:='E';2:c3:='M';3:c3:='O';4:c3:='S';end;end;
          function  c4:string;begin case N.CATTR and 4 of 0:c4:='1';4:c4:='2';end;end;
          procedure wr;
                    procedure cw(c:byte);begin if a=c then textattr:=15+8*16 else textattr:=8+7*16;end;
                    begin
                    cw(0);writexy(x+13,y+2,c0);
                    cw(1);writexy(x+30,y+2,c1);
                    cw(2);writexy(x+55,y+2,c2);
                    cw(3);writexy(x+56,y+2,c3);
                    cw(4);writexy(x+57,y+2,c4);
                    textattr:=14;writexy(x+22,y+3,'                                  ');
                          writexy(x+22,y+3,n.temp);

                    if a=5 then gotoxy(x+22+ord(n.temp[0]),y+3)else gotoxy(80,25);
                    cw(255);
                    end;



          begin
          tattr:=textattr;textattr:=15+7*16; n:=nast;a:=0;n.temp:=qwerr;
          for i:=0 to yy-y do for j:=0 to xx-x do begin
                           q[i,j,0]:=textbuffer[y+i-1,x+j-1,0];
                           q[i,j,1]:=textbuffer[y+i-1,x+j-1,1];       end;
          for i:=y to yy do begin writexy(x,i,'บ');writexy(xx,i,'บ'); end;
          for i:=x to xx do begin writexy(i,y,'อ'); writexy(i,yy,'อ'); end;
          writexy(x,y,'ษ');writexy(x,yy,'ศ');writexy(xx,y,'ป');writexy(xx,yy,'ผ');
          for i:=y+1 to yy-1 do for j:=x+1 to xx-1 do writexy(j,i,' ');
          textattr:=14+7*16;
          writexy(x+3,y+2,'Com Port:');
          writexy(x+22,y+2,'Speed:');
          writexy(x+40,y+2,'Com Settings:');
          writexy(x+3,y+3,'Shared Directiory:');

          while true do
          begin
          wr;
          case readkey of
          #0:  case ord(readkey) of
               75,72:if a>0 then dec(a) else a:=max;
               77,80:if a=max then a:=0 else inc(a);
               73:incc(0);
               81:incc(1);
               end;
          ' ','+':incc(1);
          '-':incc(0);
          #27:break;
          #13:begin if not nocom then if nast.temp<>n.temp then begin nast:=n; GD_(false);end;nast:=n;break;end;
          else if a=5 then begin
          textattr:=7;writexy(x+22,y+3,'                                  ');
          gotoxy(x+22,y+3);system.getdir(0,u);uu:=n.temp;reads(uu);
          if uu='' then uu:=mydir.name;
               {$I-}system.chdir(uu);{$I+}if ioresult=0 then n.temp:=uu;system.chdir(u);


gotoxy(80,25);end;
          end;
          end;
          textattr:=tattr;
          for i:=0 to yy-y do for j:=0 to xx-x do begin
                           textbuffer[y+i-1,x+j-1,0]:=q[i,j,0];
                           textbuffer[y+i-1,x+j-1,1]:=q[i,j,1];       end;
          savenast;
          end;




procedure getargs;
          var n:byte;s:string;
          begin
          sost:=manchat_;
          mypan:=1=1;
          nocom:=false;
          if paramcount<>0 then
          for n:=1 to paramcount do begin s:=downcase_(paramstr(n));
          if s= '/nocom'then begin nocom:=true end else
          {if s=''then begin  end  else}
          end;
          mytmp.name:=nast.temp;
          end;







begin
getargs;
getnast;
system.getdir(0,mydir.name);
FCFCC:=false;
if not nocom then openCom(nast.com, nast.speed,nast.cattr , 0, 0,15);

doit;
if not nocom then closecom(nast.com);
end.









{EnD}