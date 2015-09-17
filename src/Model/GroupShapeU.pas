unit GroupShapeU;
interface

uses
  Graphics, Types, Contnrs,
  ShapesU;

type
  TGroupShape = class(TShapes)
  fShapes:TObjectList;
  public

    procedure Translate(dx,dy:integer);  override;
    procedure DrawSelf(grfx : TCanvas);override;
    procedure SetFillColor( const Value : TColor); override;
    procedure SetBorderColor( const Value : TColor); override;
    function Contains(P : TPoint) : Boolean; override;
     property Shapes:TObjectList read fShapes write fShapes;

  end;

implementation

uses Math;

function TGroupShape.Contains(P : TPoint) : Boolean;
 var i:Integer;
    begin
    if inherited Contains(P)then
      begin
        for i:=0 to Shapes.Count-1 do
          If(Shapes.items[i] as TShapes).Contains(P) then
            begin
              Result:=true;
              exit;
            end;
          Result:=False;
        end
    else result:=false;
    end;


procedure TGroupShape.DrawSelf(grfx: TCanvas);
 var
  i : Integer;
begin
  for i := 0 to Shapes.Count - 1 do
    begin
      (Shapes.Items[i] as TShapes).DrawSelf(grfx);
      end;
end;


procedure TGroupShape.SetBorderColor(const Value: TColor);
var
  i : Integer;
begin
  for i := 0 to Shapes.Count - 1 do
    begin
      (Shapes.Items[i] as TShapes).BorderColor := value;
      end;
end;

procedure TGroupShape.SetFillColor(const Value: TColor);
var
  i : Integer;
begin
  for i := 0 to Shapes.Count - 1 do
    begin
      (Shapes.Items[i] as TShapes).FillColor := value;
      end;
end;

procedure TGroupShape.Translate(dx,dy:integer);
var
  i : Integer;  P:TPoint;
begin
inherited;
  for i := 0 to Shapes.Count - 1 do
   with TShapes(Shapes.Items[i] as TShapes) do
    begin
      Translate(dx,dy);
      end;
    end;
end.
