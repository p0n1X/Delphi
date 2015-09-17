unit NewRectU;

interface

uses
  Graphics, Types, Math,
  ShapesU;

type
  /// Класът правоъгълник е основен примитив, който е наследник на базовия TShapes.
  TNewRectShape = class(TShapes)
  public
    procedure DrawSelf(grfx : TCanvas);override;
    function Contains(P : TPoint) : Boolean; override;
  end;

implementation

/// Проверка за принадлежност на точка P към правоъгълника.
/// В случая на правоъгълник този метод може да не бъде пренаписван, защото
/// Реализацията съвпада с тази на абстрактния клас Shape, който проверява
/// дали точката е в обхващащия правоъгълник на елемента (а той съвпада с
/// елемента в този случай).
function TNewRectShape.Contains(P : TPoint) : Boolean;
begin
  if inherited Contains(P)then
    begin
      // Проверка дали е в обекта само, ако точката е в обхващащия правоъгълник.
      // В случая на правоъгълник - директно връщаме true
      Result := true;
    end
  else
    begin
      // Ако не е в обхващащия правоъгълникр, то неможе да е в обекта и => false
      Result := false;
    end;
end;

{ TRectangleShape }

/// Частта, визуализираща конкретния примитив.
procedure TNewRectShape.DrawSelf(grfx: TCanvas);
var a:array[0..8] of TPoint ;
 
begin

  a[0] := Point(Location.x,Location.y+Height);
  a[1] := Point(Location.x+Width, Location.y+Height);
  a[2] := Point(Location.x+Width, Location.y);
  a[3] := Point(Location.x,Location.y);
  a[4] := Point(Location.x,Location.y+Height);
  a[5] := Point(Location.x+round(Width/2),Location.y+Height);
  a[6] := Point(Location.x+round(Width/2),Location.y+round(Height/2));
  a[7] := Point(Location.x+Width,Location.y+round(Height/2));
  a[8] := Point(Location.x,Location.y+round(Height/2));
  inherited;

  grfx.Brush.Color := FillColor;
  grfx.Pen.Color := BorderColor;
  grfx.Polygon(A);
end;

end.
