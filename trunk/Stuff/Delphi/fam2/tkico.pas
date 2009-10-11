unit tkico;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus,ExtActns;

type
  tKicon = class(TFrame)
    Image1: TImage;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    open1: TMenuItem;
    delete1: TMenuItem;
    procedure delete1Click(Sender: TObject);
    procedure open1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    s:string;
    function assign(ss:string):boolean;
    procedure delete_;virtual;
    procedure open;virtual;
  end;

implementation

{$R *.dfm}

{$EXTERNALSYM ExtractAssociatedIcon}
function ExtractAssociatedIcon(hInst: HINST; lpIconPath: PChar;
  var lpiIcon: Word): HICON; stdcall; external 'shell32.dll' name 'ExtractAssociatedIconA';



function tKicon.assign;
var lp:word;tic:ticon;c:tcolor;
begin
assign:=false;

if not FileExists(ss) then exit;
try
s:=ss;
lp:=0;
tic:=ticon.Create;
tic.Handle:=ExtractAssociatedIcon(self.Handle,pchar(ss),lp);

Image1.Width := tIc.Width;
Image1.Height := tIc.Height;
Image1.Canvas.Brush.Color:=color;
Image1.Canvas.Rectangle(-1,-1,tIc.Width+1,tIc.Height+1);

Image1.Canvas.Draw(0,0,tIc);
if Length(ss)>19 then begin delete(ss,4,length(ss)-16);Insert('...',ss,4);end;
Label1.Caption:=ss;
tic.Free;
finally
assign:=true;
visible:=true;

end;
end;

procedure tKicon.delete1Click(Sender: TObject);
begin
delete_;
end;

procedure tKicon.delete_;
begin
Visible:=False;
end;

procedure tKicon.open1Click(Sender: TObject);
begin
open;
end;
procedure tKicon.open;
var o:TComponent; a,b,c,d:pchar;e:integer;
re:tfilerun;
begin
re:=TFileRun.Create(owner);
re.FileName:=s;
re.Parameters:='';

re.Execute;

end;

end.
