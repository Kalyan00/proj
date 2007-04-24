unit Umainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, report, ras4et, uftable;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
  var z : TRepTable; r:Treport;
begin
(*  r:=Treport.Create;
  r.add(TRepTable.create(3,7,'asdf'#13#10'sdf'#13#10'<&" >'#13#10'sdf'#13#10'sdf'#13#10'sdf'#13#10'sdf'));
  r.add(TRepImage.create('test.gif'));
  r.add(TRepText.create('<html src="bla"> &nbsp'));
  r.view;//*)

Ftable.Show;;

end;

end.
