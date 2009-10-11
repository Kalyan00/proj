unit anket;

INTERFACE
uses graph,streal,crt,colors;
procedure qwrite(a:byte;s:string);
procedure closeanket;far;

procedure nilproc; far;
const qarr=20;
      smax=30;











type met=(edit,select,press);
type q_=object
              vc,oc,x,y:integer;
              pos:byte;
              m:met;
              s,vopr:string[smax];
              function  qedit:byte;
              procedure stir;
              procedure ris;
              procedure risactiv(w:boolean);
              function  long:integer;
     end;
type q__=array[1..qarr] of q_;
type qptr=^q_;






type anketa=object
              z,vc,oc,x,y:integer;
              res,pos,kol:byte;
              exxit:boolean;
              q:q__;
              qold:q__;
              p:array[1..qarr]of procedure;
              procedure incpos;
              procedure decpos;
              procedure refresh;
              procedure hide;
              function  add(m:met;v:string):byte;
              procedure new(x_,y_,z_:integer);
              function  qlast:qptr;
              function  run(i:byte):byte;
              procedure ext;
     end;
     anketaptr=^anketa;


var cla:anketaptr;



IMPLEMENTATION
procedure nilproc;begin end;
procedure closeanket;
          begin
          cla^.exxit:=true;
          end;


procedure anketa.incpos;
          begin
          if pos=kol then pos:=1 else inc(pos);
          end;

procedure anketa.decpos;
          begin
          if pos=1 then pos:=kol else dec(pos);
          end;

procedure anketa.ext;
          begin
          exxit:=true;
          end;



procedure anketa.refresh;
          var i:byte;
          begin
          hide;
          for i:=1 to kol do
          if i<> pos then
          q[i].ris else q[i].risactiv(false);
          end;



procedure anketa.hide;
          var i:byte;
          begin
          for i:=1 to kol do q[i].stir;
          end;
function  anketa.add(m:met;v:string):byte;
          begin
          kol:=kol+1;
          q[kol].vc:=vc;
          q[kol].oc:=oc;
          q[kol].x:=x;
          q[kol].y:=y+z*kol;
          q[kol].m:=m;
          q[kol].vopr:=v;
          q[kol].s:='';
          if m=select then q[kol].s:='Да';
          qold:=q;
          add:=kol;
          end;

procedure anketa.new(x_,y_,z_:integer);
          var i:byte;
          begin
          for i:=0 to qarr do p[i]:=nilproc;
          vc:=vopr_c;
          oc:=otv_c;
          kol:=0;
          pos:=1;
          x:=x_;
          y:=y_;
          z:=z_;
          end;

function  anketa.qlast:qptr;
          begin
          qlast:=@q[kol];
          end;




function  anketa.run(i:byte):byte;
          var ccla:anketaptr;
          begin
          run:=0;
          ccla:=cla;
          cla:=@self;
          if (i<>0)and(i<=kol) then begin pos:=i;end else
          if pos>kol then pos:=1;
          res:=0;exxit:=false;
          refresh;
          while (res<>27)and not exxit do
          begin
          res:=q[pos].qedit;
          q[pos].ris;
          case res of
               72:decpos;
               80:incpos;
               13:begin hide;p[pos];cla:=@self;refresh; end;
               27:begin run:=27;end;
               end;
          end;cla:=ccla;
          hide;
          end;

function  q_.qedit:byte;
          var c:char;e:byte;
          begin  qedit:=0;
                 risactiv(false);
          case m of
          edit:  begin
                 e:=oc;
                 oc:=selec_c;
                 risactiv(false);
                 pos:=ord(s[0]);
                 c:=#13;
                 repeat
                 c:=readkey;
                 until (c<>#13) or (s<>'');
                 stir;
                 oc:=e;
                 if c=#13 then begin qedit:=80;exit;end;
                 case c of
                      #27,#0: ;
                      else begin s:='';pos:=0;end;
                 end;
                 while true do
                 begin
                 stir;
                 case c of
                 #0:  case ord(readkey) of
                      72:begin qedit:=72;exit;end;
                      80:begin qedit:=80;exit;end;
                      77:if pos<ord(s[0])then inc(pos);
                      75:if pos>0        then dec(pos);
                      83:begin delete(s,pos+1,1); end;                 {del}
                      end;
                 #13: begin qedit:=80;exit;end;
                 #27: begin qedit:=27;exit;end;
                 #8:  if pos<>0then begin delete(s,pos,1); pos:=pos-1 end;
                 'A'..'Z','a'..'z','А'..'Я','а'..'п','р'..'я','Ё','ё',
                 '0'..'9',' ','-','.':
                      begin pos:=pos+1;insert(c,s,pos);end;
                 else break;
                 end;
                 if ord(s[0])>smax then begin s[0]:=chr(smax);pos:=smax;end;
                 risactiv(true);
                 c:=readkey;
                 if c=',' then c:='.';
                 end;
                 end;
          select:case ord(readkey) of
                 0:  case ord(readkey) of
                     72:qedit:=72;
                     80:qedit:=80;
                     end;
                 27: qedit:=27;
                 13: qedit:=13;
                 else begin stir; if s='Да'then s:='Нeт' else s:='Да';risactiv(false);end;
                 end;
          press: case ord(readkey) of
                 13: qedit:=13;
                 27: qedit:=27;
                 0:  case ord(readkey) of
                     72:qedit:=72;
                     80:qedit:=80;
                     end;
                 end;
          end;end;

procedure q_.stir;
          var i,j:integer;
          begin for i:=x to x+long do
          for j:=y to y+8 do putpixel(i,j,fon_c1);
          end;
procedure q_.ris;
          begin
          stir;
          setcolor(vc);
          outtextxy(x,y,vopr);
          setcolor(oc);
          if m<>press then
          if s<>'' then outtextxy(x+ord(vopr[0])*8,y,s)
                   else outtextxy(x+ord(vopr[0])*8,y,'Пусто');
          end;






procedure q_.risactiv(w:boolean);
          begin
          ris;
          setcolor(0);
          line(x,y+8,x+long,y+8);
          if w then line(x+long-8*(ord(s[0])-pos),y+8,x+long-8*(ord(s[0])-pos),y);
          end;

function  q_.long:integer;
          begin
          if (s[0]<>#0)then long:=(ord(vopr[0])+ord(s[0]))*8 else
          long:=(ord(vopr[0])+5)*8;
          if m=press then long:=ord(vopr[0])*8;
          end;
var qwer:array[0..10]of q_;
procedure qwrite(a:byte;s:string);
          begin
          qwer[a].x:=50;
          qwer[a].y:=50+30*a;
          qwer[a].vc:=0;
          qwer[a].m:=press;
          qwer[a].stir;
          qwer[a].vopr:=s;
          qwer[a].ris;
          end;





begin end.