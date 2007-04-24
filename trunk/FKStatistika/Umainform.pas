unit Umainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, report, ras4et, uftable,  UVectorFrame;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  z.tablename:='Таблица '+ inttostr(cnt);
  ListBox1.AddItem(z.tablename,z);
  z.rename:=rename;
  z.ShowModal;
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

procedure TForm1.Button3Click(Sender: TObject);
begin
  ListBox1DblClick(nil);
end;

procedure TForm1.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
  IF Key = #13 then
    ListBox1DblClick(nil);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//  if ListBox1.ItemIndex<>-1 then
    ListBox1.DeleteSelected;
end;

procedure TForm1.Button4Click(Sender: TObject);
var n:integer;
begin
  n:=ListBox1.ItemIndex-1;
  if ListBox1.ItemIndex > 0 then
  ListBox1.Items.Move(ListBox1.ItemIndex,n) else exit;
  ListBox1.ItemIndex:=n;
end;

procedure TForm1.Button5Click(Sender: TObject);
var n:integer;
begin
  n:=ListBox1.ItemIndex+1;
  if ListBox1.ItemIndex >=0 then
  if ListBox1.ItemIndex <ListBox1.count-1 then
  ListBox1.Items.Move(ListBox1.ItemIndex,ListBox1.ItemIndex+1) else exit;
  ListBox1.ItemIndex:=n;
end;

end.
