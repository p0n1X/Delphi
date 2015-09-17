unit TriangleShapeU;

interface

uses
  Graphics, Types,
  ShapesU;

type
  TTriangleShape = class(TShapes)
  public
    procedure DrawSelf(grfx : TCanvas);override;
    function Contains(P : TPoint) : Boolean; override;
  end;

implementation

function TTriangleShape.Contains(P : TPoint) : Boolean;
begin
  if inherited Contains(P)then
    begin
      Result := true;
    end
  else
    begin
     Result := false;
    end;
end;



procedure TTriangleShape.DrawSelf(grfx: TCanvas);
 var a:array[0..3] of TPoint ;
 
begin
  a[0] := Point(Location.x,Location.y+Height);
  a[1] := Point(Location.x+Width, Location.y+Height);
  a[2] := Point(Location.x+50, Location.y);
  a[3] := Point(Location.x,Location.y+Height);
  inherited;

  grfx.Brush.Color := FillColor;
  grfx.Pen.Color := BorderColor;
  grfx.Polygon(A);
end;

end.
