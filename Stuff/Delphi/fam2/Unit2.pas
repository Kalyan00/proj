unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus,types3;

type

  TFrame2 = class(TFrame)
    f: TLabel;
    i: TLabel;
    o: TLabel;
    Image1: TLabel;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Label2: TLabel;
    procedure oClick(Sender: TObject);
    procedure fDblClick(Sender: TObject);


  private
    { Private declarations }
    idd:word;

    procedure setid(a:word);
  public
    procedure makelets(i:word); virtual;
    procedure ris(i:word);      virtual;
    procedure newname(i:string);virtual;
    property id:word read idd write setid;
    procedure Click;
    procedure assign_(kkk:man;qwer:boolean);
    constructor create(n:string;x,y:word;own:tcomponent);
  end;

implementation

{$R *.dfm}

constructor tFrame2.create;
begin
inherited create(own);
name:=n;
top:=y;
left:=x;
id:=0;
end;
procedure TFrame2.makelets;begin   end;
procedure TFrame2.ris(i:word); begin end;
procedure TFrame2.newname(i:string);     begin end;

procedure tframe2.assign_(kkk:man;qwer:boolean);
        const sexcolor:array[male..female]of TColor =($00FF8000,$008080FF);
        begin                                
        Visible:=true;
        id:=kkk.id;
        if kkk.id=0 then begin
        Caption:='';
        f.Caption:='';
        i.Caption:='';
        o.Caption:='';
        Image1.Visible:=true;
        Label2.Visible:=False;
        end else begin
        f.Font.Color:=sexcolor[kkk.sex];
        i.Font.Color:=sexcolor[kkk.sex];
        o.Font.Color:=sexcolor[kkk.sex];
        f.Caption:=kkk.f;
        i.Caption:=kkk.i;
        o.Caption:=kkk.o;
        Image1.Visible:=false;
        if (kkk.f ='')and (kkk.i ='')and(kkk.o ='')then
        Label2.Visible:=true else Label2.Visible:=False;

        end;
        label1.Visible:=qwer;
        end;


procedure TFrame2.Click;
begin
if id=0 then newname(name);
makelets(id);
end;


procedure tFrame2.setid;
        begin
        idd:=a;
        end;


procedure TFrame2.oClick(Sender: TObject);
begin
click;
end;

procedure TFrame2.fDblClick(Sender: TObject);
begin
click;
ris(id);
end;

end.
