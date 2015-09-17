unit DisplayProcessorU;

interface

uses
  Graphics, Types, Classes, ExtCtrls, Contnrs,
  ShapesU;

type
  /// ������, ����� �� ���� ��������� ��� ����������� �� ����������� �������.
  TDisplayProcessor = class
  protected
    fShapeList : TObjectList;

  public
    /// ������ � ������ �������� ��������� �������������.
    property ShapeList : TObjectList read fShapeList write fShapeList;

    constructor Create;

    procedure ReDraw(Sender : TObject; grfx : TCanvas);
    procedure Draw(grfx : TCanvas);virtual;
    procedure DrawShape(grfx: TCanvas; item: TShapes);
  end;


implementation

{ TDisplayProcessor }

/// �����������
constructor TDisplayProcessor.Create;
begin
  ShapeList := TObjectList.Create;
end;

/// ��������� ������ �������� � ShapeList ����� grfx
procedure TDisplayProcessor.ReDraw(Sender: TObject; grfx: TCanvas);
begin
  Draw(grfx);
end;

/// ������������.
/// ��������� �� ������ �������� � ������� � ��������� �� �������������� �� �����.
/// grfx - ���� �� �� ������� ��������������.
procedure TDisplayProcessor.Draw(grfx: TCanvas);
var
  i : Integer;
begin
  for i := 0 to ShapeList.Count - 1 do
    begin
      DrawShape(grfx, ShapeList.Items[i] as TShapes);
    end;
end;

/// ����������� ����� ������� �� �������������.
/// grfx - ���� �� �� ������� ��������������.
/// item - ������� �� �������������.
procedure TDisplayProcessor.DrawShape(grfx: TCanvas; item: TShapes);
begin
  item.DrawSelf(grfx);
end;

end.
