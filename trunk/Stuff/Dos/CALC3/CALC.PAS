{                                                                       }
{                                                                       }
{                                                                       }
{       ษออออออออออออออหอออออออออออออออออออออออออออออออออออออออป        }
{       บ   UNIT CALC  บ      MADE BY NIKOLAY KOLOMEYTSEV      บ        }
{       ฬออออออออออออออผ                                       บ        }
{       บ       €’…€’—…‘ €‘—…’ ’…‘’ ‘’         บ        }
{       บ                                         19.01.2004   บ        }
{       ศออออออออออออออออออออออออออออออออออออออออออออออออออออออผ        }
{                                                                       }
{                                                                       }
{ type expression= object                                               }
{    procedure str(s:string);                                           }
{    function  result:real;                                             }
{    function  getvar(s:string):realptr;                                }
{    function  strerror:string;                                         }
{    function  error:boolean;                                           }
{ end                                                                   }
{                                                                       }
{                                                                       }
{  mailto('kalyan00@yandex.ru');                                        }
{                                                                       }
{    ‘€…:                                                     }
{
     uses calc;
     var a:expression; x,y:realptr;

     begin
     a.str('(128.6+12)^-.3+sin(2*pi)+x/y');
     x:=a.getvar('x');
     y:=a.getvar('Y');
     x^:=18;
     y^:=9;
     writeln(a.result:0:3);
     y^:=0;
     writeln(a.result:0:3);
     if a.error then writeln(a.strerror);
     end.
{                                                                       }
{                                                                       }
{  enjoy & relax X-]                                                    }
unit calc;
INTERFACE
type errors=(norm,divzero,lnerr,tnerr,sqrterr,syntax,chars);
type varn__ =array[0..20]of string[10];
     vars__ =array[0..50]of real;
     typart=(tvar,treal,tsimb,tfunc);
     part_=record prev,next:byte;t:typart;
           case typart of
           tvar :(n:byte);
           treal:(r:real);
           tsimb:(c:char);
           tfunc:(f:byte);
           end;
     modelp=record f:boolean;n:byte;a,b,c:byte end;
     model_=array[0..50]of modelp;
type sss_=array[0..50]of part_;
     realptr=^real;



type expression= object
     procedure str(s:string);
     function  getvar(s:string):realptr;
     function  result:real;
     function  strerror:string;
     function  error:boolean;

     private
     err:errors;
     varlast:byte;
     vars:vars__;
     varn:varn__;
     sss:sss_;
     model:model_;
     modellast:byte;
     procedure cleen(var s:string);
     function  func(f:byte;a:real):real;
     function  getvar_(var s:string):byte;
     function  addvar(var s:string;rea:real):byte;
     function  getfunc(var s:string):byte;
     procedure killvars;
     procedure makemo_;
     procedure scobb;
     procedure step;
     procedure mul;
     procedure sum;
     procedure fun;
end;












implementation
function strtoreal(s:string):real;
         var i:byte;
             sign,rr,r:real;
             min,zpt:boolean;
         begin
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



const fmax=10;
const funcs:array [0..fmax]of string=('MOD','ABS','SQRT','SIN' ,'COS',
                                    'EXP','LN' ,'TN'  ,'ATAN','CTN','SIGN');
function  expression.error:boolean;begin error:=(err<>norm)end;
procedure expression.killvars;var s:string;begin varlast:=0;s:='E';addvar(s,exp(1));s:='PI';addvar(s,pi);end;
function  expression.strerror:string;
          begin
          case err of
          norm    :strerror:='';
          divzero :strerror:='คฅซฅญจฅ ญ  ญฎซ์';
          lnerr   :strerror:='ln(-x)  ';
          tnerr   :strerror:='tn(pi/2)';
          sqrterr :strerror:='sqrt(-x)';
          syntax  :strerror:='แจญโ ชแจแ';
          chars   :strerror:='กใชข๋';
          end;
          end;



procedure expression.cleen(var s:string);
          var i:byte;
          begin
          for i:=ord(s[0]) downto 1do
          case s[i] of
          'A'..'Z','_':;
          'a'..'z':s[i]:=upcase(s[i]);
          else delete(s,i,1);
          end;
          end;










function  expression.func(f:byte;a:real):real;
          begin
          case f of
{mod  }   0,1:func:=abs(a);
{abs  }
{sqrt }   2:if a>=0 then func:=sqrt(a) else begin err:=sqrterr;exit;end;
{sin  }   3:func:=sin(a);
{cos  }   4:func:=cos(a);
{exp  }   5:func:=exp(a);
{ln   }   6:if a>0 then func:=ln(a) else begin err:=lnerr;exit;end;
{tn   }   7:if cos(a)<>0 then func:=sin(a)/cos(a) else begin err:=tnerr;exit;end;
{atan }   8:func:=arctan(a);
{ctn  }   9:if sin(a)<>0 then func:=cos(a)/sin(a) else begin err:=tnerr;exit;end;
{sign }   10:if a>=0 then func:=1 else func:=-1;
          end;
          end;




function  expression.getvar(s:string):realptr;
          var i:byte;
          begin
          cleen(s);
          i:=varlast;
          if i>19 then i:=19;
          while i<>0 do if s=varn[i] then break else dec(i);
          getvar:=@vars[i];
          end;
function  expression.getvar_(var s:string):byte;
          var i:byte;
          begin
          i:=varlast;
          if i>19 then i:=19;
          while i<>0 do if s=varn[i] then break else dec(i);
          getvar_:=i;
          end;



function  expression.getfunc(var s:string):byte;
          var i:byte;
          begin
          cleen(s);
          i:=fmax;
          while i<>0 do if s=funcs[i] then break else dec(i);
          getfunc:=i;
          end;












function  expression.addvar(var s:string;rea:real):byte;
          var i:byte;
          begin
          cleen(s);
          i:=getvar_(s);
          addvar:=i;
          if i=0then
          begin
          inc(varlast);
          varn[varlast]:=s;
          vars[varlast]:=rea;
          addvar:=varlast;
          end else vars[i]:=rea;end;







procedure expression.scobb;
          var r,i,h,c,nach,kon:byte; ssss:sss_;
          begin
          nach:=0;
          kon:=0;
          c:=0;
          h:=0;
          i:=sss[0].next;
          while i<>0 do
              begin
              if sss[i].t=Tsimb then
              if sss[i].c='(' then inc(h) else
              if sss[i].c=')' then dec(h);
              if (h=1)and(c=0)then begin inc(c); nach:=sss[i].next end else
              if (h=0)and(c<>0)then break;
              i:=sss[i].next;
              end;
          kon:=sss[i].prev;
          if i<>0 then
          begin
          ssss:=sss;
          sss[0].next:=nach;
          sss[0].prev:=kon;
          sss[sss[0].next].prev:=0;
          sss[sss[0].prev].next:=0;
          makemo_;
          r:=sss[sss[0].next].n;
          sss:=ssss;
          nach:=sss[nach].prev;
          sss[nach].n:=r;
          sss[nach].t:=Tvar;
          sss[nach].next:=sss[sss[kon].next].next;
          sss[sss[sss[kon].next].next].prev:=nach;
          scobb;
          end;
          end;




procedure expression.step;
          var p,n,i:byte;
          begin
          i:=sss[0].prev;
          while i<>0 do
          begin
          if sss[i].t=Tsimb then if sss[i].c='^' then
          if (sss[sss[i].next].t<>tvar)and(sss[sss[i].prev].t<>tvar)  then
             err:=syntax else
          begin
             p:=sss[i].prev;
             n:=sss[i].next;
             inc(modellast);
             inc(varlast);
             if varlast<20 then;
             varn[varlast]:='___system#';
             model[modellast].f:=false;
             model[modellast].a:=varlast;
             model[modellast].b:=sss[p].n;
             model[modellast].c:=sss[n].n;
             model[modellast].n:=sss[i].n;
             sss[sss[p].prev].next:=n;
             sss[n].prev:=sss[p].prev;
             sss[n].n:=varlast;
          end;
          i:=sss[i].prev;
          end;
          end;












procedure expression.mul;
          var p,n,i:byte;
          begin
          i:=sss[0].next;
          while i<>0 do
          begin
          if sss[i].t=Tsimb then case sss[i].c of '*','/':
          if (sss[sss[i].next].t<>tvar)and(sss[sss[i].prev].t<>tvar)  then err:=syntax else
          begin
          p:=sss[i].prev;
          n:=sss[i].next;
          inc(modellast);
          inc(varlast);
          varn[varlast]:='___system#';
          model[modellast].f:=false;
          model[modellast].a:=varlast;
          model[modellast].b:=sss[p].n;
          model[modellast].c:=sss[n].n;
          model[modellast].n:=sss[i].n;
          sss[sss[p].prev].next:=n;
          sss[n].prev:=sss[p].prev;
          sss[n].n:=varlast;
          end;
          end;
          i:=sss[i].next;
          end;
          end;













procedure expression.sum;
          var p,n,i:byte;
          begin
          i:=sss[0].next;
          while i<>0 do
          begin
          if sss[i].t=Tsimb then case sss[i].c of '+','-':
          if (sss[sss[i].next].t<>tvar)and(sss[sss[i].prev].t<>tvar)  then err:=syntax else
          begin
          p:=sss[i].prev;
          n:=sss[i].next;
          inc(modellast);
          inc(varlast);
          varn[varlast]:='___system#';
          model[modellast].f:=false;
          model[modellast].a:=varlast;
          model[modellast].b:=sss[p].n;
          model[modellast].c:=sss[n].n;
          model[modellast].n:=sss[i].n;
          sss[sss[p].prev].next:=n;
          sss[n].prev:=sss[p].prev;
          sss[n].n:=varlast;
          end;
          end;
          i:=sss[i].next;
          end;
          end;













procedure expression.fun;
          var i:byte;
          begin
          i:=sss[0].prev;
          while i<>0 do begin
          if sss[i].t=tFunc then
          if sss[sss[i].next].t<>tvar then err:=syntax else
          begin inc(modellast);inc(varlast);
          varn[varlast]:='___system#';
          model[modellast].f:=true;
          model[modellast].a:=varlast;
          model[modellast].b:=sss[sss[i].next].n;
          model[modellast].n:=sss[i].n;
          sss[sss[i].prev].next:=sss[i].next;
          sss[sss[i].next].prev:=sss[i].prev;
          sss[sss[i].next].n:=varlast;
          end;
          i:=sss[i].prev; end;
          end;

procedure expression.makemo_;
          begin
          scobb;
          fun;
          step;
          mul;
          sum;
          end;












procedure expression.str(s:string);
          var ss2,ss:string;minus:boolean;i,o,k:byte;
          begin
          while pos(' ',s)<>0 do delete(s,pos(' ',s),1);
          killvars;
          minus:=false;
          i:=0;
          ss:=s;
          while ss[0]<>#0 do
          case ss[1] of
          '-','+','*','/','(',')','^':
              begin
              if (ss[1]='-') and (i<>0) and(sss[i].t=tsimb)then
              begin
              minus:=true; delete(ss,1,1);
              end else begin
              inc (i);
              sss[i].t:=tsimb;
              sss[i].prev:=i-1;
              sss[i].next:=i+1;
              sss[i].c:=ss[1];
              delete(ss,1,1);
              end;
              end;
          '0'..'9','.':
              begin
              inc (i);
              sss[i].t:=treal;
              sss[i].prev:=i-1;
              sss[i].next:=i+1;
              o:=1;
              while (ss[o] in ['0'..'9','.'] ) and (o<=ord(ss[0]))do inc(o);
              ss2:=ss;
              ss2[0]:=chr(o-1);
              sss[i].r:=strtoreal(ss2);
              if minus then sss[i].r:=-sss[i].r;
              minus:=false;
              delete(ss,1,o-1);
              end;
          'A'..'Z','a'..'z','_':
          begin
              inc (i);
              sss[i].t:=treal;
              sss[i].prev:=i-1;
              sss[i].next:=i+1;
              o:=1;
              while (ss[o] in ['A'..'Z','a'..'z','_'] ) and (o<=ord(ss[0]))do inc(o);
              ss2:=ss;
              ss2[0]:=chr(o-1);
              cleen(ss2);
              if getfunc(ss2)<>0 then
              begin
              sss[i].t:=tfunc;
              sss[i].f:=getfunc(ss2);
              end else
              if getvar_(ss2)<>0 then
              begin
              sss[i].t:=tvar;
              sss[i].n:=getvar_(ss2);
              end else
              begin
              sss[i].t:=tvar;
              sss[i].f:=addvar(ss2,0);
              end;
              delete(ss,1,o-1);
          end;
          else begin err:=chars;exit;end;
          end;
          sss[i].next:=0;
          sss[0].prev:=i;
          sss[0].next:=1;

          i:=sss[0].prev;
          while i<>0 do
          begin
          if sss[i].t=Treal then
          begin
          sss[i].t:=tvar;
          inc(varlast);
          varn[varlast]:='___system#';
          vars[varlast]:=sss[i].r;
          sss[i].n:=varlast;
          end;
          i:=sss[i].prev;
          end;
          modellast:=0;
          makemo_;
          end;












function  expression.result:real;
          var i:byte;
          begin
          i:=1;
          while i<=modellast do
          begin
          with model[i] do
          if f then vars[a]:=func(n,vars[b])else
               case chr(n) of
               '*':vars[a]:=vars[b]*vars[c];
               '/':if vars[c]<>0 then vars[a]:=vars[b]/vars[c] else err:=divzero;
               '+':vars[a]:=vars[b]+vars[c];
               '-':vars[a]:=vars[b]-vars[c];
               '^':if vars[b]>0 then vars[a]:=exp(vars[c]*ln(vars[b])) else err:=lnerr;
          end;inc(i);
          end;
          if modellast<>0 then
          result:=vars[model[modellast].a] else result:=vars[varlast];
          end;
end.