unit DisplayProcessorU;

interface

uses
  Graphics, Types, Classes, ExtCtrls, Contnrs,
  ShapesU;

type
  /// Класът, който ще бъде използван при управляване на дисплейната система.
  TDisplayProcessor = class
  protected
    fShapeList : TObjectList;

  public
    /// Списък с всички елементи формиращи изображението.
    property ShapeList : TObjectList read fShapeList write fShapeList;

    constructor Create;

    procedure ReDraw(Sender : TObject; grfx : TCanvas);
    procedure Draw(grfx : TCanvas);virtual;
    procedure DrawShape(grfx: TCanvas; item: TShapes);
  end;


implementation

{ TDisplayProcessor }

/// Конструктор
constructor TDisplayProcessor.Create;
begin
  ShapeList := TObjectList.Create;
end;

/// Прерисува всички елементи в ShapeList върху grfx
procedure TDisplayProcessor.ReDraw(Sender: TObject; grfx: TCanvas);
begin
  Draw(grfx);
end;

/// Визуализация.
/// Обхождане на всички елементи в списъка и извикване на визуализиращия им метод.
/// grfx - Къде да се извърши визуализацията.
procedure TDisplayProcessor.Draw(grfx: TCanvas);
var
  i : Integer;
begin
  for i := 0 to ShapeList.Count - 1 do
    begin
      DrawShape(grfx, ShapeList.Items[i] as TShapes);
    end;
end;

/// Визуализира даден елемент от изображението.
/// grfx - Къде да се извърши визуализацията.
/// item - Елемент за визуализиране.
procedure TDisplayProcessor.DrawShape(grfx: TCanvas; item: TShapes);
begin
  item.DrawSelf(grfx);
end;

end.
