unit report;

interface
uses classes,sysutils,windows;
type
  TrepItems = class
    html:string;
    function write:string;virtual;
    function convertHTML(s:string):string;
  end;

  Treport = class
  private
    items:Array[0..1000] of TrepItems;
    count:integer;
  public
    procedure view;
    procedure add(item: TrepItems);
  end;

  TRepTable = class (TrepItems)
    constructor create(x, y:integer; text:string);
  end;

  TRepImage = class (TrepItems)
    constructor create(name:string);
  end;

  TRepText = class (TrepItems)
    constructor create(Text:string);
  end;

  TRepHeader = class (TrepItems)
    constructor create(Text:string);
  end;


implementation

{ Treport }

procedure Treport.add(item: TrepItems);
begin
  items[count]:=item;
  inc(count);
end;

procedure Treport.view;
  var s:string; i:integer;l:TStringList;
begin
  s:='<html><head></head><body>';
  for i:=0 to 1000 do
    if items[i]<>nil then
      s:=s+items[i].write;
  s:=s+'</body></html>';
  l:=TStringList.Create;
  l.Text:=s;
  l.SaveToFile('temp.htm');
  s:='cmd /c start '+getcurrentdir+'\temp.htm';
  i:= WinExec(pchar(s),SW_NORMAL);
end;

{ TrepItems }

function TrepItems.convertHTML(s: string): string;
var i:integer;
begin
  Result:='';
  for i := length(s) downto 1 do
    case s[i] of //&lt; &gt; &amp; &nbsp; &quot
      '<': result:='&lt'+result;
      '>': result:='&gt'+result;
      '&': result:='&amp'+result;
      ' ': result:='&nbsp'+result;
      '"': result:='&quot'+result;
      else result:=s[i]+result;
    end;
end;

function TrepItems.write: string;
begin
  Result:=html+#13#10;
end;

{ TRepTable }

constructor TRepTable.create(x, y:integer; text: string);
  var k,i,j:integer;z:string;text_:TStringList;
begin
  text_:= TStringList.Create;
  text_.Text:=text;
  html:='<p><table border=1 cellspacing=0 cellpadding=0>';
  k:=0;
  for i:=0 to y-1 do
  begin
    html:=html+'<tr>';
    for j:= 0 to x-1 do
    begin
      z:='&nbsp';
      if k<text_.Count then z:=convertHTML(text_[k]);
      html:=html+'<td>'+z+'</td>';
      inc(K);
    end;
    html:=html+'</tr>'#13#10;
  end;
  html:=html+'</table></p>';
end;

{ TRepImage }

constructor TRepImage.create(name: string);
begin
  html:='<img src="'+name+'">'#13#10;
end;

{ TRepText }

constructor TRepText.create(Text: string);
begin
  html:='<p>'+convertHTML(text)+'</p>';
end;

{ TRepHeader }

constructor TRepHeader.create(Text: string);
begin
  html:='<p><h1>'+convertHTML(text)+'</h1></p>';
end;

end.
