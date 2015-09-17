unit ElipseShapeU;

interface

uses
  Graphics, Types,
  ShapesU;

type
  TElipseShape = class(TShapes)
  public
    procedure DrawSelf(grfx : TCanvas);override;
    function Contains(P : TPoint) : Boolean; override;
  end;

implementation


function TElipseShape.Contains(P : TPoint) : Boolean;
begin
  if inherited Contains(P)then
    begin
      // Проверка дали е в обекта само, ако точката е в обхващащия правоъгълник.
      // В случая на правоъгълник - директно връщаме true
      Result := sqr((p.X-(Location.x+(Width/2)))/(Width/2))+
      sqr((p.Y-(Location.Y+(Height/2)))/(Height/2))-1 <=0;
    end
  else
    begin
      // Ако не е в обхващащия правоъгълникр, то неможе да е в обекта и => false
      Result := false;
    end;
end;


procedure TElipseShape.DrawSelf(grfx: TCanvas);
begin
  inherited;

  grfx.Brush.Color := FillColor;
  grfx.Pen.Color := BorderColor;
  grfx.Ellipse(Rectangle);
end;

end.
