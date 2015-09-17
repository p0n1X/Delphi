unit NewRectU;

interface

uses
  Graphics, Types, Math,
  ShapesU;

type
  /// ������ ������������ � ������� ��������, ����� � ��������� �� ������� TShapes.
  TNewRectShape = class(TShapes)
  public
    procedure DrawSelf(grfx : TCanvas);override;
    function Contains(P : TPoint) : Boolean; override;
  end;

implementation

/// �������� �� ������������� �� ����� P ��� �������������.
/// � ������ �� ������������ ���� ����� ���� �� �� ���� �����������, ������
/// ������������ ������� � ���� �� ����������� ���� Shape, ����� ���������
/// ���� ������� � � ���������� ������������ �� �������� (� ��� ������� �
/// �������� � ���� ������).
function TNewRectShape.Contains(P : TPoint) : Boolean;
begin
  if inherited Contains(P)then
    begin
      // �������� ���� � � ������ ����, ��� ������� � � ���������� ������������.
      // � ������ �� ������������ - �������� ������� true
      Result := true;
    end
  else
    begin
      // ��� �� � � ���������� �������������, �� ������ �� � � ������ � => false
      Result := false;
    end;
end;

{ TRectangleShape }

/// ������, ������������� ���������� ��������.
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
