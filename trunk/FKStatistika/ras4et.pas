unit ras4et;

interface
uses sysutils, Graphics, classes;
const infiniti = 123456;

type tvector = class
  private
    Fitems:array of double;
    Fx: integer;
    Fname: string;
    function Getitems(i: integer): double;
    procedure Setitems(i: integer; const Value: double);
  public
    property name:string read Fname;
    property items[i:integer]:double read Getitems write Setitems; default;
    constructor create(x:integer;name:string);
    property x:integer read Fx;
    property n:integer read Fx;
    function _min:Double;
    function _max:Double;
    function _sum:double;
    function _SredArifm:double;
    function _Sigma:double;
    function _get3Sima:tvector;
    function _V:double; //коэфициент вариации
    function _m:double; //ошибка
  end;

TRtable = class
  private
    Fitems:array of Tvector;
    Fy: integer;
    Fx: integer;
    function Getitems(i: integer): tvector;
  public
    namex,namey:tstringlist;
    constructor create(x, y: integer; XName,YName:TStringList);
    property x:integer read Fx ;
    property y:integer read Fy ;
    property items[i:integer]:tvector read Getitems; default;
    function getT: trtable;
  end;

TKorel = class
  private
    bitmap:tbitmap;
    _x,_y:tvector;
    Fpirks:boolean;
    function getn: integer;
    function _rPirs:double; //линейный коэффициент коррел€ции
    function _rspirmen:double; //ранговый коэффициент коррел€ции
  public
    function _bitmap: tbitmap;
    constructor create(X,Y:tvector;pirks:boolean);
    property n:integer  read getn;
    function _r:double; //коэффициент коррел€ции
    function _D:double; //коэффициент детерминации
    function _rkrit(OO5:boolean):double;
    function _rxy_z(z:tvector):double;//частного коэффициента коррел€ции;
    function _t15:double; //t-критерий —тьюдента
    function _t16:double; //t-критерий дл€ св€звнных выборок
end;
  function _t(x1,x2:tvector): double;//t-критерий —тьюдента
  function _tkr(ChisStep:integer;OO5:boolean):double;
  (* ChisStep = x1+x2-2 дл€ двух групп (типа експериментальна€ и
                        контрольна€ или бегуны и акробаты)
     ChisStep = x-1     дл€ одной группы (типа до допинга и после)
  *)



implementation

{ TRtable }
const table13:array[0..23]of record n:integer; sp5,pir5,sp1,pir1:double end =
(
(n:4;  sp5:1;    pir5:0.95; sp1:1;    pir1:1),
(n:5;  sp5:0.9;  pir5:0.88; sp1:1;    pir1:0.96),
(n:6;  sp5:0.83; pir5:0.81; sp1:0.94; pir1:0.92),
(n:7;  sp5:0.71; pir5:0.75; sp1:0.9;  pir1:0.88),
(n:8;  sp5:0.64; pir5:0.71; sp1:0.83; pir1:0.83),
(n:9;  sp5:0.6;  pir5:0.67; sp1:0.78; pir1:0.8),
(n:10; sp5:0.57; pir5:0.63; sp1:0.74; pir1:0.76),
(n:11; sp5:0.54; pir5:0.6;  sp1:0.72; pir1:0.74),
(n:12; sp5:0.51; pir5:0.58; sp1:0.71; pir1:0.71),
(n:13; sp5:0.48; pir5:0.55; sp1:0.68; pir1:0.68),
(n:14; sp5:0.45; pir5:0.53; sp1:0.64; pir1:0.66),
(n:15; sp5:0.43; pir5:0.51; sp1:0.62; pir1:0.64),
(n:16; sp5:0.42; pir5:0.5;  sp1:0.6;  pir1:0.62),
(n:17; sp5:0.41; pir5:0.48; sp1:0.58; pir1:0.6),
(n:18; sp5:0.4;  pir5:0.47; sp1:0.56; pir1:0.59),
(n:19; sp5:0.39; pir5:0.46; sp1:0.54; pir1:0.58),
(n:20; sp5:0.38; pir5:0.44; sp1:0.53; pir1:0.56),
(n:21; sp5:0.37; pir5:0.43; sp1:0.51; pir1:0.55),
(n:22; sp5:0.36; pir5:0.42; sp1:0.5;  pir1:0.54),
(n:23; sp5:0.35; pir5:0.41; sp1:0.49; pir1:0.53),
(n:24; sp5:0.34; pir5:0.4;  sp1:0.48; pir1:0.52),
(n:25; sp5:0.33; pir5:0.39; sp1:0.47; pir1:0.51),
(n:30; sp5:0.3;  pir5:0.36; sp1:0.43; pir1:0.46),
(n:35; sp5:0.27; pir5:0.33; sp1:0.39; pir1:0.44));

const table14:array[0..31] of record n:integer;t5:double;t1:double end = (
(n:2;t5:4.3;t1:9.92),
(n:3;t5:3.18;t1:5.84),
(n:4;t5:2.78;t1:4.6),
(n:5;t5:2.57;t1:4.03),
(n:6;t5:2.45;t1:3.71),
(n:7;t5:2.37;t1:3.5),
(n:8;t5:2.31;t1:3.36),
(n:9;t5:2.26;t1:3.25),
(n:10;t5:2.23;t1:3.17),
(n:11;t5:2.2;t1:3.11),
(n:12;t5:2.18;t1:3.05),
(n:13;t5:2.16;t1:3.01),
(n:14;t5:2.14;t1:2.98),
(n:15;t5:2.13;t1:2.95),
(n:16;t5:2.12;t1:2.92),
(n:17;t5:2.11;t1:2.9),
(n:18;t5:2.1;t1:2.88),
(n:19;t5:2.09;t1:2.86),
(n:20;t5:2.09;t1:2.85),
(n:21;t5:2.08;t1:2.83),
(n:22;t5:2.07;t1:2.82),
(n:23;t5:2.07;t1:2.81),
(n:24;t5:2.06;t1:2.8),
(n:25;t5:2.06;t1:2.79),
(n:26;t5:2.06;t1:2.78),
(n:27;t5:2.05;t1:2.77),
(n:28;t5:2.05;t1:2.76),
(n:29;t5:2.05;t1:2.76),
(n:30;t5:2.04;t1:2.75),
(n:40;t5:2.02;t1:2.7),
(n:60;t5:2;t1:2.66),
(n:100000;t5:1.96;t1:2.58));

constructor TRtable.create(x, y: integer; XName,YName:TStringList);
var i:integer;
begin
  namex:=XName;
  namey:=YName;
  fx:=x;
  fy:=y;
  SetLength(Fitems,y);
  if YName<>nil then
    if YName.Count>y then
      begin
        for i:=0 to y-1 do
          Fitems[i]:=tvector.create(x,YName[i]);
        exit;
      end;
  for i:=0 to y-1 do
    Fitems[i]:=tvector.create(x,'');
end;




function TRtable.Getitems(i: integer): tvector;
begin
  if (i>=0)and (i<y) then
    result:=fitems[i] else
    raise exception.Create('TRtable.Getitems index out ...');
end;


function TRtable.getT: trtable;
var i,j:integer;
begin
  Result:=TRtable.create(y,x,namey,namex);
  for i:=0 to x-1 do
    for j:=0 to y-1 do
      Result[i][j]:=items[j][i];
end;

{ tvector }

constructor tvector.create(x:integer;name:string);
begin
  if x<2 then raise exception.Create('tvector.create(x<2)');
  fx:=x;
  SetLength(Fitems,x);
  self.fname:=name;
end;


function tvector.Getitems(i: integer): double;
begin
  if (i>=0)and (i<x) then
    result:=fitems[i] else
    raise exception.Create('tvector.Getitems index out ...');
end;

function tvector._SredArifm: double;
begin
  Result:=_sum/x;
end;

function tvector._sum: double;
var i:integer;
begin
  Result:=0;
  for i:=0 to x-1 do
    Result:=Result+items[i];
end;

procedure tvector.Setitems(i: integer; const Value: double);
begin
  if (i>=0)and (i<x) then
    fitems[i]:=value else
    raise exception.Create('tvector.setitems index out ...');
end;

function tvector._Sigma: double;
var i:integer;sr:double;
begin
  sr:=_SredArifm;
  Result:=0;
  for i:=0 to x-1 do
    Result:=Result+ (items[i]-sr)*(items[i]-sr);
  Result:=sqrt(Result/(x-1));

end;

function tvector._get3Sima: tvector;
var i,f:integer;s:double;
begin
  s:=3*_Sigma;
  f:=0;
  for i:=0 to x-1 do
    if abs(items[i])<=s then
      inc(f);
  Result:=tvector.create(f,name);
  f:=0;
  for i:=0 to x-1 do
    if abs(items[i])<=s then
      begin
      Result[f]:=items[i];
      inc(f);
      end;
end;

function tvector._V: double;
begin
  if _SredArifm<>0 then
  Result:=100*abs(_Sigma/_SredArifm)
  else
  Result:=infiniti;
end;

function tvector._m: double;
begin
  Result:=_Sigma/sqrt(x-1);
end;


function tvector._max: Double;
var i:integer;
begin
  Result:=items[0];
  for i:=0 to x-1 do
    if items[i]>Result then Result:=items[0];
end;

function tvector._min: Double;
var i:integer;
begin
  Result:=items[0];
  for i:=0 to x-1 do
    if items[i]<Result then Result:=items[0];
end;

{ TKorelGrafic }

constructor TKorel.create(X, Y: tvector;pirks:boolean);
begin
  Fpirks:=pirks;
  _x:=x;
  _y:=y;
  if y.n<>x.n then Raise Exception.Create('TKorel.create count{x}<>count{y}');
end;

function TKorel._bitmap:tbitmap;
var i:integer; minx,maxx,miny,maxy:double;size:integer;
begin
  Result:=bitmap;
  if bitmap<>nil then exit;
  minx:=_x._min;   if minx>0 then minx:=0;
  maxx:=_x._max;   if maxx<0 then maxx:=0;
  miny:=_y._min; if miny>0 then miny:=0;
  maxy:=_y._max; if maxy<0 then maxy:=0;
  if (maxx=minx)or(maxy=miny)then raise Exception.Create('_bitmap((maxx=minx)or(maxy=miny))');
  size:=100;
  bitmap:=TBitmap.Create;
  bitmap.Height:=size;
  bitmap.Width:=size;
  for i:=0 to n-1 do
    bitmap.Canvas.Pixels[
            round(10+(_x.items[i]-minx)*(size-20)/(maxx-minx)),
            round(10+(_y.items[i]-miny)*(size-20)/(maxy-miny))]:=clBlack;
  bitmap.Canvas.Rectangle(
            round(10+(0-minx)*(size-20)/(maxx-minx)),
            round(0),
            round(10+(0-minx)*(size-20)/(maxx-minx)),
            round(size)
            );
  bitmap.Canvas.Rectangle(
            round(0),
            round(10+(0-miny)*(size-20)/(maxy-miny)),
            round(size),
            round(10+(0-miny)*(size-20)/(maxy-miny))
            );
  Result:=bitmap;
end;

function TKorel.getn: integer;
begin
  Result:=_x.x;
end;

function TKorel._D: double;
begin
  Result:=_rPirs*_rPirs*100;
end;

function TKorel._r: double;
begin
  if Fpirks then Result:= _rPirs else Result:=_rspirmen;
end;

function TKorel._rkrit( OO5: boolean): double;
var i:integer;
begin
  Result:=1;
  for i:=0 to 23 do
    if (n<=table13[i].n)or(i=23) then
      begin
      if Fpirks then
        if OO5 then Result:=table13[i].pir5 else Result:=table13[i].pir1 else
        if OO5 then Result:=table13[i].sp5  else Result:=table13[i].sp1 ;
        break;
      end;
end;

function TKorel._rPirs: double;
var i:integer;x,y:Double;
begin
  x:=_x._SredArifm;
  y:=_y._SredArifm;
  result:=0;
  for i:=0 to n-1 do
    Result:=Result+(_x[i]-x)*(_y[i]-y);
  if (n*_x._Sigma*_y._Sigma)<>0 then
    Result:=Result/(n*_x._Sigma*_y._Sigma) else
    Result:=infiniti;

end;

function TKorel._rspirmen: double;
var i:integer;
begin
  Result:=0;
  for i:=0 to n-1 do
    Result:=Result+(_x[i]-_y[i])*(_x[i]-_y[i]);
  Result:=1-6*Result/(n*(n*n-1))
end;

function TKorel._rxy_z(z: tvector): Double;
var rxy,rxz,ryz:Double;
begin
  rxy:=self._r;
  rxz:=TKorel.create(_x,z,Fpirks)._r;
  ryz:=TKorel.create(_y,z,Fpirks)._r;
  if (1-rxz*rxz)*(1-ryz*ryz)<>0 then
    Result:=(rxy-rxz*ryz)/sqrt((1-rxz*rxz)*(1-ryz*ryz)) else
    Result:=infiniti;

end;



function _t(x1,x2:tvector): double;
begin
  if x1._m*x1._m+x2._m*x2._m <>0 then
    Result:=abs(x1._SredArifm - x2._SredArifm)/sqrt(x1._m*x1._m+x2._m*x2._m)
  else
    Result:=infiniti;

end;

function _tkr(ChisStep:integer;OO5:boolean):double;
var i:integer;
begin
  Result:=0;
  for i:=0 to 31 do
    if (table14[i].n>=ChisStep)or(i=31) then
      begin
        if OO5 then Result:=table14[i].t5 else Result:=table14[i].t1;
        break;
      end;
end;


function TKorel._t15: double;
begin
  Result:=_t(_x,_y);
end;

function TKorel._t16: double;
var i:integer;v:tvector;
begin
  v:=tvector.create(n,'');
  for i:=0 to n-1 do
    v[i]:=_x[i]-_y[i];
  if v._m<>0 then
    Result:=v._SredArifm/v._m else
    Result:=infiniti;
end;




end.
