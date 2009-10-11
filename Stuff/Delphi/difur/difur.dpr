program difur;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  calcw in 'calcw.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'difur';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
