uses crt,music;
var  text:ARRAY[0..100,0..159]of char absolute $b800:0;

const
     kirmode=2;
     ck=#10;{'';}
     cm='';
     ctrup='X';
     cx='˘';
     shir=77;
     vis=46;
     nx=1;
     ny=1;
     muxkrokmax=300;

type kl=(ch,be,lin,gran,test1,test2,trup,trup2);
     napr_=(lu,ld,rd,ru);
     napr__=(l,u,r,d,lu_,ld_,ru_,rd_,s);
     point=record x,y:byte;end;
     ugr=record s:string[20];l:word;z:byte;end;

var pole:array[0..shir,0..vis]of kl;
    mux,krok:array[0..muxkrokmax]of
                  record
                  x,y:byte;napr:napr_;
                  end;
    player: record
            x,y:byte;
            x0,y0:byte;
            n:napr__;
            zizn:byte;
            end;
    c4et:record sum,t,ter,rez:word; end;
    q:melody;playing,exit_:boolean;
    mnext:point;
    level,muxmax,krokmax:byte;
    OrigMode,c4et44:integer;
    chars:array[0..200] of char;
    n1,k1:byte;
    qx:boolean;cxx,savegg:napr__;

procedure out(x,y:integer;c:char;k:byte);
          begin
          text[y+ny,(x+nx)*2+1]:=char(k);
          text[y+ny,(x+nx)*2]:=c;
          end;















procedure outsc(x,y:byte;s:string;o:byte);
          var i:byte;
          begin
          for i:=1 to ord(s[0])do
          out(x-1+i,y,s[i],o);
          end;














procedure outs(x,y:byte;s:string);
          var i:byte;
          begin
          outsc(x,y,s,15);
          end;















function  ss(x:integer):string;
          var s:string;
          begin
          str(x,s);ss:=s;
          end;















function  sss(x:integer;a:byte):string;
          var s:string;
          begin
          str(x:a,s);sss:=s;
          end;















procedure qq;
          begin
          Q.create;
          Q.temp:=48;
          Q.plus(#53#6#51#6#49#6#46#1#46#3#49#3#51#3#51#6#49#6#49#6);
          Q.plus(#49#3#49#6#48#6#49#6#51#6#53#6#51#6#49#6#46#1#46#3);
          Q.plus(#49#3#51#3#51#6#49#6#49#6#49#3#51#6#49#6#51#6#53#6);
          Q.plus(#100#1#41#6#41#6#42#6#41#3#41#6#37#6#37#1#37#3#44#6);
          Q.plus(#42#6#41#6#39#3#37#6#37#3#39#3#37#6#41#6#100#6#41#6);
          Q.plus(#41#6#42#6#41#3#41#6#37#6#37#1#37#3#44#6#42#6#41#6);
          Q.plus(#39#3#37#6#37#3#39#6#39#6#39#3#37#6#41#6#100#6#41#3);
          Q.plus(#100#3#41#6#41#6#41#6#41#3#39#3#100#3#39#6#39#6#39#6);
          Q.plus(#39#3#37#3#100#3#41#6#34#3#36#6#37#6#41#6#100#6#41#6);
          Q.plus(#100#6#100#3#44#6#42#6#41#6#39#3#37#6#37#3);
          Q.play;
          end;




function  gettimes:longint;
          var h,m,s,c:word;
          begin
          dos.gettime(h,m,s,c);
          gettimes:=((h*60+m)*60+s);
          end;














procedure cf(x,y:byte);
          var c:char;
          begin
          case kirmode of
          1:if x mod 2=1 then c:='Õ' else
          if ((x div 2)+y)mod 2 =1  then c:=' 'else c:='À';
          2:if (x+y)mod 2 =1  then c:=' 'else c:='À';
          3:if (x+y)mod 2 =1  then c:='¡'else c:='¬';
          end;
          if pole[x,y] = trup then out(x,y,ctrup,4+7*16) else
          if pole[x,y] = trup2 then out(x,y,ctrup,2+7*16) else
             out(x,y,c,7*16);
          end;







procedure poleris;
          var i,j:byte;
          begin
          for i:=0 to shir do
          for j:=0 to vis do
          case pole[i,j] of
          ch:out(i,j,' ',7);
          be:cf(i,j);
          lin:out(i,j,cx,15);
          trup:out(i,j,ctrup,4+7*16);
          trup2:out(i,j,ctrup,2+7*16);
          end;
          if player.zizn<=10 then
          for i:=1 to player.zizn do
          out(3+i,vis+2,#3,4)
          else outsc(4,vis+2,#3+' '+ss(player.zizn)+'       ',4);
          out(4+player.zizn,vis+2,' ',7);
          out(3,vis+2,' ',7);
          outs(15,vis+2,'ìêéÇÖçú '+ss(level));
          outs(26,vis+2,'  Ñé çéÇéÉé äêéäéÑàãÄ éëíÄãéëú:');
          outs(59,vis+2,' ëóÖí:'+ss(c4et.sum));
          for i:=1 to muxmax do out(mux[i].x,mux[i].y,cm,9);
          for i:=1 to krokmax do out(krok[i].x,krok[i].y,ck,2);
          end;
















procedure gameover;
          var i,j:byte;ee:boolean;
          begin
          ee:=false;
          dec(player.zizn);
          for i:=0 to shir do
          for j:=0to vis do
          if pole[i,j]=lin then begin pole[i,j]:=ch;ee:=true;end;
          if ee then with player do
          begin
          x:=x0;
          y:=y0;
          end;
          player.n:=s;
          while keypressed do readkey;qx:=false;
          poleris;
          q.delay(1000);
          end;


procedure shifr(k:byte;var g);var a:byte absolute g;
          const oma:string=' ëÓ§† ´†ß†‚Ï çÖïéêéòé!!!';
          begin a:=a xor ord(oma[k mod (ord(oma[0])-1)]); end;
function  getsh(a:ugr):byte;
          var w:array[0..100]of byte absolute a;
          var i,g:byte;
          begin
          g:=0;
          for i:=0 to sizeof (ugr)-2 do
          g:=g xor (w[i]);
          getsh:=g;
          end;
procedure add10(s:string;l:word);
          var sv:ugr; p:array[0..11]of ugr;f:file of ugr;i,j,k:word;
          var w:array[0..10000]of byte absolute p;
          begin
          if s='' then exit;
          fillchar(p,sizeof(p),0);
          p[0].s:=s;p[0].l:=l;
          p[11].l:=0;
          assign(f,'xonix.dat');
          {$I-}reset(f);{$I+}
          if ioresult=0 then
          begin
          for i:=1 to 10 do
          if not eof(f)then read(f,p[i]);
          close(f);
          for i:=sizeof(p[0]) to 10*sizeof(p[0]) do
          shifr(i-sizeof(p[0]),w[i]);
          end;
          for j:=0 to 10 do
          for i:=1 to 11 do
          p[j].s[i]:=upcase(p[j].s[i]);
          for j:=0 to 10 do
          for i:=0 to 9 do
          if p[i].l<p[i+1].l then
          begin sv:=p[i];p[i]:=p[i+1];p[i+1]:=sv;end;
          for i:=0 to 10 do
          if p[i].s='' then
          for j:=i to 10 do p[j]:=p[j+1];
          repeat
          j:=0;
          for i:=0 to 9 do
          for k:=i+1 to 10 do
          if p[i].s<>'' then
          if (p[i].s=p[k].s) then
          for j:=k to 10 do p[j]:=p[j+1];
          until j=0;
          for i:=0 to 10 do
          p[i].z:=getsh(p[i]);
          for i:=0 to sizeof(p) do
          shifr(i,w[i]);

          rewrite(f);
          for i:=0 to 9 do
          write(f,p[i]);
          close(f);
          end;


procedure get10(var p:array of ugr);
          var w:array[0..10000]of byte absolute p;
          var f:file of ugr;i:word;
          begin
          fillchar(p,sizeof(p),0);
          assign(f,'xonix.dat');
          {$I-}reset(f);{$I+}
          if ioresult=0 then
          begin
          for i:=0 to 9 do
          begin {$i-}if not eof(f)then read(f,p[i]);{$i+}if ioresult<>0 then begin  close(f);erase(f); exit;end;end;
          close(f);
          for i:=0 to 10*sizeof(p[0]) do
          shifr(i,w[i]);
          for i:=0 to 9 do
          if p[i].z<>getsh(p[i]) then
          begin
          erase(f);
          TextMode(OrigMode);
          halt;
          end;
          end;
          end;

















function  getpole(x,y:integer):kl;
          begin
          if (x in [0..shir])and(y in [0..vis]) then getpole:=pole[x,y]else getpole:=gran;
          end;
















procedure creatkrok;
          begin
          if krokmax>=muxkrokmax then exit;
          inc(krokmax);
          with krok[krokmax] do
          repeat
          x:=random(shir+1);
          y:=random(vis+1);
          napr:=napr_(random(4));
          until (pole[x,y]=be) and
                ((getpole(x+1,y+1)=be) or(getpole(x-1,y+1)=be) or (getpole(x-1,y-1)=be) or (getpole(x+1,y-1)=be));
          end;








procedure creatmux;
          begin
          if muxmax>=muxkrokmax then exit;
          inc(muxmax);
          with mux[muxmax] do
          repeat
          x:=random(shir+1);
          y:=random(vis+1);
          napr:=napr_(random(4));
          until pole[x,y]=ch;
          end;









procedure createpole;
          var i,j:byte;
          begin
          for i:=0 to shir do
          for j:=0 to vis  do
          if(i in [3..shir-3])and(j in [2..vis-2])  then pole[i,j]:=ch else pole[i,j]:=be;
          muxmax:=0;
          krokmax:=0;
          end;











procedure next(var x,y:integer;n:napr_);
          begin
          case n of
          lu,ld:dec(x);
          ru,rd:inc(x);
          end;
          case n of
          lu,ru:dec(y);
          ld,rd:inc(y);
          end;
          end;









procedure end_;
          begin
           nosound;
           exit_:=true;
           outs(26-nx,20-ny,'Çõ  ïéíàíÖ Çõâíà? Ñ/ç ');
            case readkey of
               #13:exit;
               'Ñ','§','d','D','l','L':
                  begin
                    outs(20-nx,22-ny,'åéÜÖí ùíéí ìêéÇÖçú ÑéàÉêÄÖå??? Ñ/ç');
                    case readkey of
                         'n','N','≠','ç','y','Y':exit;
                    end;
                  end;
            end;
          exit_:=false;
          poleris;
          end;


procedure c9(x,y:byte);
          begin
          if pole[x,y]=be then out(x,y,'',4+7*16) else out(x,y,'',4);
          end;
















procedure ramka;
          var i:integer;
          begin

          for i:= -1 to shir+1 do
          case kirmode of
          1:if i mod 4 <>2 then out(i,-1,'Õ',7*16) else  out(i,-1,'À',7*16);
          2:if i mod 2 =0 then out(i,-1,'Õ',7*16) else  out(i,-1,'À',7*16);
          3:if i mod 2 =0 then out(i,-1,'ƒ',7*16) else  out(i,-1,'¬',7*16);
          end;

          for i:= -1 to shir+1 do
          case kirmode of
          1:if (i+2) mod 4 <>((vis +1)mod 2)*2 then out(i,vis+1,'Õ',7*16) else  out(i,vis+1,' ',7*16);
          2:if i mod 2 =(vis +1)mod 2 then out(i,vis+1,'Õ',7*16) else  out(i,vis+1,' ',7*16);
          3:if i mod 2 =(vis +1)mod 2 then out(i,vis+1,'ƒ',7*16) else  out(i,vis+1,'¡',7*16);
          end;

          for i:= -1 to vis+1 do
          case kirmode of
          1,2:out(-1,i,'Ã',7*16);
            3:out(-1,i,'√',7*16);
          end;
          for i:= -1 to vis+1 do
          case kirmode of
          1,2:out(shir+1,i,'π',7*16);
            3:out(shir+1,i,'¥',7*16);
          end;
          case kirmode of
          1,2:begin out(-1,-1,'…',7*16);out(-1,vis+1,'»',7*16);out(shir+1,vis+1,'º',7*16);out(shir+1,-1,'ª',7*16);  end;
            3:begin out(-1,-1,'⁄',7*16);out(-1,vis+1,'¿',7*16);out(shir+1,vis+1,'Ÿ',7*16);out(shir+1,-1,'ø',7*16);  end;
          end;


          end;





procedure xodkrok;
          var i:byte;xn,yn:integer; a:byte;
          begin
          for i:=1 to krokmax do with krok[i]do begin
          xn:=x;
          yn:=y;
          next(xn,yn,napr);
          if (getpole(xn,yn)<>be)and(getpole(xn,yn)<>trup) then
              begin
              a:=0;
              xn:=x;
              yn:=y;
              next(xn,yn,napr_((byte(napr)+1)mod 4));
              if (getpole(xn,yn)<>be)and(getpole(xn,yn)<>trup) then a:=a+1;
              xn:=x;
              yn:=y;
              next(xn,yn,napr_((byte(napr)+3)mod 4));
              if (getpole(xn,yn)<>be)and(getpole(xn,yn)<>trup) then a:=a+2;
              case a of
              0,3:napr:=napr_((byte(napr)+2)mod 4);
              1:napr:=napr_((byte(napr)+3)mod 4);
              2:napr:=napr_((byte(napr)+1)mod 4);
              end;
              xn:=x;
              yn:=y;
              next(xn,yn,napr);
              end;
          if (xn=player.x)and(yn=player.y)then gameover;
          cf(x,y);
          x:=xn;y:=yn;
          out(x,y,ck,2);
          if pole[x,y]=trup then
             begin
             pole[x,y]:=trup2;
             krok[i]:=krok[krokmax]; dec(krokmax);
             poleris;
             end;
          end;
          end;

function  getnext(a:point;n:napr__):kl;
          var c:point;
          begin
          c:=a;
          with c do
          case n of
            l:dec(x);
            r:inc(x);
            u:dec(y);
            d:inc(y);
            lu_:begin dec(x);dec(y)end;
            ru_:begin inc(x);dec(y)end;
            ld_:begin dec(x);inc(y)end;
            rd_:begin inc(x);inc(y)end;

            end;
            mnext:=c;
            getnext:=pole[c.x,c.y];
          end;

procedure test_(a:point);
          const max=shir*vis;
          var o:array[0..max]of point;
              n,k:integer;i,j,qq:byte; w:boolean;
              b:point;
          procedure get(var a:point);
                    begin
                    if n mod 200= 0 then
                    q.delay(0);
                    inc(n);
                    if n=max then n:=0;
                    a:=o[n];
                    end;
          procedure add(a:point);
                    begin
                    if pole[a.x,a.y]<>ch then exit;
                    inc(k);
                    if (k<n) and (abs(k-n)<40) then halt(1);
                    if k=max then k:=0;
                    o[k]:=a;
                    pole[a.x,a.y]:=test1;
                    end;
          begin
          n:=0;
          k:=0;
          add(a);
          while n<>k do
          begin
          get(b);

          for qq:=byte(l) to byte(rd_) do
              begin
              getnext(b,napr__(qq));
              add(mnext);
              end;
          end;
          w:=true;
          for i:=1 to muxmax do
          if getpole(mux[i].x,mux[i].y)=test1 then w:=false;
          for i:=0 to shir do
          for j:=0 to vis do
          if getpole(i,j)=test1 then
             case w of
             true:begin pole[i,j]:=be;cf(i,j);end;
             false:pole[i,j]:=test2;
             end;
          end;













procedure testend;
          var i,j:byte;
          begin
          for i:=0 to shir do
          for j:=0 to vis do
          if getpole(i,j)=test2 then pole[i,j]:=ch;
          c9(player.x,player.y);
          q.delay(1000);

          end;










procedure xodmux;
          var i:byte;xn,yn:integer; a:byte;aa:point;
          begin
          for i:=1 to muxmax do
          with mux[i]do
          begin
          xn:=x;
          yn:=y;
          next(xn,yn,napr);
          if getpole(xn,yn)=be then
              begin
              a:=0;
              xn:=x;
              yn:=y;
              next(xn,yn,napr_((byte(napr)+1)mod 4));
              if getpole(xn,yn)=be then a:=a+1;
              xn:=x;
              yn:=y;
              next(xn,yn,napr_((byte(napr)+3)mod 4));
              if getpole(xn,yn)=be then a:=a+2;
              xn:=x;
              yn:=y;
              next(xn,yn,napr_((byte(napr)+2)mod 4));
              if getpole(xn,yn)=be then a:=a+4;
              case a of
              0,3:napr:=napr_((byte(napr)+2)mod 4);
              1,5:napr:=napr_((byte(napr)+3)mod 4);
              4,2,6:napr:=napr_((byte(napr)+1)mod 4);
              7: begin
                 aa.x:=x;aa.y:=y;
                 mux[i]:=mux[muxmax];
                 dec(muxmax);
                 inc(player.zizn);
                 pole[aa.x,aa.y]:=be;
                 inc(aa.x);test_(aa);
                 dec(aa.x,2);test_(aa);
                 inc(aa.x);inc(aa.y);test_(aa);
                 dec(aa.y,2);test_(aa);
                 inc(aa.y);
                 testend;
                 pole[aa.x,aa.y]:=trup;
                 poleris;
                 continue;
                 end;
              end;

              xn:=x;
              yn:=y;
              next(xn,yn,napr);

              end;

          if (not ((xn=player.x)and(yn=player.y)))and(getpole(xn,yn)=lin) then gameover;
          case getpole(x,y) of
          ch:out(x,y,' ',7);
          be:cf(x,y);
          lin:out(x,y,cx,15);
          end;
          x:=xn;y:=yn;
          out(x,y,cm,9);

          end;
          end;

















procedure testq(a:point;q:boolean);
          var sw:byte;w:boolean;i,j:byte;
          begin
          pole[a.x,a.y]:=test1;
          for sw:=0 to 3 do
          if getnext(a,napr__(sw))=ch then testq(mnext,false);
          if q then
             begin w:=true;
             for i:=1 to muxmax do
             if getpole(mux[i].x,mux[i].y)=test1 then w:=false;
             for i:=0 to shir do
             for j:=0 to vis do
             if getpole(i,j)=test1 then
                case w of
                true:begin pole[i,j]:=be;cf(i,j);end;
                false:pole[i,j]:=test2;
                end;
             end;
          end;

procedure newgame;
          var i:byte;
          begin
          c4et.t:=gettimes;c4et.ter:=0;c4et.rez:=0;
          c4et44:=gettimes;
          inc(level);
          createpole;
          muxmax:=0;
          krokmax:=0;
          for i:=1 to 2+level do
          creatmux;
          for i:=0 to (level div 2 )do
          creatkrok;
          player.x:=shir div 2;
          player.y:=1;
          player.n:=s;
          player.zizn:=10;
          poleris;
          end;

procedure c4ett;
          function c(p:word):string;
                   begin
                   c:='Æ¢';
                   if (p div 10)mod 10 <> 1 then
                   case p mod 10 of
                   1:c:='  ';
                   2,3,4:c:='a ';
                   end;
                   end;
          {chet:record t,ter,rez:word; end;}
          var utog,rez,i,j:word;
          begin
          with mux[1] do
          if getpole(x+1,y+1)=be then
          if getpole(x-1,y+1)=be then
          if getpole(x-1,y-1)=be then
          if getpole(x+1,y-1)=be then
          begin
          inc(player.zizn);
          pole[x,y]:=trup;
          dec(muxmax);
          end;
          poleris;
          c9(player.x,player.y);
          q.delay(1500);
          for i:=1 to shir do
          for j:=1 to vis do
          if pole[i,j]=ch then inc(c4et.ter);
          c4et.ter:=(((shir*vis)div 10 )-c4et.ter) div 3;
          c4et.t:=round(10000.0*level/word(gettimes-c4et.t));
          rez:=(level*200*(level+2))div c4et.rez;
          utog:=player.zizn*10+rez+c4et.ter+c4et.t;
          c4et.sum:=c4et.sum+utog;
for i:=28 to 48 do
for j:=19 to 32 do
c9(i,j);

i:=30;j:=20;
inc(j);          outs(i,j,'Ç†Ë® ÆÁ™®:       ');
inc(j);          outs(i,j,'-----------------');
inc(j);          outs(i,j,#3'x10     =   '+sss(player.zizn*10,4));
inc(j);          outs(i,j,ss(c4et.rez)+' ‡•ß'+c(c4et.rez)+'     ');
                 outs(i+9,j,'=   '+sss(rez,4));
inc(j);          outs(i,j,'°Æ≠„·    =   '+sss(c4et.ter,4));
inc(j);          outs(i,j,'¢‡•¨Ô    =   '+sss(c4et.t,4));
inc(j);          outs(i,j,'-----------------');
inc(j);          outs(i,j,'àíéÉé    =  '+sss(utog,5));
inc(j);          outs(i,j,'-----------------');
inc(j);          outs(i,j,'ëìååÄ    =  '+sss(c4et.sum,5));

          while keypressed do readkey;if readkey=#0 then readkey;
          newgame;
          end;






procedure cllose;
          var a:array[0..shir*vis]of point;
              i,j:byte;ai:integer;sw:byte;
          begin
              while keypressed do readkey;qx:=false;
              inc(c4et.rez);
              c4et44:=gettimes;
              ai:=0;
              for i:=0 to shir do
              for j:=0 to vis  do
              if getpole(i,j)=lin then
                 begin
                 a[ai].x:=i;
                 a[ai].y:=j;
                 pole[i,j]:=be;
                 cf(i,j);
                 inc(ai);
                 end;
              for i:=0 to ai-1 do
                 with a[i]do
                 for sw:=0 to 7 do
                 if getnext(a[i],napr__(sw))=ch then test_(mnext);
              testend;
              ai:=0;
              for i:=0 to shir do
              for j:=0 to vis  do
              if pole[i,j]=ch then inc(ai);
              if ai/shir/vis<0.1 then c4ett;
              player.n:=s;
          end;










procedure xodja;
          function gget:napr__;
                   var gg:napr__;
                   function gget2:napr__;
                            begin
                            if keypressed then
                               case readkey of
                                's','S': begin
                                         if playing then q.stop else q.play;
                                         playing:=not playing;
                                         end;
                               #27:gget2:=ru_;
                               #0:case ord(readkey) of
                                       77: gget2:=r;
                                       75: gget2:=l;
                                       80: gget2:=d;
                                       72: gget2:=u;
                                       else gget2:=s;
                                       end;
                               else gget2:=s;
                               end
                               else gget2:=lu_;
                            end;
                   function gget1:napr__;
                            begin
                            gget1:=savegg;
                            qx:=false;
                            end;

                   procedure gget3(a:napr__);
                             begin
                             savegg:=lu_;
                             while keypressed  do
                             begin
                                case readkey of
                                's','S': begin
                                         if playing then q.stop else q.play;
                                         playing:=not playing;
                                         end;
                                #27:savegg:=ru_;
                                #0:case ord(readkey) of
                                        77: savegg:=r;
                                        75: savegg:=l;
                                        80: savegg:=d;
                                        72: savegg:=u;
                                        else savegg:=s;
                                        end;
                                else savegg:=s;
                                end;
                             if a<>savegg then begin qx:=true;break end;

                             end;

                             end;
                   begin
                   if qx then gg:=gget1 else gg:=gget2;
                   gget3(gg);
                   gget:=gg;
                   end;
          var xn,yn:integer;aab,aaa:boolean;
          begin
          aab:=false;
          with player do
          begin
          cxx:=gget;
          case cxx of
          r,l,d,u,s:n:=cxx;
          ru_:end_;
          end;

          xn:=x; yn:=y;
          aaa:=false;
          case n of
               s:;
               l:dec(xn);
               r:inc(xn);
               u:dec(yn);
               d:inc(yn);
               end;
          case getpole(xn,yn)of
          gran :begin
                xn:=x;
                yn:=y;
                n:=s;
                end;
          ch:   if getpole(x,y)=be then
                begin
                pole[xn,yn]:=lin;
                cf(x,y);
                x0:=x;
                y0:=y;
                end else
                begin
                pole[xn,yn]:=lin;
                out(x,y,cx,15);
                end;

          be,trup,trup2: if getpole(x,y)=lin then
                begin

                out(x,y,cx,15);
                aab:=true;
                end else
                begin
                cf(x,y);
                end;
          lin:  if n<>s then begin out(x,y,' ',7);aaa:=true;end;

          end;


          x:=xn;y:=yn;
          if aaa then gameover;
          if aab then cllose;
          c9(x,y);
          end;

          end;


procedure game;
          var s:string;
          begin
          c4et.sum:=0;
          exit_:=false;
          while not exit_ and(player.zizn<>0)do
          begin
          q.delay(2000 div (9+level));
          if word(gettimes-c4et44)>600 div(9+level) then
             begin
             creatkrok;
             c4et44:=gettimes;
             end;
          outs(57,vis+2,ss((600 div(9+level)-word(gettimes-c4et44)))+' ');
          xodja;
          xodmux;
          xodkrok;
          end;
          q.stop;
          if c4et.sum=0 then exit;
           clrscr;
           gotoxy(40,25);
          write('èêÖÑëíÄÇíÖëú:');readln(s);
          add10(s,c4et.sum);
          end;















procedure logo;
          function sop(s:string;a:byte):string;
                    var ss:string;
                    begin
                    ss:=s;

                    ss[0]:=char(a);
                    for a:=a downto ord(s[0])+1 do ss[a]:=' ';
                    sop:=ss;
                    end;

          var p:array[0..10]of ugr;i:byte;
          begin
          while true do
          begin
          get10(p);
          clrscr;
          gotoxy(80,50);
          outs(50,25,'ãìóòàE');
          for i:=0 to 9 do
          if p[i].l<>0 then
          outs(40,26+i,sop(p[i].s,20)+sss(p[i].l,6));

{-----------------------------------------áÄêÄçÖÖ ÅãÄÉéÑÄêÖç-----------------}
          outs(10,10,'áÑÖëú Ç ÑÄãúçÖâòÖå ÅìÑÖí LOGO-SCREEN');              { }
          outs(10,12,'(ãûÑààà!!! ·™†¶®‚•, ØÆ¶†´„©·‚†, å†Ë•, ');              { }
          outs(10,14,'  Á‚Æ  Ø‡ÆÊ•§„‡† ≠†ßÎ¢†•‚·Ô logo)');                 { }
          outsc(10,20,'çÄóçÖå àÉêì ? Ñ/ç',15+8*16);                        { }
                                                                           { }
{----------------------------------------------------------------------------}
          CASE readkey of
          'n','N','≠','ç','y','Y',#27:exit;
          end;
          level:=0;
          newgame;
          ramka;
          game;
          end;
          end;

procedure nach;
          begin
          playing:=true;
          qq;
          n1:=0;
          k1:=0;
          c4et.sum:=0;
          OrigMode := LastMode;      { Remember original mode }
          TextMode(C80 + Font8x8);
          randomize;
          clrscr;
          gotoxy(80,50);
          logo;
          TextMode(OrigMode);
          end;





begin
{
add10('teol9',10);
add10('bral9',121);
add10('mah9',122);
add10('dyh9',13);
{}

nach;{}










end.