unit RotateU;
interface

uses
  Graphics, Types, Contnrs,
  ShapesU;

type
  TRotateShape = class(TShapes)
  fShapes:TObjectList;
  public
    procedure DrawSelf(grfx : TCanvas);override;
    function Contains(P : TPoint) : Boolean; override;
      property Shapes:TObjectList read fShapes write fShapes;
  end;

implementation


function TRotateShape.Contains(P : TPoint) : Boolean;
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


procedure TRotateShape.DrawSelf(grfx: TCanvas);
 var
  i : Integer;
begin
  for i := 0 to Shapes.Count - 1 do
    begin
      (Shapes.Items[i] as TShapes).DrawSelf(grfx);
      end;
      end;
end.
