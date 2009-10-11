unit music;
INTERFACE
uses crt,dos;
const
      o1=0;
      o2=12;
      o3=24;
      o4=36;
      o_1=-12;
      o_2=-24;
      o_3=-36;
      c=1+36;
      d=3+36;
      e=5+36;
      f=6+36;
      g=8+36;
      a=10+36;
      h=12+36;
      dies=1;
      bemol=-1;
      pause=100;

      d1=0*256;
      d2=1*256;
      d3=2*256;
      d4=3*256;
      d5=4*256;
      d6=5*256;
      d8=6*256;
      d16=7*256;
      d32=8*256;
type nota=record hc,csec:integer; end;
type procedure_=procedure;
type melody= object
             public
             repeating:boolean;
             temp:integer;
             procedure create;
             procedure plus(so:string);
             procedure play;
             procedure stop;
             procedure delay(t:integer);
             procedure ifend(p:procedure_);
             function  getcurplaing:word;
             function  long:word;
             private
             pend___:procedure_;
             playing:boolean;
             l,cur:integer;lasttime:longint;
             s:array[0..255]of nota;
             function  noteend:boolean;
             procedure playnext;
             end; {csec=temp*4etBeptb}
function  n(a:integer):string;
function  gettime:longint;

IMPLEMENTATION
{procedure sound(a:integer);
var s:string;
begin
setcolor(1);
bar(600,0,640,20);
setcolor(4);
str(a,s);
outtextxy(600,10,s);
end;
}
CONST two:array[0..10]of integer=(1,2,4,8,16,32,64,128,256,518,1024);
      half:array[0..8]of real=(4,2,4/3,1,4/5,2/3,0.5,0.25,0.125);
      k=1.0590463094;

procedure null;far;begin end;

procedure melody.create;
          begin
          playing:=false;
          pend___:=null;
          l:=0;
          cur:=0;
          temp:=100;
          repeating:=true;
          end;
function  gettime:longint;
          var h,m,s,c:word;
          begin
          dos.gettime(h,m,s,c);
          gettime:=((h*60+m)*60+s)*100+c;
          end;
function  n(a:integer):string;
          var s:string;
          begin
          s[0]:=#2;
          s[1]:=char((a mod 256));
          s[2]:=char((a div 256));
          n:=s;
          end;
function  melody.getcurplaing:word;
          begin getcurplaing:=cur end;
function  melody.long:word;
          begin long:=l end;

procedure melody.plus(so:string);
          var n,t:byte;
          begin
          while so[0]<>#0 do
                begin
                n:=byte(so[1]);
                t:=byte(so[2]);
                inc(l);
                s[l].hc:=round(880*exp((n-46)*ln(k)));
                if n=pause then s[l].hc:=0;
                s[l].csec:=round(half[t]*temp);
                delete(so,1,2);
                end;
          end;
procedure melody.play;
          begin
          playing:=true;
          cur:=0;
          lasttime:=gettime;
          s[0].csec:=0;
          end;
procedure melody.ifend(p:procedure_);
          begin
          repeating:=false;
          pend___:=p;
          end;
function  melody.noteend:boolean;
          begin
          noteend:=word(gettime-lasttime)> s[cur].csec;
          end;
procedure sound_(a:word);
          begin
          if a<>0 then
          sound(a) else nosound;
          end;
procedure melody.playnext;
          begin
          nosound;
          if playing then
          with self do
               begin
               inc(cur);
               if cur=l+1 then
                  begin
                  if repeating then begin cur:=0; exit;end;
                  playing:=false;
                  nosound;
                  pend___;
                  exit;
                  end;
               sound_(s[cur].hc);
               lasttime:=gettime;
               end;
          end;
procedure melody.stop;
          begin
          playing:=false;
          nosound;
          end;
procedure melody.delay(t:integer);
          var a:longint;
          begin
          a:=gettime;
          repeat
                if playing then
                if noteend then playnext;
          until word(gettime-a)>(t div 10)
          end;



end.