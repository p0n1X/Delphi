unit DialogProcessorU;

interface

uses Graphics, Types, DisplayProcessorU, ShapesU, NewRectU, Contnrs, GroupShapeU,UnGroupShapeU ;

type
  /// Класът, който ще бъде използван при управляване на диалога.
  TDialogProcessor = class(TDisplayProcessor)
  protected
    fSelection: TObjectList;
    fIsDragging: Boolean;
    fLastLocation: TPoint;

    procedure SetSelection(const Value: TObjectList);
    procedure SetIsDragging(const Value: Boolean);
    procedure SetLastLocation(const Value: TPoint);

  public
     procedure Draw(grfx : TCanvas);override;
    /// Избран елемент.
    property Selection: TObjectList read FSelection write SetSelection;

    /// Дали в момента диалога е в състояние на "влачене" на избрания елемент.
    property IsDragging : Boolean read FIsDragging write SetIsDragging;

    /// Последна позиция на мишката при "влачене".
    /// Използва се за определяне на вектора на транслация.
    property LastLocation: TPoint read FLastLocation write SetLastLocation;

    constructor Create; virtual;

    procedure NewProject;
    function Rotatefun(p:TPoint; tita:double): TPoint; 
    procedure Rotate(tita:double);   //zavartane
    procedure GroupSelect;         //grupirane
    procedure UnGroup;
    procedure AddRandomRectangle(w:integer; h:integer; f:TColor; bc:TColor); //pravoagalnik
    procedure AddNewRect;
    procedure AddRandomElipse;        //elipsa
    procedure AddRandomtriangle;      //triagalnik
    procedure SetSelectedFillColor(color: TColor);  //izbor na cvqt
    procedure SetSelectedBorderColor(color: TColor); //izbor na cvqt za ramkata
    function ContainsPoint(P : TPoint) : TShapes;
    procedure TranslateTo(P : TPoint); //premestvane na element
  end;

implementation

uses
  Math, Classes,
  RectangleShapeU, ElipseShapeU, TriangleShapeU, RotateU, StrUtils;

{ TDialogProcessor }

/// Добавя примитив - правоъгълник на произволно място върху клиентската област
procedure TDialogProcessor.AddRandomRectangle(w:integer; h:integer; f:TColor; bc:TColor);
var
  x,y{,b} : Integer;
  Rect1 : TRectangleShape;
  BoundingRect : TRect;
begin
  Randomize;
  x := RandomRange(100, 1000);
  y := RandomRange(100, 800);

 // b := 0;

  BoundingRect.TopLeft := Point(x, y);
  BoundingRect.BottomRight := Point(x + w, y + h);
  
   //BoundingRect := Rect(BoundingRect.Left-b,BoundingRect.Top-b,BoundingRect.Left+40+b,BoundingRect.Top+40+b);
  Rect1 := TRectangleShape.Create(BoundingRect);
  
  Rect1.FillColor := f;
  Rect1.BorderColor := bc;
  Rect1.BorderSize := 50;

  
  ShapeList.Add(Rect1);

end;
/// dobavq elipsa
procedure TDialogProcessor.AddRandomElipse;
var
  x,y : Integer;
  El1 : TElipseShape;
  BoundingRect : TRect;
begin
  Randomize;
  x := RandomRange(100, 1000);
  y := RandomRange(100, 800);

  BoundingRect.TopLeft := Point(x, y);
  BoundingRect.BottomRight := Point(x + 100, y + 100);


  El1 := TElipseShape.Create(BoundingRect);
  El1.FillColor := clWhite;

  ShapeList.Add(El1);

end;
/// dobavq triagalnik
procedure TDialogProcessor.AddRandomtriangle;
var
  x,y : Integer;
  T1 : TtriangleShape;
  BoundingRect : TRect;
begin
  Randomize;
  x := RandomRange(100, 1000);
  y := RandomRange(100, 800);

  BoundingRect.TopLeft := Point(x, y);
  BoundingRect.BottomRight := Point(x + 100, y + 100);


  t1 := TtriangleShape.Create(BoundingRect);
  t1.FillColor := clWhite;
  ShapeList.Add(t1);

end;

/// Проверява дали дадена точка е в елемента.
/// Обхожда в ред обратен на визуализацията с цел намиране на
/// "най-горния" елемент т.е. този който виждаме под мишката.
/// P - Указана точка.
/// Връща елемента на изображението, на който принадлежи дадената точка.
function TDialogProcessor.ContainsPoint(P : TPoint): TShapes;
var
  I : Integer;
begin
  for I := ShapeList.Count - 1 downto 0 do
    begin
      if (ShapeList.Items[i] as TShapes).Contains(P) then
        begin
          //(ShapeList.Items[i] as TShapes).BorderColor := clred;
          Result := (ShapeList.Items[i] as TShapes);
          Exit;
        end;
    end;
    Result := nil;
end;

/// Транслация на избраният елемент на вектор определен от P.
/// P - Вектор на транслация.
procedure TDialogProcessor.TranslateTo(P: TPoint);
var
i:Integer;
begin
  for i:=0 to Selection.Count -1 do
  with TShapes(Selection[i]) do
    begin
    //Location := Point(Location.X + P.X - LastLocation.X, Location.Y + P.Y - LastLocation.Y);
   Translate(P.X - LastLocation.X,P.Y - LastLocation.Y);
    end;
  LastLocation := P;
end;



procedure TDialogProcessor.SetSelection(const Value: TObjectList);
begin
  FSelection := Value;
end;

procedure TDialogProcessor.SetIsDragging(const Value: Boolean);
begin
  FIsDragging := Value;
end;

procedure TDialogProcessor.SetLastLocation(const Value: TPoint);
begin
  FLastLocation := Value;
end;

procedure TDialogProcessor.SetSelectedFillColor(color: TColor);
var i:Integer;
begin
for i:=0 to Selection.Count -1 do
with TShapes(Selection[i]) do
begin
FillColor:=Color;
end;
end;

procedure TDialogProcessor.SetSelectedBorderColor(color: TColor);
var
i:Integer;
begin
for i:=0 to Selection.Count -1 do
with TShapes(Selection[i]) do
begin
BorderColor:=Color;
end;
end;

//Sazdavane na punktir za obhvashtane
procedure TDialogProcessor.Draw(grfx: TCanvas);
var
R:TRect; i:Integer;
begin
  inherited;
  if Selection<>nil then
for i:=0 to Selection.Count -1 do
with TShapes(Selection[i]) do
   begin
   R:=Rectangle;
   R.Left:=R.Left -5;
   R.Top:=R.Top -5;
   R.Right:=R.Right +5;
   R.Bottom:=R.Bottom +5;
   grfx.DrawFocusRect(R);
   end;
end;

constructor TDialogProcessor.Create;
begin
inherited;
Selection:=TObjectList.Create(False);
end;


//Grupirane
procedure TDialogProcessor.GroupSelect;
var Group1 : TGroupShape; r:TRect; i:integer; BoundingRect : TRect;
begin
 if Selection.Count > 1 then
  begin
    BoundingRect := (SeLection[0] as TShapes).Rectangle;
    for i:=0 to Selection.Count - 1 do
     begin
      r:= (SeLection[i] as TShapes).Rectangle;
      if r.Left<boundingrect.left then BoundingRect.Left := r.Left;
      if r.Right>boundingrect.Right then BoundingRect.Right := r.Right;
      if r.top<boundingrect.top then BoundingRect.top := r.top;
      if r.Bottom>boundingrect.Bottom then BoundingRect.Bottom := r.Bottom;
     end;

     Group1:=TGroupShape.Create(BoundingRect);
    Group1.Shapes := Selection;
    Selection:= TObjectList.Create(false);
    Selection.Add(Group1);

    for i:=Group1.Shapes.Count - 1 downto 0 do
     ShapeList.Extract(Group1.Shapes.Items[i]);

      ShapeList.Add(Group1);

  end;
end;

function TDialogProcessor.Rotatefun(p:TPoint; tita:double): TPoint;
 var
  sinus, cosinus : Extended;
begin

  SinCos(tita, sinus, cosinus); 

  result.x := Round(p.x*cosinus + p.y*sinus);
  result.y := Round(-p.x*sinus + p.y*cosinus);
 end;

//zavartane
procedure TDialogProcessor.Rotate(tita:double);
var
i:Integer;

 BoundingRect,r : TRect;
 Rect1 : TRotateShape;
begin
  if Selection.Count > 1 then
  begin
    for i:=0 to Selection.Count -1 do
      begin
     r:= (SeLection[i] as TShapes).Rectangle;
     BoundingRect.TopLeft := Rotatefun(r.TopLeft,DegToRad(tita));
     end;
     
     Rect1 :=TRotateShape.Create(BoundingRect);
   {  Rect1.Shapes :=Selection;
     Selection := TObjectList.Create(false);
     Selection.Add(Rect1);
      for i:=Rect1.Shapes.Count - 1 downto 0 do
     ShapeList.Extract(Rect1.Shapes.Items[i]);   }

      ShapeList.Add(Rect1);

        end;
      
    end;

procedure TDialogProcessor.UnGroup;
var Group1 : TUnGroupShape; r:TRect; i:integer; BoundingRect : TRect;
begin

  begin
   //BoundingRect := (SeLection[0] as TShapes).Rectangle;
    for i:=0 to Selection.Count - 1 do
  //  if (Selection.Items[i] as TGroupShape)  then
    with (Selection.Items[i] as TGroupShape) do
     begin
      r:= (SeLection[i] as TShapes).Rectangle;
      if r.Left>boundingrect.left then BoundingRect.Left := r.Left;
      if r.Right<boundingrect.Right then BoundingRect.Right := r.Right;
      if r.top>boundingrect.top then BoundingRect.top := r.top;
      if r.Bottom<boundingrect.Bottom then BoundingRect.Bottom := r.Bottom;
     end;

     Group1:=TUnGroupShape.Create(BoundingRect);
    Group1.Shapes := Selection;
    Selection:= TObjectList.Create(false);
    Selection.Remove(Group1);

    for i:=Group1.Shapes.Count - 1 downto 0 do
     ShapeList.Extract(Group1.Shapes.Items[i]);

      ShapeList.Remove(Group1);

  end;
end;
procedure TDialogProcessor.NewProject;
begin
 ShapeList.Clear;
end;

procedure TDialogProcessor.AddNewRect;
var
  x,y : Integer;
  nw1 : TNewRectShape;
  BoundingRect : TRect;
begin
  Randomize;
  x := RandomRange(100, 1000);
  y := RandomRange(100, 800);

  BoundingRect.TopLeft := Point(x, y);
  BoundingRect.BottomRight := Point(x + 100, y + 100);


  nw1 := TNewRectShape.Create(BoundingRect);
  nw1.FillColor := clWhite;

  ShapeList.Add(nw1);
  end;

end.
