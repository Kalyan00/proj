unit UparaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UVectorFrame, Uevents, ras4et, ExtCtrls, uftable,report;

type
  TParaForm = class(TForm)
    Frame11: TFrame1;
    Frame12: TFrame1;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Image1: TImage;
    CheckBox2: TCheckBox;
    Frame13: TFrame1;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit2: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Panel4: TPanel;
    Label8: TLabel;
    Edit7: TEdit;
    Label9: TLabel;
    Edit8: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit9: TEdit;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label12: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    procedure Setparaname(const Value: string);
    function getparaname: string;
    { Private declarations }
  public
    { Public declarations }
    rename:procedure of object;
    lb:tlistbox;
    property paraname:string read getparaname write Setparaname;
    function ShowModal: Integer; override;
    constructor Create(AOwner: TComponent); override;
    procedure ondone;
    procedure report(r:treport);
  end;

function FloatToStr(f:double):string;

implementation

function FloatToStr(f:double):string;
begin
  Result:=uftable.FloatToStr(f);
end;

{$R *.dfm}

{ TParaForm }

function TParaForm.getparaname: string;
begin
  Result:=Edit1.Text;
end;

procedure TParaForm.Setparaname(const Value: string);
begin
  Edit1.Text := Value;
end;

procedure TParaForm.Edit1Change(Sender: TObject);
begin
  Caption:=paraname;
  if assigned(rename) then
    rename;
end;

function TParaForm.ShowModal: Integer;
begin
  if lb=nil then
    raise exception.Create('TParaForm.ShowModal');
  Frame11.show(lb);Frame11.done:=ondone;
  Frame12.show(lb);Frame12.done:=ondone;
  Frame13.show(lb);Frame13.done:=ondone;
  ondone;
  result:=inherited ShowModal;
end;



constructor TParaForm.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TParaForm.CheckBox1Click(Sender: TObject);
begin
  ondone;
end;

procedure TParaForm.CheckBox2Click(Sender: TObject);
begin
  Frame13.Enabled:=CheckBox2.Checked;
  ondone;
end;


procedure TParaForm.ondone;
var kor:tkorel;
begin
  Panel1.Visible:=false;
  Panel2.Visible:=false;
  Panel3.Visible:=false;
  Panel4.Visible:=false;
  GroupBox1.Visible:=false;

  if Frame11.actual and Frame12.actual then
  if (Frame11.rslt<>nil )and (Frame12.rslt<>nil )then
  begin
    if RadioButton2.Checked then
      begin
      Panel4.Visible:= true;
      Edit7.Text:=FloatToStr(_t(Frame11.rslt,Frame12.rslt));
      Edit8.Text:=FloatToStr(_tkr(Frame11.rslt.x+Frame12.rslt.x-2,true));
      Edit9.Text:=FloatToStr(_tkr(Frame11.rslt.x+Frame12.rslt.x-2,false));
      end;

    if Frame11.rslt.n = Frame12.rslt.n then
    begin
      Panel1.Visible:=true;
      GroupBox1.Visible:=true;
      Panel2.Visible:=true;
      kor:=TKorel.create(Frame11.rslt,Frame12.rslt,True);
      Image1.Picture.Bitmap:=kor._bitmap;
      Edit2.Text:=FloatToStr(kor._r);
      Edit4.Text:=FloatToStr(kor._D)+'%';
      Edit5.Text:=FloatToStr(kor._rkrit(false));
      Edit6.Text:=FloatToStr(kor._rkrit(true));

      if CheckBox2.Checked and Frame13.actual and (Frame13.rslt<>nil )and (Frame13.rslt.n = Frame11.rslt.n )then
      begin
        Panel3.Visible:=true;
        Edit3.Text:=FloatToStr(kor._rxy_z(Frame13.rslt));
      end;

      if RadioButton1.Checked then
      begin
        Panel4.Visible:= true;
        Edit7.Text:=FloatToStr(kor._t16);
        Edit8.Text:=FloatToStr(_tkr(Frame11.rslt.x-1,true));
        Edit9.Text:=FloatToStr(_tkr(Frame11.rslt.x-1,false));
      end;
    end;
  end;
end;


procedure TParaForm.RadioButton2Click(Sender: TObject);
begin
  ondone;
end;

procedure TParaForm.report(r: treport);
var s:string;
begin
  ondone;
  if not Panel4.Visible then exit;
  r.add(TRepHeader.create(paraname));
  r.add(TRepText.create('Выполним расчет статистических показателей для пары X, Y'));
  with Frame11 do
  begin
    if ComboBox2.ItemIndex=1 then
    s:='колонка из таблицы ' else
    s:='строка из таблицы ' ;
    r.add(TRepText.create('X - '+rslt.name+' ('+s+Ftable.tablename+')'));
  end;
  with Frame12 do
  begin
    if ComboBox2.ItemIndex=1 then
    s:='колонка из таблицы ' else
    s:='строка из таблицы ' ;
    r.add(TRepText.create('Y - '+rslt.name+' ('+s+Ftable.tablename+')'));
  end;
  r.add(TRepText.create(''));


end;

end.
