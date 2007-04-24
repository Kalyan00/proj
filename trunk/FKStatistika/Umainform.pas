unit Umainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, report, ras4et, uftable;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure rename;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var cnt:integer;
procedure TForm1.Button1Click(Sender: TObject);
  var z:TFtable;
begin
  z:=TFtable.Create(owner);
  z.name:='table'+IntToStr(cnt);
  inc(cnt);
  z.tablename:='Таблица '+ inttostr(ListBox1.Count+1);
  ListBox1.AddItem(z.tablename,z);
  z.Show;
  z.rename:=rename;
end;

procedure TForm1.rename;
var i:integer;
begin
  for i:= 0 to ListBox1.Count-1 do
    ListBox1.Items[i]:=TFtable(ListBox1.Items.Objects[i]).tablename;

end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex >=0 then
  TFtable(ListBox1.Items.Objects[ListBox1.ItemIndex]).ShowModal;
end;

end.
