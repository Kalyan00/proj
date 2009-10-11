unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,calcw;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    c:expression;
    procedure ggg;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ggg;
var x,y,y_:doubleptr; xx,dx,y__:double;  color:integer;

procedure perebor(dx:double);
        begin
        c.str('0*(x+y+y_+1)+('+Edit1.Text+')');
        x:=c.getvar('x');
        y:=c.getvar('y');
        y_:=c.getvar('y_');
        x^:=StrToInt(Edit2.Text);
        y^:=StrToInt(Edit3.Text);
        y_^:=StrToInt(Edit4.Text);
        dx:=0.1;

        while (abs(x^)<900)  do
                begin
                // formula
                xx:=x^;
                y__:=c.result_;
                if (abs(x^)>1.0e5)or(abs(y^)>1.0e5)or(abs(y_^)>1.0e5) then exit;
                //-formula
                y_^:=y_^+dx*y__;
                y^:=y^+dx*y_^;
                x^:=xx+dx;
                canvas.Pixels[round(x^)+20,round(500-y^)]:=RGB(255,0,0);
                canvas.Pixels[round(y_^)+100,round(200-y__)]:=RGB(0,0,255);
                canvas.Pixels[round(y_^)+500,round(200-y^)]:=RGB(0,255,0);
                end;
                color:=color+63;
        end;
begin
//perebor(0.01);
//perebor(0.010000001);
perebor(0.01);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
color:=0;
Refresh;

if key=#27 then halt;
if key=#13 then ggg

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
c:=expression.Create;
end;

end.
