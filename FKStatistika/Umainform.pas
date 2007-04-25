unit Umainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, report, ras4et, uftable,  UVectorFrame, ComCtrls, uparaform,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ListBox2: TListBox;
    Button10: TButton;
    Button11: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Frame11: TFrame1;
    Button12: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ListBox2KeyPress(Sender: TObject; var Key: Char);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure rename;
    procedure rename2;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var cnt:integer;
procedure TForm1.Button1Click(Sender: TObject);
  var z:TFtable;
begin
  inc(cnt);
  z:=TFtable.Create(owner);
  z.name:='table'+IntToStr(cnt);
  z.tablename:='Таблица '+ inttostr(cnt);
  ListBox1.AddItem(z.tablename,z);
  z.rename:=rename;
  z.ShowModal;
end;

procedure TForm1.rename;
var i:integer;
begin
  with ListBox1 do
  for i:= 0 to Count-1 do
    Items[i]:=TFtable(Items.Objects[i]).tablename;

end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  with ListBox1 do
  if ItemIndex >=0 then
  TFtable(Items.Objects[ItemIndex]).ShowModal;
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
      with ListBox1 do
    if ItemIndex<>-1 then
    if TFtable(items.objects[ItemIndex]).events <>nil then
    TFtable(Items[ItemIndex]).events.delete;
    ListBox1.DeleteSelected;
end;

procedure TForm1.Button4Click(Sender: TObject);
var n:integer;
begin
with ListBox1 do
  begin
  n:=ItemIndex-1;
  if ItemIndex > 0 then
  Items.Move(ItemIndex,n) else exit;
  ItemIndex:=n;
  end;
end;

procedure TForm1.ButtonClick(Sender: TObject);
var n:integer;
begin
with ListBox1 do
  begin
  n:=ItemIndex+1;
  if ItemIndex >=0 then
  if ItemIndex <count-1 then
  Items.Move(ItemIndex,ItemIndex+1) else exit;
  ItemIndex:=n;
  end;
end;

var cnt2:integer;

procedure TForm1.Button9Click(Sender: TObject);
  var z:TParaForm;
begin
  inc(cnt2);
  z:=TParaForm.Create(owner);
  z.lb:=ListBox1;
  z.name:='paraform'+IntToStr(cnt2);
  z.paraname:='лин.корреляция '+ inttostr(cnt2);
  ListBox2.AddItem(z.paraname,z);
  z.rename:=rename2;
  z.ShowModal;

end;

procedure TForm1.rename2;
var i:integer;
begin
  with ListBox2 do
  for i:= 0 to Count-1 do
    Items[i]:=TParaForm(Items.Objects[i]).paraname;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  ListBox2DblClick(nil);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
    ListBox2.DeleteSelected;
end;

procedure TForm1.Button11Click(Sender: TObject);
var n:integer;
begin
with ListBox2 do
  begin
  n:=ItemIndex-1;
  if ItemIndex > 0 then
  Items.Move(ItemIndex,n) else exit;
  ItemIndex:=n;
  end;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
  with ListBox2 do
  if ItemIndex >=0 then
  TParaForm(Items.Objects[ItemIndex]).ShowModal;
end;

procedure TForm1.Button10Click(Sender: TObject);
var n:integer;
begin
with ListBox2 do
  begin
  n:=ItemIndex+1;
  if ItemIndex >=0 then
  if ItemIndex <count-1 then
  Items.Move(ItemIndex,ItemIndex+1) else exit;
  ItemIndex:=n;
  end;

end;

procedure TForm1.ListBox2KeyPress(Sender: TObject; var Key: Char);
begin
    IF Key = #13 then
    ListBox2DblClick(nil);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
 Frame11.show(ListBox1);
end;

end.
