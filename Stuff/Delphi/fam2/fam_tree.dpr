program fam_tree;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  types3 in 'types3.pas',
  Unit2 in 'Unit2.pas' {Frame2: TFrame},
  Unit3 in 'Unit3.pas' {Frame3: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'famaly_tree';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
