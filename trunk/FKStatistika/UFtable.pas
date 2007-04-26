unit UFtable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids, ras4et, uevents, Menus,Clipbrd;

type
  TFtable = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    cSum: TCheckBox;
    cAvg: TCheckBox;
    cSigma: TCheckBox;
    cV: TCheckBox;
    cm: TCheckBox;
    GroupBox2: TGroupBox;
    rSum: TCheckBox;
    rAvg: TCheckBox;
    rSigma: TCheckBox;
    rV: TCheckBox;
    rm: TCheckBox;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rVClick(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    notferst:boolean;
    procedure Settablename(const Value: string);
    function Gettablename: string;
    { Private declarations }
  public
    { Public declarations }
    x,y:integer;
    rename:procedure of object;
    property tablename:string read Gettablename write Settablename;
    procedure recols;
    function getTRtable: TRtable;
  end;


function FloatToStr(f:double):string;


implementation

{$R *.dfm}

function StrToFloat(s:string):double;
var i:integer;
begin
  Result:=0;
  if s='-' then exit;
  for i:=1 to length(s)do
    case s[i] of
      ',','.':s[i]:=floattostr(0.1)[2];
    end;
  Result:=sysutils.StrToFloat(s);
end;


function FloatToStr(f:double):string;
var i,j:integer;b,d:boolean; dot:char;
begin
  dot:=sysutils.floattostr(0.1)[2];
  Result:='inf';
  if f = infiniti then exit;
  Result:=sysutils.FloatToStr(f);
  b:=false;
  d:=false;
  j:=0;
  if pos('e',result)+ pos('E',result)<>0  then exit;
  for i:=1 to length(result) do
    begin
    if Result[i] in ['1'..'9']then b:= true;
    if Result[i] =dot then
      d:= true else
      if b then inc(j);
    if j=4 then
      begin
      SetLength(result,i);
      exit;
      end;

    end;

end;


procedure TFtable.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[1,0]:='“ÂÒÚ 1';
  StringGrid1.Cells[0,1]:='‘»Œ 1';
  StringGrid1.Cells[2,0]:='“ÂÒÚ 2';
  StringGrid1.Cells[0,2]:='‘»Œ 2';
  x:=1000;
  y:=1000;
end;

procedure TFtable.Edit1Change(Sender: TObject);
begin
  recols;
end;

procedure TFtable.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    begin
      StringGrid1.FixedCols:=0;
      StringGrid1.FixedRows:=0;
    end else
    begin
      StringGrid1.FixedCols:=1;
      StringGrid1.FixedRows:=1;
    end;
end;

procedure TFtable.recols;
function func(v:tvector;num:integer):Double;
begin
  case num of
    0:result:=v._sum;
    1:result:=v._SredArifm;
    2:result:=v._Sigma;
    3:result:=v._V;
    4:result:=v._m;
  end;
end;
var oldr,oldc,i,j,x___,y___:integer;m:TRtable;
const str_:array[0..4]of string = ('Sum','Avg','Sigma','V','m');
var  chbxARR:array[0..9] of TCheckBox ;
begin
  chbxARR[0]:=cSum;chbxARR[1]:=cAvg;chbxARR[2]:=cSigma;chbxARR[3]:=cV;chbxARR[4]:=cm;
  chbxARR[5]:=rSum;chbxARR[6]:=rAvg;chbxARR[7]:=rSigma;chbxARR[8]:=rV;chbxARR[9]:=rm;
  try
    oldr:= y+1;
    oldc:= x+1;

    x___:=StrToInt(Edit1.Text);
    y___:=StrToInt(Edit2.Text);
    if (x___<=1)or(y___<=1)or(x___>1000)or(y___>1000) then exit;
    x:=x___;
    y:=y___;
  except
  end;
  j:=0;
  x___:=0;y___:=0;
  for i:=0 to 9 do
    if chbxARR[i].Checked then
      if i<5 then inc(x___) else Inc(y___);
  StringGrid1.RowCount:=y+1+y___;
  StringGrid1.ColCount:=x+1+x___;
  for i:=oldr to y+1+y___ do
    for j:=0 to x+1+x___ do
      if j=0 then
        if i<y+1 then
          StringGrid1.Cells[j,i]:='‘»Œ '+IntToStr(j) else else
        StringGrid1.Cells[j,i]:='';
  for j:=oldc to x+1+x___ do
    for i:=0 to y+1+y___ do
      if i=0 then
        if j<x+1 then
          StringGrid1.Cells[j,i]:='“ÂÒÚ '+IntToStr(j) else else
        StringGrid1.Cells[j,i]:='';
  Application.ProcessMessages;
  y___:=y+1;
  x___:=x+1;
  m:=getTRtable;
  for i:=0 to 4 do
    if chbxARR[i].Checked then
    begin
      for j:=0 to y-1 do
        StringGrid1.Cells[x___,j+1]:=FloatToStr(func(m[j],i));
      StringGrid1.Cells[x___,0]:=str_[i];
      inc(x___);
    end;
  m:=m.getT;
  for i:=0 to 4 do
    if chbxARR[i+5].Checked then
    begin
      for j:=0 to x-1 do
        StringGrid1.Cells[j+1,y___]:=FloatToStr(func(m[j],i));
      StringGrid1.Cells[0,y___]:=str_[i];
      inc(y___);
    end;
  Tag:=Tag+1;
end;

function TFtable.getTRtable: TRtable;
var i,j:integer;s:string;  f:double;r:TRtable;
  nx,ny:TStringList;
begin
  notferst:=true;
  nx:=TStringList.Create;
  ny:=TStringList.Create;
  for j:=0 to x-1 do
    nx.Add(StringGrid1.Cells[j+1,0]);
  for i:=0 to y-1 do
    ny.Add(StringGrid1.Cells[0,i+1]);

  R:=TRtable.create(x,y,nx,ny);
 for j:=0 to x-1 do
    for i:=0 to y-1 do
      try
        s:=StringGrid1.Cells[j+1,i+1];
        if s='' then f:=0  else
        f:=StrToFloat(s);
        r[i][j]:=f;
      except
        r[i][j]:=0;
        if (StringGrid1.Col <> j +1) or (StringGrid1.Row <> i+1) then
        StringGrid1.Cells[j+1,i+1]:='';
      end;
  Result:=r;
end;

procedure TFtable.FormActivate(Sender: TObject);
begin
  if not notferst then Edit1Change(nil);
end;

procedure TFtable.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  recols;
end;

procedure TFtable.rVClick(Sender: TObject);
begin
  recols;
end;

procedure TFtable.Settablename(const Value: string);
begin
  edit3.Text := Value;
end;

function TFtable.Gettablename: string;
begin
  Result:=edit3.Text;
end;

procedure TFtable.Edit3Change(Sender: TObject);
begin
  if assigned(rename) then rename;
  Caption:=Edit3.Text;
  recols;
end;

procedure TFtable.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFtable.N1Click(Sender: TObject);
var ss,s:string;i,j,xx,yy:integer;
begin
  Application.ProcessMessages;
  s:=clipboard.AsText;
  i:=0;j:=0; xx:=StringGrid1.Col;yy:=StringGrid1.row;
  while length(s)<>0do
    begin
    case s[1] of
      #9:begin
        delete(s,1,1);
        StringGrid1.Cells[xx+i,yy+j]:=ss;
        inc(i);
        ss:='';
        end;
      #13:begin
        delete(s,1,1);
        StringGrid1.Cells[xx+i,yy+j]:=ss;
        i:=0;
        inc(j);
        ss:=''
        end;
      #10:delete(s,1,1);
      else
        begin
          ss:=ss+s[1];
          delete(s,1,1);
        end;
    end;
    end;



end;

end.
