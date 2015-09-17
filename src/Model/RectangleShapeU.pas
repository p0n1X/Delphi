unit RectangleShapeU;

interface

uses
  Graphics, Types,
  ShapesU;

type
  /// ������ ������������ � ������� ��������, ����� � ��������� �� ������� TShapes.
  TRectangleShape = class(TShapes)
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
function TRectangleShape.Contains(P : TPoint) : Boolean;
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
procedure TRectangleShape.DrawSelf(grfx: TCanvas);
begin
  inherited;

  grfx.Brush.Color := FillColor;
  grfx.Pen.Color := BorderColor;
  grfx.Rectangle(Rectangle);
end;

end.
