unit UVectorFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ras4et,uftable;

type
  TFrame1 = class(TFrame)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
    tabl1,tabl2:TRtable;
  public
    { Public declarations }
    rslt:Tvector;
    lbb:TListBox;
    constructor create(lb:TListBox);
  end;

implementation

{$R *.dfm}

procedure TFrame1.ComboBox1Change(Sender: TObject);
begin
  rslt:=nil;
  if ComboBox1.ItemIndex = -1 then
  begin
    ComboBox2.Enabled:=false;
    ComboBox3.Enabled:=false;
    exit;
  end;
  ComboBox2.Enabled:=true;
  tabl1:=TFtable(ComboBox1.Items.Objects[ComboBox1.ItemIndex]).getTRtable;
  tabl2:=nil;
  ComboBox3.Clear;
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

constructor TFrame1.create(lb: TListBox);
begin
  lbb:=lb;
  ComboBox1.Items:=lb.Items;
end;

end.
