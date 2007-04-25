unit UVectorFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ras4et,uftable,Uevents;

type
  TFrame1 = class(TFrame)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label1: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure ComboBox1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ComboBox1DropDown(Sender: TObject);
  private
    { Private declarations }
    tabl1,tabl2:TRtable;
  public
    { Public declarations }
    Ftable:TFtable;
    rslt:Tvector;
    lbb:TListBox;
    procedure show(lb: TListBox);
    function actual:boolean;
  end;

implementation

{$R *.dfm}

procedure TFrame1.ComboBox1Change(Sender: TObject);
begin
  rslt:=nil;
  Label1.Visible:=false;
  if ComboBox1.ItemIndex = -1 then
  begin
    ComboBox2.Enabled:=false;
    ComboBox3.Enabled:=false;
    exit;
  end;
  ComboBox2.ItemIndex:=-1;
  ComboBox2.Enabled:=true;
  Ftable:=TFtable(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
  Tag:=Ftable.Tag;
  tabl1:=Ftable.getTRtable;
  tabl2:=nil;
  ComboBox3.Clear;
  ComboBox3.Enabled:=False;
end;

procedure TFrame1.ComboBox2Change(Sender: TObject);
begin
  rslt:=nil;
  case ComboBox2.ItemIndex of
    -1:begin
      ComboBox3.Enabled:=false;
      ComboBox3.Clear;
      exit;
    end;
    0:begin
      tabl2:=tabl1;
    end;
    1:begin tabl2:=tabl1.getT;end;
  end;
  ComboBox3.Enabled:=true;
  if tabl2.namey <> nil then
  ComboBox3.Items:=tabl2.namey;
end;


procedure TFrame1.show(lb: TListBox);
begin
  lbb:=lb;
  if ComboBox1.Items.Count=0 then
    ComboBox1.Items:=lb.Items;
  Label1.Visible:=not actual;
end;

procedure TFrame1.ComboBox1Enter(Sender: TObject);
begin
{  Label1.Visible:=false;
  if lbb <> nil then
    if lbb.Items <>nil then
      ComboBox1.Items:=lbb.Items;     }
end;

procedure TFrame1.ComboBox1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
Application.ProcessMessages;
end;

procedure TFrame1.ComboBox1DropDown(Sender: TObject);
begin
  Label1.Visible:=false;
  if lbb <> nil then
    if lbb.Items <>nil then
      ComboBox1.Items:=lbb.Items;
end;

function TFrame1.actual: boolean;
begin
  Result:=true;
  if Ftable<>nil then
    if lbb.Items.IndexOfObject(Ftable)<>-1 then
      Result:=Ftable.Tag=tag;
end;

end.
