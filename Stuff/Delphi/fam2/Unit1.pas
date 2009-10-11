unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBTables, Grids, DBGrids,types3,unit2,unit3,
  tkico,Registry;

const fram2max=50;
      maxmen=500;

type
  sort=(byid,byborn,byfam,bynam,byot4);
  tframe21 = class(tframe2)
  public
    procedure makelets(i:word);override;
    procedure ris(i:word);override;
    procedure newname(i:string);override;

  end;
  tframe31 = class(TFrame3)
  public
    procedure makelets(i:word);override;
    procedure ris(i:word);override;

  end;
  tkicon1=class(tkicon)
  public
  id:byte;
  procedure delete_; override;
  end;








  TForm1 = class(TForm)
    Memo1: TMemo;
    suprscrol: TScrollBox;      detiscrol: TScrollBox;
    ScrollBox3: TScrollBox;     jaScrol: TScrollBox;
    mamaScrol: TScrollBox;      papaScrol: TScrollBox;
    ScrollBox1: TScrollBox;     ScrollBox2: TScrollBox;
    ScrollBox4: TScrollBox;
    eborn: TEdit;       ebornm: TEdit;  ebornd: TEdit;
    flet: TEdit;        ilet: TEdit;    olet: TEdit;
    RadioButton1: TRadioButton;    RadioButton2: TRadioButton;
    Image1: TImage;     mal4: TImage;   devo4: TImage;
    plussupr: TImage;   Imopen: TImage; Imsave: TImage;
    Button1: TButton;   Button2: TButton;       Button3: TButton;
    Button4: TButton;   Button5: TButton;
    Label3:tlabel;      Label4:tlabel;  Label5:tlabel;  Label6:tlabel;
    Label1:tlabel;      Label2:tlabel;  Label7:tlabel;  Label8:tlabel;  Label9:tlabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure plussuprClick(Sender: TObject);
    procedure mal4Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure devo4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ImopenClick(Sender: TObject);
    procedure ImsaveClick(Sender: TObject);
    procedure Fiochange(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    open__,memorunning,makeletsrunning,changefiorunning:boolean;

    mal4__:boolean;
    fmama,fpapa,fja:tframe21;
    fsupr,fdeti:array[0..fram2max]of tframe21;
    fmans:array[0..maxmen]of TFrame31;
    tlast:byte;
    fkico:array[0..255]of tkicon1;
  public
    deleterunning:Boolean;
    loaded:word;
    baza:array[0..maxmen] of man;
    infobaza:array[0..maxmen]of tstringlist;
    filebaza:array[0..maxmen]of tstringlist;
    curbaza,curlet:word;
    cursort:sort;
    sortlist:array[0..maxmen]of record pred,next:id_;end;
    nachsort,konsort:word;
{    filename:string;}

    property bazalast:word read baza[0].mama write baza[0].mama;
    property infolast:word read baza[0].papa  write baza[0].papa;
    procedure detvis(a:boolean);
    property detvisa:boolean write detvis; 
    procedure open(sfilen:string);
    function addbaza(s:sex_):id_;
    procedure ris(j:id_);
    procedure makelets(j:id_);
    procedure newname(letsn:string);
    procedure sortby(a:sort);
    procedure addsorted(iii:id_);
    procedure delsorted(iii:id_);
    procedure assignsorted;
    procedure deleteman(iii:id_);
    procedure seticos(a:tstringlist);
    procedure addfile(s:string);
  end;
var
  Form1: TForm1;








implementation

{$R *.dfm}

procedure TFrame31.makelets(i:word);begin form1.makelets(i);form1.ris(form1.curbaza);end;
procedure TFrame31.ris(i:word); begin form1.ris(i);  end;
procedure TFrame21.makelets(i:word);begin form1.makelets(i);form1.ris(form1.curbaza); end;
procedure TFrame21.ris(i:word); begin form1.ris(i);end;
procedure TFrame21.newname(i:string);begin form1.newname(i); end;
procedure TForm1.Image1Click(Sender: TObject);begin Form1.Close;end;
procedure TForm1.plussuprClick(Sender: TObject);begin newname('supr'+inttostr(baza[curbaza].lsupr));suprscrol.HorzScrollBar.Position:=130*baza[curbaza].lsupr end;
procedure TForm1.devo4Click(Sender: TObject);begin mal4__:=false;newname('deti');end;
procedure TForm1.mal4Click(Sender: TObject); begin mal4__:=true; newname('deti');end;


procedure TForm1.Button1Click(Sender: TObject);begin sortby(byid);end;
procedure TForm1.Button2Click(Sender: TObject);begin sortby(byborn);end;
procedure TForm1.Button3Click(Sender: TObject);begin sortby(byfam);end;
procedure TForm1.Button5Click(Sender: TObject);begin sortby(bynam);end;
procedure TForm1.Button4Click(Sender: TObject);begin sortby(byot4);end;
procedure TForm1.RadioButton2Click(Sender: TObject); begin baza[curlet].sex:=female; Fiochange(sender); end;
procedure TForm1.RadioButton1Click(Sender: TObject); begin baza[curlet].sex:=male; Fiochange(sender); end;











procedure tform1.deleteman(iii:id_);
        begin
        if MessageDlg('Welcome to my Object Pascal application.  Exit now?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        end;























procedure tkicon1.delete_;
begin
inherited delete_;
if Form1.makeletsrunning then exit;
form1.deleterunning:=true;
Form1.filebaza[Form1.curlet].BeginUpdate;
if Form1.filebaza[Form1.curlet].Count>=id then
Form1.filebaza[Form1.curlet].Delete(id);
Form1.filebaza[Form1.curlet].EndUpdate;
form1.deleterunning:=false;
Form1.makelets(Form1.curlet);
end;



















procedure tform1.addfile(s:string);
        begin
        filebaza[curlet].Add(s);
        makelets(curlet);
        end;

procedure tform1.seticos;
        var i:byte;
        begin
        for i:=1 to a.Count do
                begin
                if tlast<=i-1 then
                        begin
                        fkico[i-1]:=tkicon1.Create(owner);
                        fkico[i-1].Name:=fkico[i-1].Name+inttostr(i-1);
                        fkico[i-1].Parent:=ScrollBox4;
                        fkico[i-1].Left:=120*(i-1);
                        fkico[i-1].top:=0;
                        fkico[i-1].Visible:=true;
                        fkico[i-1].Color:=color;
                        fkico[i-1].id:=i-1;
                        tlast:=i;
                        end;
                fkico[i-1].assign(a.Strings[i-1]);
                end;
        if tlast>=a.Count then
        for i:=a.Count+1 to tlast do
        fkico[i-1].delete_;
        end;












procedure tform1.assignsorted;
        var i,j:id_;
        begin
        j:=1;
        i:=0;
        while i<>sortlist[0].pred do
        begin
        i:=sortlist[i].next;
        fmans[j].assign_3(baza[i],curlet);
        if i=curlet then
        if (ScrollBox2.VertScrollBar.Position > 15*(j))or(ScrollBox2.VertScrollBar.Position < 15*(j-7))
        then ScrollBox2.VertScrollBar.Position:=15*(j-4);
        inc(j);
        end;
        end;

















procedure tform1.delsorted(iii:id_);
         begin
         with sortlist[iii] do
         begin
         sortlist[pred].next:=next;
         sortlist[next].pred:=pred;
         end;
         end;
























procedure tform1.sortby(a:sort);
         var i:word;
         begin
         cursort:=a;
         sortlist[0].next:=1;
         sortlist[0].pred:=1;
         sortlist[1].next:=0;
         sortlist[1].pred:=0;
         if bazalast=1 then exit;
         for i:=2 to bazalast do
         addsorted(i);
         assignsorted;
         end;



















procedure tform1.addsorted(iii:id_);
        function max(a,b:integer):boolean;
                begin max:=a>b;end;
        function maxs(a,b:string):boolean;
                var i:byte;
                begin
                maxs:=true;
                for i:=1 to length(a) do
                if i>length(b) then
                begin maxs:=false; exit;end else
                if ord(upcase(a[i]))>ord(upcase(b[i])) then exit else
                begin maxs:=false; exit;end;
                end;
        function ifff(a,b:id_):boolean;
                begin
                case cursort of
                byid: ifff:=max(baza[a].id,baza[b].id);
                byborn:ifff:=max(baza[a].born,baza[b].born);
                byfam:ifff:=maxs(baza[a].f,baza[b].f);
                bynam:ifff:=maxs(baza[a].i,baza[b].i);
                byot4:ifff:=maxs(baza[a].o,baza[b].o);
                else ifff:= true;
                end;
                end;
         var cur:id_;
         begin
         cur:=0;
         while cur<>sortlist[0].pred do
         with sortlist[cur] do
         if not ifff(iii,next) then break else cur:=next;
         sortlist[sortlist[cur].next].pred:=iii;
         sortlist[iii].next:=sortlist[cur].next;
         sortlist[cur].next:=iii;
         sortlist[iii].pred:=cur;
         end;


























procedure TForm1.FormCreate(Sender: TObject);
var i:byte;j:word;
begin

deleterunning:=false;
tlast:=0;
{filename:='%windir\temp\famaltmp';
if DirectoryExists(filename) then delete(filename);
CreateDir(filename);                    }
for j:=0 to maxmen do
infobaza[j]:=TStringList.Create;
for j:=0 to maxmen do
filebaza[j]:=TStringList.Create;
makeletsrunning:=false;
changefiorunning:=false;
memorunning:=false;
Memo1.ScrollBars:=ssVertical;
loaded:=0;
sortlist[0].next:=1;
sortlist[0].pred:=1;
sortlist[1].next:=0;
sortlist[1].pred:=0;

fmans[0]:=TFrame31.Create(Owner,'zeronan456',0);
cursort:=byid;
    fmama :=tframe21.Create('mama',0,0,owner);form1.mamaScrol.InsertControl(fmama);
    fpapa :=tframe21.Create('papa',0,0,owner);form1.papaScrol.InsertControl(fpapa);
    fja   :=tframe21.Create('ja__',0,0,owner);form1.jaScrol.InsertControl(fja);
    for i:=0 to fram2max do begin
    fsupr[i]:=tframe21.Create('supr'+inttostr(i),130*i,0,owner);form1.suprscrol.InsertControl(fsupr[i]); end;
    for i:=0 to fram2max do begin
    fdeti[i]:=tframe21.Create('deti'+inttostr(i),130*i,0,owner);form1.detiscrol.InsertControl(fdeti[i]); end;
bazalast:=0;
curbaza:=1;
curlet:=1;
addbaza(male);
ris(curbaza);
if ParamCount<>0 then open__:=true else open__ :=false;
end;



procedure tform1.detvis(a:boolean);
        begin
        form1.ScrollBox1.Visible:=a;
        Label15.Visible:=a;
        Bevel5.Visible:=a;
        Bevel6.Visible:=a;
        Bevel7.Visible:=a;
        Bevel8.Visible:=a;

        end;

procedure tform1.ris;
        var k:id_;
        begin
        {showmessage('ris');{}
        detvisa:=baza[j].lsupr<>0;
        if j=0 then exit;
        with baza[j] do begin
        fja.assign_(baza[j],curlet=j);
        fmama.assign_(baza[mama],curlet=mama);
        fpapa.assign_(baza[papa],curlet=papa);
        if ldeti<>0 then
        for k:=0 to ldeti-1 do
        fdeti[k].assign_(baza[deti[k]],curlet=deti[k]);
        for k:=ldeti to fram2max do fdeti[k].Visible:=false;
        if lsupr<>0 then
        for k:=0 to lsupr-1 do
        fsupr[k].assign_(baza[supr[k]],curlet=supr[k]);
        for k:=lsupr to fram2max do fsupr[k].Visible:=false;
        end;
        curbaza:=j;
        assignsorted;
        suprscrol.HorzScrollBar.Position:=((suprscrol.HorzScrollBar.Position +50)div 130 )*130
        end;









procedure tform1.newname(letsn:string);
        var l:string;supp:id_; lets:word; const male_:array[false..True]of sex_=(female,male);
        begin
        l:=letsn;
        Delete(l,1,4);
        SetLength(letsn,4);
        with baza[curbaza] do
        begin
        if letsn='mama' then
                begin
                lets:=addbaza(female);
                mama:=lets;
                baza[mama].adddeti(curbaza);
                if papa<>0 then  begin baza[mama].addsupr(papa); baza[papa].addsupr(mama); end;
                end;
        if letsn='papa' then
                begin
                lets:=addbaza(male);
                papa:=lets;
                baza[papa].adddeti(curbaza);
                if mama<>0 then  begin baza[mama].addsupr(papa); baza[papa].addsupr(mama); end;
                end;
        if letsn='supr' then
                begin
                lets:=addbaza(notsex[sex]);
                addsupr(lets);
                baza[lets].addsupr(curbaza);
                end;
        if letsn='deti' then
                begin
                supp:=supr[suprscrol.HorzScrollBar.Position div 130];
                lets:=addbaza(male_[mal4__]);
                adddeti(lets);
                case sex of
                        male: baza[lets].addpapa(curbaza);
                        female: baza[lets].addmama(curbaza);
                        end;
                baza[supp].adddeti(lets);
                case sex of
                        male:baza[lets].addmama(supp);
                        female:baza[lets].addpapa(supp);
                end;
                end;
        addsorted(lets);
        curlet:=lets;
        ris(curbaza);
        makelets(lets);
        end;
        end;















function TForm1.addbaza;
        begin
        bazalast:=bazalast+1;
        baza[bazalast].create(s,bazalast);
        if loaded<bazalast then
        begin
        inc(loaded);
        ScrollBox2.VertScrollBar.Position:=0;
        fmans[bazalast]:=tframe31.Create(owner,'fmans'+inttostr(bazalast),15*(bazalast-1));
        form1.ScrollBox2.InsertControl(fmans[bazalast]);
        end;
        fmans[bazalast].Visible:=true;

        addbaza:=bazalast;

        end;
















procedure tform1.makelets;
        var s:string;k,i,omam:word;inf:array[0..10000]of byte; qwre:table;
        begin
        if deleterunning or makeletsrunning or memorunning or changefiorunning then exit;
        makeletsrunning:=true;
        curlet:=j;
        with baza[j] do begin
        flet.Text:=f;
        ilet.Text:=i;
        olet.Text:=o;
        eborn.Text:=inttostr(born);
        ebornm.Text:=inttostr(bornm);
        ebornd.Text:=inttostr(bornd);
        if sex=male then radioButton1.SetFocus else
        RadioButton2.SetFocus;
        end;
        Memo1.Lines.Clear;
        Memo1.Lines.AddStrings(infobaza[j]);
        seticos(filebaza[j]);

        {

        Move(infobaza[baza[j].addinfo],qwre,sizeof(qwre));
        for i:=0 to qwre.n do
        move(infobaza[qwre.a[i]],inf[i*sizeof(man)],sizeof(man));
        memo1.Lines.Clear;
        k:=0;
        omam:=0;
        while true do
        begin
        SetLength(s,0);
        for i:=k+1 to k+inf [k]do
        s:=s+char(inf[i]);
        if s='' then inc(omam) else
        begin
        if omam<>0 then
        for omam:=omam downto 1 do
        memo1.Lines.Add('');
        memo1.Lines.Add(s);
        end;
        if i=k then inc(i);
        k:=i;
        if k>=qwre.size then break;
        end;                   }
        makeletsrunning:=false;
        end;















procedure TForm1.ImopenClick(Sender: TObject);
var OpenDialog1:tOpenDialog;
begin
OpenDialog1:=tOpenDialog.Create(owner);
OpenDialog1.Filter:='Famaly tree files (*.fam)|*.fam';
  if OpenDialog1.Execute then open(OpenDialog1.FileName);
  OpenDialog1.Free;
end;


procedure TForm1.open;
type arrb=array[0..sizeof(man)-1 ] of byte;
     parb=^arrb;
var
  s2,s:String; c:char;
  F: file of byte;
  i,j:id_;
  mann:man;
  wq:parb;
  files:boolean;

  begin
caption :='семейное древо   '+sfilen;
    for i:=1 to bazalast do fmans[i].Visible:=false;
    AssignFile(F, sfilen);
{    filename:=OpenDialog1.FileName;
 }   Reset(F);

    wq:=@baza[0];
     for j:=0 to sizeof(man)-1 do
    Read(F, wq^[j]);
    i:=bazalast;
    bazalast:=0;
    while bazalast<i do addbaza(male);

    for i:=1 to bazalast do
    begin
    wq:=@baza[i];
    for j:=0 to sizeof(man)-1 do
    read(F, wq^[j]);
    end;

    for j:=0 to bazalast do
    begin
    s:='';
    s2:='';
    files:=false;
    repeat
    read(F, byte(c));
    if files then
    s2:=s2+c else
    s:=s+c;
    if c=#1 then files:=true;
    until c=#0;

    setlength(s,length(s)-1);
    setlength(s2,length(s2)-1);
    filebaza[j].SetText(pchar(s2));
    infobaza[j].SetText(pchar(s));

    end;
    CloseFile(F);
    ris(1);
    makelets(1);
    sortby(byid);
    assignsorted;

  end;




procedure TForm1.ImsaveClick(Sender: TObject);
var saveDialog1:TSaveDialog;
type arrb=array[0..sizeof(man)-1 ] of byte;
     parb=^arrb;
var
  q:pchar;s:string;
  F: file of byte;
  i,j:id_;
  wq:parb;

  man00:man;
  mann:man;
  propaganda:string absolute man00;
begin
saveDialog1:=TSaveDialog.Create(owner);
saveDialog1.Filter:='Famaly tree files (*.fam)|*.fam';
  if saveDialog1.Execute then
  begin
    saveDialog1.FileName:=ChangeFileExt(saveDialog1.FileName,'.fam');
caption :='семейное древо   '+saveDialog1.FileName;
AssignFile(F, saveDialog1.FileName);
{    ForceDirectories(saveDialog1.FileName);
    filename:=saveDialog1.FileName;
}    Rewrite(F);
    for i:=0 to bazalast do
    begin
    wq:=@baza[i];
    for j:=0 to sizeof(man)-1 do
    Write(F, wq^[j]);
    end;
    for j:=0 to bazalast do
    begin
    s:=string(infobaza[j].GetText)+#1+string(filebaza[j].GetText);
    q:=pchar(s);

    i:=0;
    repeat
    Write(F, byte(q[i]));
    inc(i);
    until q[i-1]=#0;
    end;

    closefile(f);
    saveDialog1.Free;
  end;
end;








procedure TForm1.Fiochange(Sender: TObject);
function ucase(c:char):char;
        begin
        case c of
        'a'..'z','а'..'я':ucase:=char(byte(c)+byte('A')-byte('a'));
        'ё':ucase:='Ё';
        else ucase:=c;
        end;
        end;
function lcase(c:char):char;
        begin
        case c of
        'A'..'Z','А'..'Я':LCASE:=CHAR(BYTE(C)+BYTE('a')-BYTE('A'));
        'Ё':LCASE:='ё';
        else Lcase:=c;
        end;
        end;
function norm(s:string):string;
        var i:byte;ss:string;
        begin
        norm:='';
        if s='' then exit;
        ss:=s;
        if Length(ss)>1 then
        for i:=2 to length(ss) do
        ss[i]:=LCase(ss[i]);
        ss[1]:=UCase(ss[1]);
        norm:=ss;
        end;
begin
         if  makeletsrunning then exit;

        changefiorunning :=true;

        baza[curlet].f:=norm(flet.Text);
        baza[curlet].i:=norm(ilet.Text);
        baza[curlet].o:=norm(olet.Text);
        try baza[curlet].born:=StrToInt(eborn.Text);except baza[curlet].born:=0;end;
        try baza[curlet].bornm:=StrToInt(ebornm.Text);except baza[curlet].bornm:=0;end;
        try baza[curlet].bornd:=StrToInt(ebornd.Text);except baza[curlet].bornd:=0;end;
        ris(curbaza);
        if curlet=0 then exit;
        delsorted(curlet);
        addsorted(curlet);
        assignsorted;
        changefiorunning :=false;

end;










procedure TForm1.Memo1Change(Sender: TObject);
function min(a,b:word):word;begin if a>b then min:=b else min:=a;end;
var i,k,j:word; inf:array[0..10000]of byte; qwre:table;
begin

if memorunning or makeletsrunning then exit;
memorunning:=true;

infobaza[curlet].Clear;
infobaza[curlet].AddStrings(memo1.Lines);


{
j:=0;
for k:=0 to memo1.Lines.Count do begin
inf[j]:=length(memo1.Lines.Strings[k]);

for i:=1 to length(memo1.Lines.Strings[k]) do
inf[j+i]:=byte(memo1.Lines.Strings[k][i]);
j:=j+length(memo1.Lines.Strings[k])+1;
if j>9000 then break;
end;

k:=0;
for i:=0 to memo1.Lines.Count do k:=k+length(memo1.Lines.Strings[i]);
k:=k+memo1.Lines.Count;


move(infobaza[baza[curlet].addinfo],qwre,sizeof(qwre));
qwre.size:=j;
qwre.n:=j div sizeof(man);
for i:=0 to (j div sizeof(man))do
begin j:=qwre.a[i];
if j=0 then begin j:=createaddinfo;qwre.a[i]:=j;end;
Move(inf[i*sizeof(man)],infobaza[j],min(sizeof(man),(i+1)*sizeof(man)-k));
end;
move(qwre,infobaza[baza[curlet].addinfo],sizeof(qwre));}
memorunning:=false;

end;

procedure TForm1.Label10Click(Sender: TObject);
var o:TOpenDialog;
begin
o:=TOpenDialog.Create(owner);
if o.Execute then
addfile(o.FileName);
o.Free;
end;


procedure TForm1.FormPaint(Sender: TObject);
begin
if open__ then open(paramstr(1));
open__:=false;
end;

end.

