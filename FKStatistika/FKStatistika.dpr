program FKStatistika;

uses
  Forms,
  Umainform in 'Umainform.pas' {Form1},
  report in 'report.pas',
  ras4et in 'ras4et.pas',
  Uvisual in 'Uvisual.pas',
  UFtable in 'UFtable.pas' {Ftable},
  UVectorFrame in 'UVectorFrame.pas' {Frame1: TFrame},
  UparaForm in 'UparaForm.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
