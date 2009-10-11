unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,calc;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Image1: TImage;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    exp:expression;
    x,y:realptr;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
exp:=expression.Create;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
exp.Destroy;
end;

procedure TForm1.Button1Click(Sender: TObject);
var xi,yi:integer; z,z0:boolean; mx,my,ox,oy:real;
begin
exp.str(Edit1.Text);

  x:=exp.getvar('x');
  y:=exp.getvar('Y');

Image1.Canvas.Pen.Color:=0;
Image1.Canvas.Brush.Color:=0;
Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);

mx:=(StrToFloat(edit5.text)-StrToFloat(edit3.Text))/Image1.Width;
my:=-(StrToFloat(edit2.text)-StrToFloat(edit4.Text))/Image1.Height;
ox:=Image1.Width/2;
oy:=Image1.Height/2;


for xi:=0 to Image1.Width do
for yi:=0 to Image1.Height do
begin
x^:=(xi - ox)*mx;
y^:=(yi - oy)*my;

z:=exp.result >0;
if z<>z0 then Image1.Canvas.Pixels[xi,yi]:=rgb(255,225,225);

z0:=z;
end;
for yi:=0 to Image1.Height do
for xi:=0 to Image1.Width do
begin
x^:=(xi - ox)*mx;
y^:=(yi - oy)*my;

z:=exp.result >0;
if z<>z0 then Image1.Canvas.Pixels[xi,yi]:=rgb(255,225,225);

z0:=z;

end;
if exp.error then
Memo1.Lines.Add( exp.strerror);

{}
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
Button1.Click;
end;

end.
