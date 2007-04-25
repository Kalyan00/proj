unit uevents;

interface
uses classes;
type TEvent_ = procedure of object;
type Tevents = class
  private
    Fparent: TEvents;
    list:tlist;
    FonRaise: TEvent_;
    procedure SetonRaise(const Value: TEvent_);
    procedure desubscribe(me:TEvents);
  protected
  public
    property parent:TEvents read Fparent;
    procedure raise_;
    property onRaise:TEvent_ read FonRaise write SetonRaise;
    function NewSubScriber:Tevents;
    constructor create;
  end;

implementation


{ Tevents }

constructor Tevents.create;
begin
  list:=TList.Create;
end;


procedure Tevents.desubscribe(me: TEvents);
begin
  if list.IndexOf(me)>=0 then
    list.Delete(list.IndexOf(me))
  else
    list.Delete(-1);


end;

function Tevents.NewSubScriber: Tevents;
begin
  Result:=Tevents.create;
  Result.Fparent:=self;
  list.Add(result);
end;

procedure Tevents.raise_;
var i:integer;
begin
  if Assigned(fonraise) then onRaise;
  for i:=0 to list.Count-1 do
    if assigned(list[i]) then
      Tevents(list[i]).raise_;
end;


procedure Tevents.SetonRaise(const Value: TEvent_);
begin
  FonRaise := Value;
end;

end.
