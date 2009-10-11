{$n+}
unit sub;
INTERFACE
uses crt,graph,colors,upcas,streal,vect,DOS,anket,bmpsav;
const
      radius=3;
      ustmax=10;
      linl_max=47;
      linv_max=7*3;
      lina_max=11*3;
      ust_f='data.dat';
      err_f='error.txt';
      ramk=false;








type lin=record x,y,xx,yy:integer;c:byte;end;
     cir=record x,y,r,c:integer;end;
     ris_=record dvig,l,v,a,ipr,T,Bitt:boolean;fi:real end;
                 const cris:ris_=(dvig:true;l:true;v:true;a:true;ipr:true;T:true;Bitt:true;fi:0);
type textxy =record x,y,c:integer;s:string;end;
     PLlris_=record name:textxy;lin_:array[0..linl_max]of lin;c_:array[0.. 4]of cir;xcm,ycm:integer;end;
     PLvris_=record name:textxy;lin_:array[0..linv_max]of lin;c_:cir;xcm,ycm:integer;end;
     PLaris_=record name:textxy;lin_:array[0..lina_max]of lin;c_:cir;xcm,ycm:integer;end;
     PLl_=record A,B,C,D5,D43,E6,E5:point;koef:real; end;
     PLv_=record b21,b3,d5,d43:point;koef:real; w,vc:array[1..5]of real;end;
     PLa_=record b21,b3,d5,d43,n,k:point;koef:real; end;
     gr_ =record name:textxy;xc,yc,x,y,xx,yy:integer;koef:real;visible:boolean;
                 lin_:array[0..5]of lin;end;
     ustanovky_=record family,gruppa,variant:string;
          wcp,delta,pm,h,cd,sm,l1,AS1,CS3:real;m,Js:array[1..5]of real;end;





var  PLl__,PLl,oldPLl:PLl_;
     PLv__,PLv,oldPLv:PLv_;
     PLa__,PLa,oldPLa:PLa_;
     PLlris,oldPLlris:PLlris_;
     PLvris,oldPLvris:PLvris_;
     PLaris,oldPLaris:PLaris_;
     ustanovky:ustanovky_;
     curf,nachf,konf,mdv,dfi,l1,h,sm,cd:real;
     a1,a2,a3,a4:anketa;
     ris:ris_;wqeriuy:byte;
     grIpr,grT,grBitt:gr_;
     iprarray,dtarray:array[0..720]of real;
     diagBitt:record iprmax,x0,y0,bmn,bmx,tgmn,tgmx:real; imn,imx:integer;end;







procedure allfon;
procedure back;far;
procedure BittKass;
procedure changerasp;far;
procedure changk;far;
procedure circle_(a:cir);
procedure closegraph;
procedure cls;
procedure creatankets;
function  delsp(s:string):string;
function  DT(aa:real):real;
procedure err(s:string);
procedure exexit;
function  filesizeext(s:string):longint;
procedure fon(x,y:word);
procedure igraph;
function  ipr:real;
procedure line_(var a:lin);
procedure makegraph(b:boolean);
procedure makemdv;
procedure makePLa;
procedure makePLaris;
procedure makePLl(f:real);
procedure makePLlris;
procedure makePLv;
procedure makePLvris;
procedure makestrel(aa,bb:vector;var c,d,e:lin;col:byte);
function  mc:real;
procedure nach;
procedure nachkon;
procedure nastr;far;
function  normfi2pi(x:real):real;
function  normfipi(x:real):real;
procedure obnovl;
procedure obnovla;
procedure obnovlv;
procedure ot4et;far;
function  pc:real;
function  proverka1:boolean;
function  proverka2:boolean;
procedure PutPixel(X, Y: Integer; Pixel: Word);
Procedure Quit;far;
procedure ramka(x,y,xx,yy,c:integer);
procedure ramka_(x,y,xx,yy,c:integer);
procedure readust;
procedure risgrext(color:integer);
procedure risgrext2(color:integer);
procedure riss;far;
procedure riss_;far;
procedure savepict;far;
function  sign(x:real):real;
procedure stir(var a:gr_);
function  str_(s:real):string;
procedure writetextxy(xc,yc,c:integer;name:textxy);
procedure writeust;






IMPLEMENTATION  {---------системные функции-----------------------}

var OldExit:Pointer;
Procedure Quit;
          begin
          while keypressed do readkey;
          closegraph;
          ExitProc:=OldExit
          end;
procedure err(s:string);var f:text;
          begin assign(f,err_f);rewrite(f);
          writeln(f,s);close(f);halt;end;
function  sign(x:real):real;begin if x>0then sign:=1 else sign:=-1;end;
function  normfipi(x:real):real;
          begin while x>pi do x:=x-2*pi;while x<-pi do x:=x+2*pi;normfipi:=x;end;
function  normfi2pi(x:real):real;
          begin while x<0 do x:=x+2*pi;while x>2*pi do x:=x-2*pi;normfi2pi:=x;end;
function  delsp(s:string):string;
          var i:byte;begin i:=1;
          while i<ord(s[0]) do if s[i]=' ' then delete(s,i,1) else inc(i);delsp:=s;
          end;

function  str_(s:real):string;
          var ss:string;
          begin
          system.str(s:0:3,ss);
          str_:=ss;
          end;












procedure exexit;
          var exext:q_;c:byte;
          begin
          writeust;
          exext.vc:=15;
          exext.oc:=8;
          exext.m:=select;
          exext.x:=240;
          exext.y:=240;
          exext.vopr:='Вы хотите выйти: ';
          exext.s:='Да';
          repeat
          c:=exext.qedit;
          until (c=13)or(c=27);
          if c=13 then
          if exext.s='Да' then halt;
          exext.stir;
          if ramk then ramka(20,70,310,370,ram_c);
          end;

      {---------------системно-графические функции----------------}

procedure PutPixel(X, Y: Integer; Pixel: Word);
          begin  if((x>0)and(y>0)and(x<640)and(y<480))then
          graph.PutPixel(X, Y,Pixel);end;

procedure igraph;var D,M,E:Integer;
          begin D:= Detect;InitGraph(D, M,'');
          E:= GraphResult;if E<> grOk then err('initgraph');end;

procedure closegraph;begin graph.closegraph;end;

procedure fon(x,y:word);begin putpixel(x,y,fon_c1);end;

procedure allfon; var x,y:word;
          begin for y:=240 to 480 do for x:=0 to 640 do
          begin  fon(x,y);  fon(x,480-y);end; end;



procedure line_(var a:lin);
        var i:integer;
        begin
        with a do
        if abs(x-xx)>abs(y-yy)then begin
          if x>xx then begin i:=xx;xx:=x;x:=i; i:=yy;yy:=y;y:=i; end;
          if c=fon_c then
          for i:=0 to xx-x do fon(x+i,y+i*(yy-y)div(xx-x))else
          for i:=0 to xx-x do putpixel(x+i,y+i*(yy-y)div(xx-x),c)
             end else if y<>yy then begin
          if y>yy then begin i:=yy;yy:=y;y:=i;i:=xx;xx:=x;x:=i; end;
          if c=fon_c then
          for i:=0 to yy-y do
            fon(x+i*(xx-x)div(yy-y),y+i) else
          for i:=0 to yy-y do putpixel(x+i*(xx-x)div(yy-y),y+i,c)
          end;
        end;



procedure circle_(a:cir);
        var i,di:real;
        begin
        if a.r=0 then exit;
        di:=pi/a.r/4;
        i:=0;
        with a do
        while i<=2.01*pi do
          begin
          if a.c=fon_c then
          fon(round(x+r*cos(i)),round(y+r*sin(i))) else
          putpixel(round(x+r*cos(i)),round(y+r*sin(i)),c);
          i:=i+di;
          end;
        end;





procedure ramka_(x,y,xx,yy,c:integer);
          var a:lin;        begin
          a.c:=c;a.x :=x ;a.y :=y ;a.xx:=x ;a.yy:=yy;line_(a);
          a.c:=c;a.x :=x ;a.y :=y ;a.xx:=xx;a.yy:=y ;line_(a);
          a.c:=c;a.x :=xx;a.y :=yy;a.xx:=x ;a.yy:=yy;line_(a);
          a.c:=c;a.x :=xx;a.y :=yy;a.xx:=xx;a.yy:=y ;line_(a);end;
procedure ramka(x,y,xx,yy,c:integer);
          begin ramka_(x,y,xx,yy,c);
          ramka_(x-1,y-1,xx+1,yy+1,c);
          ramka_(x-3,y-3,xx+3,yy+3,c);end;










      {----------------------ввод данных--------------------------}

function  filesizeext(s:string):longint;var f:file of byte;
          begin filesizeext:=0;assign(f,ust_f);{$i-}reset(f){$i+};
          if ioresult=0 then begin filesizeext:=filesize(f); close(f);end;end;
procedure back;
          begin
          repeat while a1.run(0)=27 do exexit;until proverka1;
          repeat while a2.run(0)=27 do exexit;until proverka2;
          end;
procedure cls;
          var i:integer;
          begin
          SetbkColor(7);clrscr;SetbkColor(0);setcolor(7);
          for i:=400 to 480 do
          line(0,i,640,i);
          makepll(pi/2+arctan(sqrt(sqr(cd)-sqr(sm/2)) *2/sm));
          obnovl;obnovl;
          end;

procedure riss_;
          begin
          cls;
          with a3 do
          with ris do begin
          dvig:=q[2].s='Да';
          l:=q[3].s='Да';
          v:=q[4].s='Да';
          a:=q[5].s='Да';
          ipr:=q[6].s='Да';
          t:=q[7].s='Да';
          Bitt:=q[8].s='Да';
          if delsp(q[9].s)='' then q[9].s:=str_(nachf*180/pi);
          fi:=strtoreal(q[9].s);
          fi:=fi*pi/180;
          riss;readkey;
          while keypressed do readkey;
          end;cls;
          end;

procedure savepict;
          var dvigg:boolean;a:anketa;f:file of byte;i:byte;
          begin
          dvigg:=ris.dvig;
          ris.dvig:=false;
          riss;
          a.new(500,0,10);
          a.add(edit,'имя файла ');
          a.p[a.add(press,'cохранить')]:=closeanket;
          if a.run(0)<>27 then
          begin
          if not writebmp(a.q[1].s)then
             err('не могу сохранить картинку');
          end;
          cls;
          ris.dvig:=dvigg;
          end;



procedure changk;
          var koef:^real;q:real;
          begin case a4.pos of
          8 :begin q:=  1.2;koef:=@grT   .koef;end;
          9 :begin q:=  1.2;koef:=@grIpr .koef;end;
          10:begin q:=  1.2;koef:=@grBitt.koef;end;
          11:begin q:=1/1.2;koef:=@grT   .koef;end;
          12:begin q:=1/1.2;koef:=@grIpr .koef;end;
          13:begin q:=1/1.2;koef:=@grBitt.koef;end;
          end;
          koef^:=koef^*q;
          end;








procedure changerasp;
          var koef:^real; x,y:^integer;c:char;q:real;
          begin
          q:=1;
          case a4.pos of
          2:begin
            x:=@PLlris.xcm;
            y:=@PLlris.ycm;
            koef:=@pll.koef;end;
          3:begin
            x:=@PLvris.xcm;
            y:=@PLvris.ycm;
            koef:=@plv.koef;end;
          4:begin
            x:=@PLaris.xcm;
            y:=@PLaris.ycm;
            koef:=@pla.koef;end;
          5:begin
            x:=@grIpr.xc;
            y:=@grIpr.yc;
            koef:=@q;end;
          6:begin
            x:=@grT.xc;
            y:=@grT.yc;
            koef:=@q;end;
          7:begin
            x:=@grBitt.xc;
            y:=@grBitt.yc;
            koef:=@q;end;
          end;
          repeat
          obnovl;
          obnovlv;
          obnovla;
          obnovl;
          obnovlv;
          obnovla;
          risgrext(gr_c);
          c:=readkey;
          risgrext(fon_c);
          case c of
          #0:case ord(readkey) of
                  72:y^:=y^-10;
                  80:y^:=y^+10;
                  77:x^:=x^+10;
                  75:x^:=x^-10;
                  end;
          '+':koef^:=koef^*1.2;
          '-':koef^:=koef^/1.2;
          end;
          until (c=#13)or(c=#27);
          cls;
          end;







procedure nastr;
          begin
          with a4 do begin new(400,50,15);
{1 }       add(press,'используйте +-'#24#25#26#27);
{2 }       p[add(press,'L')]:=changerasp;
{3 }       p[add(press,'v')]:=changerasp;
{4 }       p[add(press,'a')]:=changerasp;
{5 }       p[add(press,'Iпр')]:=changerasp;
{6 }       p[add(press,'T')]:=changerasp;
{7 }       p[add(press,'Виттенб.')]:=changerasp;
{8 }       p[add(press,'увеличить kT')]:=changk;
{9 }       p[add(press,'увеличить kI')]:=changk;
{10}       p[add(press,'увеличить kFi')]:=changk;
{11}       p[add(press,'уменьшить kT')]:=changk;
{12}       p[add(press,'уменьшить kI')]:=changk;
{13}       p[add(press,'уменьшить kFi')]:=changk;
{14}       p[add(press,'вернуться')]:=closeanket;
          run(1);end;
          end;

procedure creatankets;
          begin
          with a1 do begin
          new(400,50,15);
          add(edit,'Фамилия ');
          add(edit,'Группа  ');
          add(edit,'Вариант ');
          add(edit,'pm    = ');
          add(edit,'Lcd   = ');
          add(edit,'h     = ');
          add(edit,'l1    = ');
          add(edit,'sm    = ');
          add(edit,'wcp   = ');
          add(edit,'б     = ');
          p[add(press,'продолжение')]:=closeanket;
          end;
          with a2 do begin
          new(400,50,15);
          add(edit,'AS1= ');
          add(edit,'CS3= ');
          add(edit,'m1 = ');
          add(edit,'m2 = ');
          add(edit,'m3 = ');
          add(edit,'m4 = ');
          add(edit,'m5 = ');
          add(edit,'Js1= ');
          add(edit,'Js2= ');
          add(edit,'Js3= ');
          add(edit,'Js4= ');
          add(edit,'Js5= ');
          p[add(press,'продолжение')]:=closeanket;
          end;
          with a3 do begin
          new(400,50,15);
          p[add(press,'запуск ')]:=riss_;
          add(select,'движение ');
          add(select,'план L   ');
          add(select,'план v   ');
          add(select,'план a   ');
          add(select,'Iпр      ');
          add(select,'T       ');
          add(select,'Виттенб. ');
          add(edit,'начальный угол° ');
          p[add(press,'назад')]:=back;
          p[add(press,'сохранить картинку')]:=savepict;
          p[add(press,'настройка эскиза')]:=nastr;
          p[add(press,'отчет')]:=ot4et;
          p[add(press,'Выход')]:=closeanket;
          end;
          readust;
          end;









procedure readust;
          var f:file of ustanovky_;
          begin
          if filesizeext(ust_f)<>sizeof(ustanovky) then exit;
          assign(f,ust_f);
          {$i-}reset(f){$i+};
          if ioresult<>0 then exit;
          read(f,ustanovky);
          if ioresult<>0 then exit;
          with ustanovky do
          with a1 do begin
          q[1].s:=family;
          q[2].s:=gruppa;
          q[3].s:=variant;
          str(pm:0:3,q[4].s);
          str(cd:0:3,q[5].s);
          str(h :0:3,q[6].s);
          str(l1:0:3,q[7].s);
          str(sm:0:3,q[8].s);
          str(wcp  :0:3,q[9].s);
          str(delta:0:3,q[10].s);
          end;
          with ustanovky do
          with a2 do begin
          str(AS1:0:3,q[1].s);
          str(CS3:0:3,q[2].s);
          str(m[1] :0:3,q[3].s);
          str(m[2] :0:3,q[4].s);
          str(m[3] :0:3,q[5].s);
          str(m[4] :0:3,q[6].s);
          str(m[5] :0:3,q[7].s);
          str(Js[1]:0:3,q[8].s);
          str(Js[2]:0:3,q[9].s);
          str(Js[3]:0:3,q[10].s);
          str(Js[4]:0:3,q[11].s);
          close(f);
          end; end;


procedure writeust;
          var f:file of ustanovky_;
          begin
          with ustanovky do
          with a1 do begin
          family:=q[1].s;
          gruppa:=q[2].s;
          variant:=q[3].s;
          pm:=strtoreal(q[4].s);
          cd:=strtoreal(q[5].s);
          h :=strtoreal(q[6].s);
          l1:=strtoreal(q[7].s);
          sm:=strtoreal(q[8].s);
          wcp:=strtoreal(q[9].s);
          delta:=strtoreal(q[10].s);
          end;
          with ustanovky do
          with a2 do begin
          AS1:=strtoreal(q[1].s);
          CS3:=strtoreal(q[2].s);
          m[1] :=strtoreal(q[3].s);
          m[2] :=strtoreal(q[4].s);
          m[3] :=strtoreal(q[5].s);
          m[4] :=strtoreal(q[6].s);
          m[5] :=strtoreal(q[7].s);
          Js[1]:=strtoreal(q[8].s);
          Js[2]:=strtoreal(q[9].s);
          Js[3]:=strtoreal(q[10].s);
          Js[4]:=strtoreal(q[11].s);
          end;
          assign(f,ust_f); {$i-}rewrite(f){$i+};
          if ioresult<>0 then err('странная ошибка: я не могу перезаписать файл '+ust_f);
          write(f,ustanovky);
          close(f);
          end;




function  proverka1:boolean;
          var hh,xx,k:real;ii:byte;
          begin
          with a1 do begin
          proverka1:=false;
          writeust;
          readust;

          for ii:=4 to 8 do
          if strtoreal(q[ii].s)=0 then q[ii].s:='' else
          str(strtoreal(q[ii].s):0:3,q[ii].s);

          for ii:=1 to kol-1 do if q[ii].s=''then begin pos:=ii;exit;end;
          with ustanovky do begin
          if abs(l1-sm*h/2/cd)>1.2 then
          if l1=4490816 then begin
          l1:=sm*h/2/cd;
          str(l1:0:3,q[7].s);
            pos:=7;exit;end else
          begin pos:=7;exit;end;
          end;
          h :=ustanovky.h;
          sm:=ustanovky.sm;
          cd:=ustanovky.cd;
          l1:=ustanovky.l1;
          if abs(cd)<abs(sm/2) then begin pos:=5;exit;end;
          proverka1:=true;
          hh:=cd;
          xx:=sm*2;
          k:=200/hh;
          PLl.koef:=200/xx;
          if PLl.koef > k then PLl.koef:=k;
          PLlris.ycm:=220+round((cd/2-h)*PLl.koef);
          end;
          cls;
          end;




function  proverka2:boolean;
          begin
          proverka2:=false;
          writeust;
          readust;
          nachkon;
          makemdv;
          makegraph(true);
          makepll(pi/2);
          makeplv;
          gripr.koef:=50/ipr;
          diagBitt.iprmax:=ipr;
          grBitt.koef:=50/pi;
          a3.q[9].s:=str_(nachf*180/pi);
          ris.fi:=nachf;
          proverka2:=true;
          end;



      {------------------расчет, рисование -----------------------}

procedure makestrel(aa,bb:vector;var c,d,e:lin;col:byte);
          var a,b,q:point;
          begin
          a.v:=aa;
          b.v:=bb;
          c.x :=round(a.x);
          c.y :=round(a.y);
          c.xx:=round(b.x);
          c.yy:=round(b.y);
          c.c:=col;
          d:=c;
          q.v:=mns(a.v,b.v);
          q.v:=fir(fi(q.v)+pi/4,4);
          q.v:=pls(q.v,b.v);
          d.x:=round(q.x);
          d.y:=round(q.y);
          e:=c;
          q.v:=mns(a.v,b.v);
          q.v:=fir(fi(q.v)-pi/4,4);
          q.v:=pls(q.v,b.v);
          e.x:=round(q.x);
          e.y:=round(q.y);
          end;















procedure makePLl(f:real);
          var qwer,ab,ey:real;
          begin curf:=normfipi(f);
          if PLl.koef=0 then PLl.koef:=1;
          if abs(cd)<abs(sm/2) then err('cd<sm/2');
          ey:=sqrt(sqr(cd)-sqr(sm/2))-h;
          ab:=(sm/2)*h/cd;
          with PLl do begin
          vectt__(A  .v);vectt__(B  .v);vectt__(C  .v);
          vectt__(D5 .v);vectt__(D43.v);vectt__(E6 .v);vectt__(E5 .v);
          a.x:=0;a.y:=0;
          b.x:=ab*cos(-f);b.y:=ab*sin(-f);
          c.x:=0;c.y:=-h;
          qwer:=cd/sqrt(sqr(b.x-c.x)+sqr(b.y-c.y));
          d43.x:=c.x+(b.x-c.x)*qwer;d43.y:=c.y+(b.y-c.y)*qwer;
          d5.x:=d43.x;d5.y:=ey;
          e5.y:=d5.y;e5.x:=d5.x+sm+30/koef;
          e6:=e5;e6.x:=sm/2+20/koef;
          end;end;

procedure makePLv;
          var BC:point;
          begin
          oldPLv:=PLv;
          with PLv do begin
          b21:=PLl.B;
          vectt__(b21.v);vectt__(b3 .v);vectt__(b3 .v);
          vectt__(d5 .v);vectt__(d43.v);
          b21.v:=fir(fi(b21.v)-pi/2,modul(b21.v));
          BC.v:=mns(PLl.b.v,PLl.c.v);
          b3.v:=fir( fi(bc.v)+pi/2*sign(cos(fi(BC.v)+pi/2-fi(b21.v))) , abs(modul(b21.v)*cos(fi(BC.v)+pi/2-fi(b21.v))));
          d43.v:=mul(b3.v,modul(mns(PLl.d43.v,PLl.c.v))/modul(mns(PLl.B.v,PLl.C.v)));
          d5:=d43;d5.y:=0;
          BC.v:=fir(fi(b3.v)-fi(mns(PLl.B.v,PLl.C.v)),1);
          w[1]:=1;
          w[2]:=modul(d43.v)/cd*sign(fi(BC.v));
          w[3]:=w[2];
          w[4]:=0;
          w[5]:=0;
          vc[1]:=modul(b21.v)*ustanovky.as1/l1;
          vc[2]:=modul(b21.v);
          vc[3]:=modul(d43.v)*ustanovky.Cs3/cd;
          vc[4]:=modul(d43.v);
          vc[5]:=vc[4];
          koef:=150*(h-l1)/l1/cd; end;
          end;














procedure makePLa;
          var q:point;
          begin oldPLa:=PLa;
          with PLa do begin
          b21:=PLl.B;
          vectt__(b21.v);vectt__(b3 .v);vectt__(b3 .v);
          vectt__(d5 .v);vectt__(d43.v);
          b21.v:=fir(fi(b21.v)+pi,modul(b21.v));
          k.v:=fir(fi(mns(PLv.b3.v,PLv.b21.v))+pi/2*sign(PLv.w[3]),
          abs(2*PLv.w[3]*modul(mns(PLv.b3.v,PLv.b21.v))));
          n.v:=fir(fi(mns(PLl.c.v,PLl.b.v)),sqr(modul(PLv.b3.v))/modul(mns(PLl.b.v,PLl.c.v)));
          q.v:=mns(pls(b21.v,k.v),n.v);
          b3.v:=fir(fi(n.v)+pi/2*sign(normfipi(fi(pls(b21.v,k.v))-fi(n.v))),abs(cos(fi(q.v)-(fi(n.v)+pi/2))*modul(q.v)));
          b3.v:=pls(b3.v,n.v);
          d43.v:=mul(b3.v,modul(mns(PLl.d43.v,PLl.c.v))/modul(mns(PLl.B.v,PLl.C.v)));
          d5:=d43; d5.y:=0;
          koef:=150*(h-l1)/l1/cd;end;
          end;


procedure makePLlris;
          var i:integer;
          procedure makeline(var a,b:point;var c:lin);
                    begin c.x:=round(PLlris.xcm+a.x);c.y:=round(PLlris.ycm+a.y);c.xx:=round(PLlris.xcm+b.x);
                    c.yy:=round(PLlris.ycm+b.y);c.c:=color;end;
          procedure makecir(var a:point;var b:cir);
                    begin b.x:=PLlris.xcm+round(a.x);b.y:=PLlris.ycm+round(a.y);b.r:=radius;b.c:=color;end;
          procedure makeshtr(x,y:real;var a,b,c,d:lin);
                    begin
                    a.c:=color;
                    a.y:=round(PLlris.ycm+y);a.yy:=round(PLlris.ycm+y+3);
                    a.x:=round(PLlris.xcm+x+3);a.xx:=round(PLlris.xcm+x);
                    b:=a;b.xx:=b.x;b.x:=b.x+3;
                    c:=b;c.xx:=c.x;c.x:=c.x+3;
                    d:=c;d.xx:=d.x;d.x:=d.x+3;
                    end;
          procedure maketreug(a:point;var b,c,d:lin);
                    begin b.c:=color;b.y:=round(PLlris.ycm+10+a.y);b.yy:=b.y;b.x:=round(PLlris.xcm+a.x-6);
                    b.xx:=b.x+12;c:=b;c.xx:=c.xx-8;c.yy:=c.yy-7;d:=b;d.x:=d.x+8;d.y:=d.y-7;end;
          procedure make4ug(a:point;al:real;var b,c,d,e,f:lin);
                    var q,w,r,t:point;
                    begin
                    q.x:=a.x+6*cos(al)-12*sin(al);q.y:=a.y-12*cos(al)-6*sin(al);
                    w.x:=a.x-6*cos(al)-12*sin(al);w.y:=a.y-12*cos(al)+6*sin(al);
                    r.x:=a.x-6*cos(al)+12*sin(al);r.y:=a.y+12*cos(al)+6*sin(al);
                    t.x:=a.x+6*cos(al)+12*sin(al);t.y:=a.y+12*cos(al)-6*sin(al);
                    f.c:=color;
                    f.x :=PLlris.xcm+round((q.x+w.x)/2);f.y :=PLlris.ycm+round((q.y+w.y)/2);
                    f.xx:=PLlris.xcm+round((r.x+t.x)/2);f.yy:=PLlris.ycm+round((r.y+t.y)/2);
                    makeline(q,w,b);
                    makeline(w,r,c);
                    makeline(r,t,d);
                    makeline(t,q,e);
                    end;
          const ox :point=(rezerved:12;x:20;y:0);
                ox1:point=(rezerved:12;x:60;y:0);
                ox2:point=(rezerved:12;x:55;y:5);
                ox3:point=(rezerved:12;x:55;y:-5);
                ox4:point=(rezerved:12;x:60;y:10);
                ox5:point=(rezerved:12;x:64;y:18);
                ox6:point=(rezerved:12;x:64;y:10);
                ox7:point=(rezerved:12;x:60;y:18);
                oy :point=(rezerved:12;x:0;y:-20);
                oy1:point=(rezerved:12;x:0;y:-60);
                oy2:point=(rezerved:12;x:5;y:-55);
                oy3:point=(rezerved:12;x:-5;y:-55);
                oy4:point=(rezerved:12;x:-10;y:-60);
                oy5:point=(rezerved:12;x:-12;y:-58);
                oy6:point=(rezerved:12;x:-14;y:-60);
                oy7:point=(rezerved:12;x:-12;y:-52);
          begin
          oldPLlris:=PLlris;
          PLl__:=PLl;
          with PLl__ do begin
          A  .x:=A.x*koef;  A  .y:=-A.y*koef;
          B  .x:=B.x*koef;  B  .y:=-B.y*koef;
          C  .x:=C.x*koef;  C  .y:=-C.y*koef;
          D5 .x:=D5.x*koef; D5 .y:=-D5.y*koef;
          D43.x:=D43.x*koef;D43.y:=-D43.y*koef;
          E6 .x:=E6.x*koef; E6 .y:=-E6.y*koef;
          E5 .x:=E5.x*koef; E5 .y:=-E5.y*koef;
          end;



          with PLl__ do begin
          with PLlris do begin

          makecir(a,c_[1]);
          makecir(c,c_[2]);
          makecir(b,c_[3]);
          makecir(d43,c_[4]);
          makeline(a,b,lin_[1]);
          makeline(c,d43,lin_[35]);
          makeline(d5,e5,lin_[5]);lin_[5].x:=lin_[5].x+9;
          lin_[4]:=lin_[5];lin_[4].xx:=lin_[4].x;lin_[4].y:=lin_[4].y-20;lin_[4].yy:=lin_[4].y+40;
          lin_[3]:=lin_[4];lin_[3].x:=lin_[3].x-18;lin_[3].xx:=lin_[3].x;
          makeline(d43,d43,lin_[10]);
          lin_[10].x:=lin_[10].x-6;lin_[10].y:=lin_[10].y-12;lin_[10].xx:=lin_[10].x+12;lin_[10].yy:=lin_[10].y;
          lin_[12]:=lin_[10];lin_[12].x:=lin_[12].xx;lin_[12].y:=lin_[12].yy+24;
          lin_[11]:=lin_[12];lin_[11].xx:=lin_[10].x;lin_[11].yy:=lin_[11].y;
          lin_[13]:=lin_[11];lin_[13].x:=lin_[10].x;lin_[13].y:=lin_[10].y;
          maketreug(a,lin_[16],lin_[17],lin_[18]);
          maketreug(c,lin_[19],lin_[20],lin_[21]);

          make4ug(b,arctan((c.x-d43.x)/(c.y-d43.y)),lin_[6],lin_[7],lin_[8],lin_[9],lin_[36]);
          lin_[35].x:=lin_[36].x;lin_[35].y:=lin_[36].y;
          lin_[36].x:=round(c.x+xcm);lin_[36].y:=round(c.y+ycm);


          makeshtr(e6.x,e6.y+3,lin_[23],lin_[24],lin_[25],lin_[26]);
          lin_[22]:=lin_[23];lin_[22].x:=lin_[22].xx;
          lin_[27]:=lin_[26];lin_[27].xx:=lin_[27].x;
          lin_[15]:=lin_[22];lin_[15].xx:=lin_[15].x+12;lin_[15].yy:=lin_[15].y;
          lin_[14]:=lin_[15];lin_[14].y:=lin_[14].y-6;lin_[14].yy:=lin_[14].y;
          makeshtr(c.x-6,c.y+10,lin_[28],lin_[29],lin_[30],lin_[31]);
          makeshtr(a.x-6,a.y+10,lin_[32],lin_[33],lin_[34],lin_[2]);
          makeline(ox,ox1,lin_[37]);
          makeline(ox2,ox1,lin_[38]);
          makeline(ox3,ox1,lin_[39]);
          makeline(ox4,ox5,lin_[41]);
          makeline(ox6,ox7,lin_[42]);
          makeline(oy,oy1,lin_[43]);
          makeline(oy2,oy1,lin_[44]);
          makeline(oy3,oy1,lin_[45]);
          makeline(oy4,oy5,lin_[46]);
          makeline(oy5,oy6,lin_[47]);
          makeline(oy7,oy5,lin_[40]);
          for i:=37 to 47 do lin_[i].c:=4;
          end;
          end;
          end;








procedure makePLvris;
          var p:point;
          begin
          oldPLvris:=PLvris;
          PLv__:=PLv;
          with PLv__ do
          with PLvris do
          begin
          b21.y:=-b21.y;b3 .y:=- b3.y;d5 .y:=- d5.y;d43.y:=-d43.y;
          vectt__(p.v);p.x:=xcm;p.y:=ycm;
          makestrel(p.v,pls(p.v,mul(b21.v,koef)),lin_[3],lin_[1],lin_[2],strel_c);
          makestrel(p.v,pls(p.v,mul(b3.v,koef)),lin_[4],lin_[5],lin_[6],strel_c);
          makestrel(pls(p.v,mul(b21.v,koef)),pls(p.v,mul(b3.v,koef)),lin_[13],lin_[14],lin_[15],strelo_c);
          makestrel(p.v,pls(p.v,mul(d43.v,koef)),lin_[7],lin_[8],lin_[9],strel_c);
          makestrel(p.v,pls(p.v,mul(d5.v,koef)),lin_[10],lin_[11],lin_[12],strel_c);
          makestrel(pls(p.v,fir(-pi/2,20)),pls(p.v,fir(-pi/2,60)),lin_[16],lin_[17],lin_[18],strel_koor_c);
          makestrel(pls(p.v,fir(0,20)),pls(p.v,fir(0,60)),lin_[19],lin_[20],lin_[21],strel_koor_c);
          c_.r:=radius;c_.x:=round(p.x);
          c_.y:=round(p.y);c_.c:=4;end;end;

procedure makePLaris;
          var q,w,z,p:point;
          begin
          oldPLaris:=PLaris;
          PLa__:=PLa;
          with PLa__ do
          with PLaris do
          begin
          b21.y:=-b21.y;
          b3 .y:=- b3.y;
          d5 .y:=- d5.y;
          d43.y:=-d43.y;
          n  .y:=-  n.y;
          k  .y:=-  k.y;
          vectt__(p.v);p.x:=xcm;p.y:=ycm;
          makestrel(p.v,pls(p.v,mul(b21.v,koef)),lin_[3],lin_[1],lin_[2],strel_c);
          z.v:=pls(p.v,mul(b3.v,koef));
          makestrel(p.v,z.v,lin_[4],lin_[5],lin_[6],strel_c);
          q.v:=pls(p.v,mul(n.v,koef));
          makestrel(p.v,q.v,lin_[22],lin_[23],lin_[24],streln_c);
          w.v:=pls(pls(p.v,mul(b21.v,koef)),mul(k.v,koef));
          makestrel(pls(p.v,mul(b21.v,koef)),w.v,lin_[25],lin_[26],lin_[27],strelk_c);
          makestrel(q.v,z.v,lin_[28],lin_[29],lin_[30],strelt_c);
          makestrel(w.v,z.v,lin_[31],lin_[32],lin_[33],strelt_c);
          makestrel(pls(p.v,mul(b3.v,koef)),pls(p.v,mul(b21.v,koef)),lin_[13],lin_[14],lin_[15],strelo_c);
          makestrel(p.v,pls(p.v,mul(d43.v,koef)),lin_[7],lin_[8],lin_[9],strel_c);
          makestrel(p.v,pls(p.v,mul(d5.v,koef)),lin_[10],lin_[11],lin_[12],strel_c);
          makestrel(pls(p.v,fir(-pi/2,20)),pls(p.v,fir(-pi/2,60)),lin_[16],lin_[17],lin_[18],strel_koor_c);
          makestrel(pls(p.v,fir(0,20)),pls(p.v,fir(0,60)),lin_[19],lin_[20],lin_[21],strel_koor_c);
          c_.r:=radius;c_.x:=round(p.x);
          c_.y:=round(p.y);c_.c:=4;
          end;
          end;







procedure obnovl;
          var i:byte;
          begin
          makePLlris;
          for i:=1 to linl_max do
          begin
          oldPLlris.lin_[i].c:=fon_c;
          line_(oldPLlris.lin_[i]);
          line_(PLlris.lin_[i]);
          end;
          for i:=1 to 4 do begin
          oldPLlris.c_[i].c:=fon_c;
          circle_(oldPLlris.c_[i]);
          circle_(PLlris.c_[i]);
          end;
          writetextxy(PLlris.xcm,PLlris.ycm,1,PLlris.name);


          end;

procedure obnovlv;
          var i:byte;
          begin
          makePLvris;
          with PLvris do
          for i:=1 to linv_max do
          begin
          oldPLvris.lin_[i].c:=fon_c;
          line_(oldPLvris.lin_[i]);
          line_(lin_[i]);
          end;
          oldPLvris.c_.c:=fon_c;
          circle_(oldPLvris.c_);
          circle_(PLvris.c_);
          writetextxy(PLvris.xcm,PLvris.ycm,1,PLvris.name);
          end;




procedure obnovla;
          var i:byte;
          begin
          makePLaris;
          with PLaris do
          for i:=1 to lina_max do
          begin
          oldPLaris.lin_[i].c:=fon_c;
          line_(oldPLaris.lin_[i]);
          line_(lin_[i]);
          end;
          oldPLaris.c_.c:=fon_c;
          circle_(oldPLaris.c_);
          circle_(PLaris.c_);
          writetextxy(PLaris.xcm,PLaris.ycm,1,PLaris.name);
          end;




function  ipr:real;
          var i:real; k:byte;
          begin
          i:=0;
          ustanovky.JS[5]:=0;
          with PLv do
          with ustanovky do
          for k:=1 to 5 do
          i:=i+m[k]*sqr(vc[k])+js[k]*sqr(w[k]);
          ipr:=i;
          end;

function  pc:real;
          var s_sm:real;
          begin
          s_sm:=(pll.d5.x+sm/2)/sm;
          if (s_sm<0.1)or(s_sm>0.9) then pc:=0 else
          if (normfipi(curf-nachf)>0)and(normfipi(curf-konf)<0) then
          pc:=ustanovky.pm else pc:=0.2*ustanovky.pm;
          end;

function  mc:real;begin mc:=sign(normfipi(fi(plv.d43.v)+pi/2))*modul(plv.d43.v)*Pc; end;
function  DT(aa:real):real;begin DT:=-mc*dfi;end;
procedure nachkon;
          var a,min,max:real;
          begin
          a:=0;
          makePLl(a);
          min:=PLl.e5.x;
          max:=min;
          while a<2*pi do
          begin
          makePLl(a);
          if min>PLl.e5.x then begin min:=PLl.e5.x; nachf:=a;end;
          if max<PLl.e5.x then begin max:=PLl.e5.x; konf:=a;end;
          a:=a+pi/180;
          end;
          end;



procedure makemdv;
          var a,d,t:real;
          begin
          mdv:=0;
          d:=dfi;
          dfi:=pi/180;
          a:=0;
          t:=0;
          while a<2*pi do
          begin
          makePLl(a);
          makePLv;
          t:=t+DT(a);
          a:=a+dfi;
          end;
          mdv:=-t;
          dfi:=dfi;
          end;


procedure BittKass;
          var mm:extended;i,j:integer;
          begin
      (*    with diagBitt do
          with ustanovky do begin
          tgmn:=wcp*(1-delta)/2;
          tgmx:=wcp*(1+delta)/2;  {Y=tgmx*X+bmx}
          mm:=10000*tgmx*iprmax;
          qwrite(1,str_(iprmax)+' mm++');


          for i:=0 to 360 do
              if mm> abs(tgmx*iprarray[i]+tgmx*100*iprmax+dtarray[i])
                 then begin
                 mm:=abs(tgmx*iprarray[i]+tgmx*100*iprmax+dtarray[i]);
                 j:=i;
                 qwrite(8,str_(mm)+' mm');
                 qwrite(9,str_(i)+' mm');
{                 readkey;}
              end;
{??????}          imx:=j;
          bmx:=-tgmx*iprarray[j]-dtarray[j];
          mm:=10000*tgmn*iprmax;
          qwrite(8,str_(mm)+' mm');readkey;
          for i:=0 to 360 do
              if mm> abs(tgmn*iprarray[i]-iprmax*tgmn*100+dtarray[i])
                 then begin
                 mm:=abs(tgmn*iprarray[i]-iprmax*tgmn*100+dtarray[i]);
                 j:=i;
{??????????
                 qwrite(8,str_(mm)+' mm');
                 qwrite(9,str_(i)+' mm');
{}              end;
          imn:=j;
          bmn:=-tgmn*iprarray[j]-dtarray[j];
          x0:=(bmn-bmx)/(tgmx-tgmn);
          y0:=tgmn*x0+bmn;
          qwrite(10,str_(x0)+'x0');
          qwrite(11,str_(y0)+'y0');
          end;   (**)
          end;


procedure makegraph(b:boolean);
          var a,d,t,max:real;i:word;
          begin
          d:=dfi; dfi:=pi/180;
          a:=nachf;
          t:=0; max:=0;
          for i:=0 to 360 do
          begin
          makePLl(a);
          makePLv;
          t:=t+DT(normfi2pi(a-nachf));
          iprarray[i]:=ipr;
          dtarray[i]:=-(mdv*(a-nachf)/2/pi+t);
          if abs(dtarray[i])>max then max:=abs(t);
          a:=a+dfi;
          end;
          dfi:=d;if b then grt.koef:=50/max;
          BittKass;
          end;

procedure riss;
          var qwer:real;
          begin
          with ris do begin
          fi:=normfipi(fi);
          qwer:=fi;
          risgrext(gr_c);
          wqeriuy:=3;
          outtextxy(20,460,ustanovky.family+', группа '+ustanovky.gruppa+', вариант '+ustanovky.variant);
          repeat
          risgrext2(4);
          qwer:=normfipi(qwer);
          makePLl(qwer);
          makePLv;
          makePLa;
          if l then obnovl;
          if v then obnovlv;
          if a then obnovla;
          qwer:=qwer+dfi;
          until keypressed or ((not dvig)and(qwer<fi)and(qwer>fi-dfi));
          while keypressed do readkey;
          end;
          end;

















procedure stir(var a:gr_);
          var i,j:integer;
          begin
          with a do
          begin
          for i:=x to xx do
          for j:=y to yy do
          fon(i,j);
          x:=xc;xx:=xc;y:=yc;yy:=yc;
          visible:=false;
          end;
          end;








procedure risgrext(color:integer);
          procedure strel(qq:byte;var a:gr_);
                    var i:byte;p:point;
                    begin
                    with a do
                    if color = fon_c then
                    for i:=0 to 5 do
                    begin lin_[i].c:=fon_c;line_(lin_[i]);end else begin
                    vectt__(p.v);
                    visible:=true;
                    p.x:=xc;
                    p.y:=yc;
                    writetextxy(xc,yc,1,name);
                    if qq =1 then
                    makestrel(pls(p.v,fir(-pi/2,0)),pls(p.v,fir(-pi/2,60)),lin_[0],lin_[1],lin_[2],strel_koor_c)
                    else
                    makestrel(pls(p.v,fir(pi/2,60)),pls(p.v,fir(-pi/2,25)),lin_[0],lin_[1],lin_[2],strel_koor_c);
                    makestrel(pls(p.v,fir(0    ,0)),pls(p.v,fir(0    ,60)),lin_[3],lin_[4],lin_[5],strel_koor_c);
                    for i:=0 to 5 do line_(lin_[i]);
                    end;
                    end;
          var i:integer;x_,y_,xo,yo:integer;
          begin
          makegraph(false);
          if color <> fon_c then
          setcolor(color)else
          setcolor(fon_c1);

          if ris.T then
          with grT do begin
               strel(1,grT);
               x:=xc;xx:=xc;y:=yc;yy:=yc;
               x_:=xc;
               y_:=yc+round(dtarray[0]*koef);
               for i:=0 to 360 do
               begin
                  xo:=x_;yo:=y_;
                  x_:=xc+round(i*pi/180*grBitt.koef);
                  y_:=yc+round(dtarray[i]*koef);
                  line(x_,y_,xo,yo);
                  if x>x_ then x:=x_;
                  if xx<x_ then xx:=x_;
                  if y>y_ then y:=y_;
                  if yy<y_ then yy:=y_;
               end;
          end;
          if ris.ipr then
          with gripr do begin
               strel(1,gripr);
               x:=xc;xx:=xc;y:=yc;yy:=yc;
               x_:=xc;
               y_:=yc-round(iprarray[0]*koef);
               for i:=0 to 360 do
               begin
               xo:=x_;yo:=y_;
               x_:=xc+round(i*pi/180*grBitt.koef);
               y_:=yc+round(iprarray[i]*koef);
               line(x_,y_,xo,yo);
               if x>x_ then x:=x_;
               if xx<x_ then xx:=x_;
               if y>y_ then y:=y_;
               if yy<y_ then yy:=y_;
               end;
          end;
          if ris.bitt then
          with grBitt do begin
               strel(2,grBitt);
               x:=xc;xx:=xc;y:=yc;yy:=yc;
               x_:=xc+round(iprarray[0]*gripr.koef);
               y_:=yc+round(dtarray[0]*grt.koef);
               with diagBitt do begin
               line(xc+round(iprarray[imn]*gripr.koef),
                    yc+round(dtarray[imn]*grt.koef),
                    xc+round(x0*gripr.koef),
                    yc+round(y0*grt.koef) );
               line(xc+round(iprarray[imx]*gripr.koef),
                    yc+round(dtarray[imx]*grt.koef),
                    xc+round(x0*gripr.koef),
                    yc+round(y0*grt.koef) );
               end;

               x_:=xc+round(iprarray[0]*gripr.koef);
               y_:=yc+round(dtarray[0]*grt.koef);
               for i:=0 to 360 do
               begin
               xo:=x_;yo:=y_;
               x_:=xc+round(iprarray[i]*gripr.koef);
               y_:=yc+round(dtarray[i]*grt.koef);
               line(x_,y_,xo,yo);
               if x>x_ then x:=x_;
               if xx<x_ then xx:=x_;
               if y>y_ then y:=y_;
               if yy<y_ then yy:=y_;
               end;
          end;
          end;






type qw=array[0..10,0..10]of integer;
var a:array[1..3]of record x,y:integer;s:qw end;
procedure risgrext2(color:integer);
          procedure getimage_(x,y:integer;var q:qw);
                    var i,j:integer;
                    begin
                    for i:=0 to 8 do
                    for j:=0 to 8 do
                    q[i,j]:=getpixel(i+x-4,j+y-4);
                    end;
          procedure putimage_(x,y:integer;var q:qw);
                    var i,j:integer;
                    begin
                    for i:=0 to 8 do
                    for j:=0 to 8 do
                    putpixel(i+x-4,j+y-4,q[i,j]);
                    end;
          procedure cir(x,y,c,n:integer);
                    begin
                    if n<= 3 then
                    putimage_(a[n].x,a[n].y,a[n].s)else n:= n-3;
                    getimage_(x,y,a[n].s);
                    a[n].x:=x;
                    a[n].y:=y;
                    circle(x,y,3);
                    end;
          var i:integer;x_,y_,xo,yo:integer;
          begin
          if ris.T then
          with grT do begin
               writetextxy(xc,yc,1,name);
               cir(xc+round(normfi2pi(curf-nachf)*grBitt.koef),
               round(yc+dtarray[round(normfi2pi(curf-nachf)*180/pi)]*koef),color,1+wqeriuy);
          end;
          if ris.ipr then
          with gripr do begin
               writetextxy(xc,yc,1,name);
               cir(xc+round(normfi2pi(curf-nachf)*grBitt.koef),
               yc+round(iprarray[round(normfi2pi(curf-nachf)*180/pi)]*koef),color,2+wqeriuy);
          end;
          if ris.bitt then
          with grBitt do begin
               writetextxy(xc,yc,1,name);
               with diagBitt do begin
               cir(xc+round(iprarray[round(normfi2pi(curf-nachf)*180/pi)]*gripr.koef),
               round(yc+round(dtarray[round(normfi2pi(curf-nachf)*180/pi)]*grt.koef)),color,3+wqeriuy);
          end;
          end;
          wqeriuy:=0;
          end;











function  str8(a:real):string;var s:string;begin system.str(a:8:3,s);str8:=s;end;
procedure ot4et;
          var f:text;I:BYTE;fii:real;
          begin
          assign(f,'report.txt');
          rewrite(f);
          writeln(f,'     ДИНАМИЧЕСКИЙ АНАЛИЗ РЫЧАЖНОГО МЕХАНИЗМА No. 2.');
          WITH ustanovky do
          writeln(f,'СТУДЕНТ ГРУППЫ ',gruppa,' ',family,', вариант ',variant);
          writeln(f);
          writeln(f,'                   PAЗMEPЫ MEXAHИЗMA (метры):');
          writeln(f,'       H      CD      SM      AB     AS1     CS3 ');
          WITH ustanovky do
          writeln(f,str8(h),str8(cd),str8(sm),str8(l1),str8(as1),str8(cs3));
          writeln(f);
          writeln(f,'            МАССЫ ЗВЕНЬЕВ (КГ):');
          writeln(f,'      M1      M2      M3      M4      M5');
          FOR I:=1 TO 5 DO
          WRITE(F,str8(ustanovky.M[I]));
          writeln(f);
          writeln(f);
          writeln(f,'       ИНЕРЦИОННЫЕ ПАРАМЕТРЫ МЕХАНИЗМА (кг.м^2):');
          writeln(f,'     JS1     JS2     JS3     JS4');
          FOR I:=1 TO 4 DO
          WRITE(F,str8(ustanovky.JS[I]));
          writeln(f);
          writeln(f);
          writeln(f,'     PM      Wcp      б ');
          writeln(f,'    (кН)    (Гц)     (-)');
          WITH ustanovky do
          writeln(f,str8(pm),str8(WCP),str8(DELTA));
          writeln(f);
          writeln(f);
          writeln(f,'                   ПАРАМЕТРЫ ДИНАМИЧЕСКОЙ МОДЕЛИ:');
          writeln(f,'    Принятые обозначения:');
          writeln(f,'     No.      FI      VE      PC      MC       T        Iпр');
          FOR I:=0 TO 12 DO begin
          fii:=normfi2pi(i*360/12*pi/180+nachf);
          makePLl(normfipi(fii));
          makePLv;
          WRITELN(F,'    ',I:2,'  ',str8(fii*180/pi),str8(sign(normfipi(fi(plv.d43.v)+pi/2))*modul(plv.d43.v)),
                           str8(pc),str8(mc),str8(dtarray[i*360div 12]),ipr:11:2);
          end;
          writeln(f,'       ПРИВЕДЕННЫЙ МОМЕНТ СИЛ ДВИЖУЩИХ    MDv =  ',str8(-mdv),' Н.м');


                       {
       1       1       1       1       1       1       1

          writeln(f,'
  MPC - приведенный момент сил сопротивления;
   MP - приведенный (избыточный) момент сил;
  DJP - переменная составляющая привед. момента инерции механизма;
  No.   FI      PC        MPC       MP      DJP
   -   град.     Н        Н.м       Н.м    кг.м^2
   1   72.75     .600   -29.661   -48.412 18.330
   2  102.75     .700    58.315    39.563 20.048
   3  132.75     .800   135.180   116.428 23.271
   4  162.75     .900   181.158   162.406 25.964
   5  192.75    1.000   184.398   165.647 26.184
   6  222.75     .400   144.952   126.201 23.767
   7  252.75     .300    71.398    52.646 20.473
   8  282.75     .200   -16.597   -35.349 18.451
   9  312.75     .100   -96.533  -115.285 18.442
  10  342.75     .000  -148.302  -167.054 19.343
  11   12.75     .000  -152.726  -171.477 19.443
  12   42.75     .000  -106.562  -125.314 18.563
  13   72.75     .600   -29.661   -48.413 18.330
       ПРИВЕДЕННЫЙ МОМЕНТ СИЛ ДВИЖУЩИХ    MD =  -18.752 Н.м

          ЭНЕРГЕТИЧЕСКИЕ И КИНЕМАТИЧЕСКИЕ ПАРАМЕТРЫ МАШИНЫ:
    Принятые обозначения:
    ASS - работа сил сопротивления;
     DT - приращение кинетической энергии механизма;
     OM - угловая скорость вращения входного звена;
     DOM - приращение угловой скорости вращения входного звена;
     N1 - частота вращения входного звена;
     EP - угловое ускорение входного звена.
  No.   FI       ASS        DT       OM      DOM       N1      EP
   -   град.    джоуль    джоуль    рад/с    рад/с   об/мин  рад/с^2
   1   72.75      .000      .000   16.755    .000   160.000  -5.213
   2  102.75     7.502    -2.317   16.423   -.333   156.825 -14.942
   3  132.75    58.158    38.522   15.908   -.847   151.914 -14.682
   4  162.75   140.975   111.520   15.569  -1.187   148.669  -4.480
   5  192.75   236.678   197.404   15.644  -1.111   149.389   9.152
   6  222.75   322.901   273.810   16.133   -.622   154.062  19.516
   7  252.75   379.542   320.632   16.782    .026   160.252  18.952
   8  282.75   393.889   325.160   17.182    .427   164.076   5.586
   9  312.75   364.271   285.724   17.130    .375   163.578  -7.601
  10  342.75   300.174   211.808   16.850    .095   160.910  -8.470
  11   12.75   221.365   123.181   16.710   -.045   159.566   -.348
  12   42.75   153.484    45.481   16.773    .018   160.170   2.518
  13   72.75   117.820      .000   16.755    .000   160.000  -5.213
       КОЭФФИЦИЕНТ НЕРАВНОМЕРНОСТИ ДВИЖЕНИЯ    DELTR = .09853
  Максим. значение частоты вращ. глав. вала (об/мин) NMAX = 164.076
  Миним.  значение частоты вращ. глав. вала (об/мин) NMIN = 148.669
  Среднее значение частоты вращ. глав. вала (об/мин)  NSR = 156.372
          {}

          close(f);
          end;


procedure writetextxy(xc,yc,c:integer;name:textxy);
          var s:word;
          begin
          if c=fon_c then c:=fon_c1 else c:=name.c;
          s:=getcolor;
          setcolor(c);
          outtextxy(xc+name.x,yc+name.y,name.s);
          setcolor(s);
          end;

procedure nach;
          var f:text;
          begin
          mdv:=0;
          dfi:=0.01;
          OldExit := ExitProc;
          ExitProc:=@Quit;
          h:=130.0;
          sm:=100.0;
          cd:=200.0;
          l1:=sm*h/2/cd;
          PLlris.xcm:=100;
          PLlris.ycm:=200;
          PLlris.name.c:=name_c;
          PLlris.name.x:=0;
          PLlris.name.y:=-80;
          PLlris.name.s:='План механизма';
          PLvris.xcm:=500;
          PLvris.ycm:=200;
          PLvris.name:=PLlris.name;
          PLvris.name.s:='План скоростей';
          PLaris.xcm:=500;
          PLaris.ycm:=320;
          PLaris.name:=PLlris.name;
          PLaris.name.s:='План ускорений';
          gripr.xc:=100;
          gripr.yc:=400;
          gripr.name:=PLlris.name;
          gripr.name.s:='График I приведенного';
          grT.xc:=300;
          grT.yc:=400;
          grT.name:=PLlris.name;
          grT.name.s:='График T';
          grBitt.xc:=300;
          grBitT.yc:=70;
          grBitt.name:=PLlris.name;
          grBitt.name.y:=-50;
          grBitt.name.s:='Диаграмма Виттенбауэра';
          PLlris.name.y:=-130;
          ris:=cris;
          assign(f,err_f);
          {$I-}Reset(F);{$I+}
          if IOResult = 0 then
            begin  Close(F);Erase(F);end;
          igraph;
          allfon;
          if ramk then ramka(20,70,310,370,ram_c);
          makePLl(2.8);obnovl;
          creatankets;
          end;






begin
nach;
repeat while a1.run(0)=27 do exexit;until proverka1;
repeat while a2.run(0)=27 do exexit;until proverka2;
repeat while a3.run(0)=27 do exexit;until true;
end.













 {end}
