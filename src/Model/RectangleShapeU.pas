unit RectangleShapeU;

interface

uses
  Graphics, Types,
  ShapesU;

type
  /// Класът правоъгълник е основен примитив, който е наследник на базовия TShapes.
  TRectangleShape = class(TShapes)
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
function TRectangleShape.Contains(P : TPoint) : Boolean;
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
procedure TRectangleShape.DrawSelf(grfx: TCanvas);
begin
  inherited;

  grfx.Brush.Color := FillColor;
  grfx.Pen.Color := BorderColor;
  grfx.Rectangle(Rectangle);
end;

end.
