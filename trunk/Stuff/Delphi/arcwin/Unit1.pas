unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,unit2;

type

  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    h: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label8: TLabel;
    r2_: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    zpt:boolean;
function R1:real;
function R2:real;
function l1:real;
function l2:real;
function l3:real;
function l4:real;
  end;

var
  Form1: TForm1;

implementation

var error:boolean;
function StrToFloat2(const S: string): Extended;
var ss:string;
function ifff(var S: string):boolean;
var i :byte;k,g:boolean;
begin
ifff:=false;
if Length(s)=0 then exit;
g:=false;
k:=false;
if s[1]='-' then i:=2 else i:=1;
for i:=i to length(s) do
case s[i] of
'0'..'9':k:=true;
'.',',':if g then exit else begin g:=true;if form1.zpt then s[i]:=','else s[i]:='.'end;
else exit;
end;
ifff:=k;
end;
begin
ss:=s;
if ifff(ss) then
try
StrToFloat2:=StrToFloat(ss)
except
if not error then showmessage('Ошибка, проверьте данные');
error:=true;

end
else begin StrToFloat2:=0;
if not error then showmessage('Ошибка, проверьте данные');
error:=true;

end
end;

{$R *.dfm}
function tform1.r1:real; begin  r1:=strtofloat2(edit1.Text);end;
function tform1.r2:real; begin  r2:=strtofloat2(edit2.Text); end;
function tform1.l1:real; begin  l1:=strtofloat2(edit3.Text); end;
function tform1.l2:real; begin  l2:=strtofloat2(edit4.Text); end;
function tform1.l3:real; begin  l3:=strtofloat2(edit5.Text); end;
function tform1.l4:real; begin  l4:=strtofloat2(edit6.Text); end;


procedure TForm1.Button1Click(Sender: TObject);
function Sqrt(X: Extended): Extended;
        begin
        sqrt:=0;
        if x>=0 then begin sqrt:=system.sqrt(x); exit; end;
        if not error then showmessage('Ошибка, проверьте данные');
        error:=true;

        end;
begin
try
form1.h.Caption:=floattostrF(-l2+sqrt(sqr(r2)-sqr(l1-l3))-sqrt(sqr(r1)-sqr(l1+l3-l4)),ffGeneral,0,5);
form1.r2_.Caption:=floattostrF(sqrt(sqr(l1-l3)+sqr(l2+sqrt(sqr(r1)-sqr(l1+l3-l4)))),ffGeneral,0,5);
except
if not error then showmessage('Ошибка, проверьте данные');
error:=true;

end;
if not error then Form1.Button1.Visible:=false;

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
Button1.Visible:=true;
error:=false;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
FORM2.visible:=true;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
zpt:=false;
try
strtofloat('0.1');
except
zpt:=not zpt;
end;
end;

end.
