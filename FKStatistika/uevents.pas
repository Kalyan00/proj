unit uevents;

interface
uses classes;
type tproc = procedure of object;
type tprocptr = ^tproc;
type Tevents = class
  private
    list:tlist;
  public
    procedure delete;
    procedure add(item:tprocptr);
end;

{type TEvent_ = procedure of object;
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
    procedure subscribe(me:Tevents);
    function CopySubScribers:Tevents;
    destructor destroy; override;
  end;
}
implementation


{ Tevents }
 (*
function Tevents.CopySubScribers: Tevents;
var i:integer;
begin
  Result:=Tevents.create;
  for i:=0 to list.Count-1 do
    Result.subscribe(Tevents(list[i]));
end;

constructor Tevents.create;
begin
  list:=TList.Create;
end;


destructor Tevents.destroy;
var i:integer;
begin
{  while list.Count<>0 do
    for i:=0 to list.Count-1 do
      if list[i]<>nil then
        tevents(list[i]).free;   }
  list.Destroy;
  if parent <> nil then
  parent.desubscribe(self);
  inherited;
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
  subscribe(Result);
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

procedure Tevents.subscribe(me: Tevents);
begin
  if me.Fparent=nil then
    me.Fparent:=self;
  list.Add(me);
end;
    *)
{ Tevents }

procedure Tevents.add(item: tprocptr);
begin
  if list=nil then list:=TList.Create;
  list.Add(item);
end;

procedure Tevents.delete;
var i:integer;
begin
  if list<> nil then
    for i:=0 to list.Count-1 do
      tprocptr(list[i])^;
  if list<> nil then list.Destroy;
  Self.Destroy;
end;

end.
