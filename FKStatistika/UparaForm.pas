unit UparaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UVectorFrame, Uevents;

type
  TParaForm = class(TForm)
    Frame11: TFrame1;
    Frame12: TFrame1;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    procedure Edit1Change(Sender: TObject);
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
  end;


implementation

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
  if assigned(rename) then
    rename;
end;

function TParaForm.ShowModal: Integer;
begin
  if lb=nil then
    raise exception.Create('TParaForm.ShowModal');
  Frame11.show(lb);
  Frame12.show(lb);
  result:=inherited ShowModal;
end;



constructor TParaForm.Create(AOwner: TComponent);
begin
  inherited;
end;

end.
