unit Unit3;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,types3;


type
  TFrame3 = class(TFrame)
    id: TLabel;
    born: TLabel;
    famil: TLabel;
    nam: TLabel;
    ot4: TLabel;
    procedure ot4Click(Sender: TObject);
    procedure ot4DblClick(Sender: TObject);
  private

  public
    id_:word;
    procedure makelets(i:word);virtual;
    procedure ris(i:word); virtual;
    procedure assign_3(var aaa:man;curlet:id_);

    procedure setfont(a:tfontstyles);
    constructor create(a:TComponent;n:string;t:integer);
  end;


var letss3,letsb3:^boolean;lets3:^word;letsn3:^string;

implementation

{$R *.dfm}
procedure TFrame3.makelets(i:word);begin end;
procedure TFrame3.ris(i:word);begin end;

procedure tframe3.setfont;
        begin
        id.Font.Style:=a;
        famil.Font.Style:=a;
        nam.Font.Style:=a;
        ot4.Font.Style:=a;
        born.Font.Style:=a;
        end;

constructor tframe3.create;
        begin
        inherited create(a);
        name:=n;
        top:=t;
        end;

procedure TFrame3.assign_3;
        begin
        if curlet=aaa.id then setfont([fsunderline]) else setfont([]);
        id_:=aaa.id;
        id.Caption:=inttostr(id_);
        famil.Caption:=aaa.f;
        nam.Caption:=aaa.i;
        ot4.Caption:=aaa.o;
        born.Caption:=IntToStr(aaa.born);
        end;

procedure TFrame3.ot4Click(Sender: TObject);begin makelets(id_);end;
procedure TFrame3.ot4DblClick(Sender: TObject);begin makelets(id_);ris(id_);end;

end.
