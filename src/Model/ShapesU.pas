unit ShapesU;

interface

uses
  Graphics, Types;

type
  /// Базовия клас на примитивите, който съдържа общите характеристики на примитивите.
  TShapes = class
  protected
    fRectangle : TRect;
    fFillColor : TColor;
    fBorderColor : TColor;
    fBorderSize: Integer;

    function GetWidth : Integer;
    function GetHeight : Integer;
    function GetLocation : TPoint;

    procedure SetBorderSize(const Value : Integer); virtual;
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetLocation(const Value: TPoint); virtual;
    procedure SetFillColor(const Value : TColor); virtual;
    procedure SetBorderColor(const Value : TColor); virtual;
    


  public
    constructor Create(Rectangle : TRect);
    procedure Translate(dx,dy:integer); virtual;

    /// Обхващащ правоъгълник на елемента. В случая двата съвпадат.
    property Rectangle : TRect read fRectangle write fRectangle;

    /// Широчина на елемента.
    property Width : Integer read GetWidth write SetWidth;

    /// Височина на елемента.
    property Height : Integer read GetHeight write SetHeight;

    /// Горен ляв ъгъл на елемента.
    property Location : TPoint read GetLocation write SetLocation;


    /// Цвят на елемента.
    property FillColor : TColor read fFillColor write SetFillColor;

      /// Цвят на контура.
    property BorderColor : TColor read fBorderColor write SetBorderColor;

    ///Border Size
    property BorderSize : Integer read fBorderSize write SetBorderSize;

    procedure DrawSelf(grfx : TCanvas); virtual;
    function Contains(P : TPoint) : Boolean; virtual;
    public
//    constructor Create(Rectangle : TRect);

  end;

implementation

{ TShapes }

/// Конструктор
constructor TShapes.Create(Rectangle: TRect);
begin
  Self.Rectangle := Rectangle;
end;

/// Проверка дали точка P принадлежи на елемента.
/// P - Точка.
/// Връща true, ако точката принадлежи на елемента и
/// false, ако не пренадлежи.
function TShapes.Contains(P: TPoint): Boolean;
begin
  Result := (Location.X <= P.X) and (P.X < Location.X + Width) and
            (Location.Y <= P.Y) and (P.Y < Location.Y + Height);
end;

/// Визуализира елемента.
/// grfx - Къде да бъде визуализиран елемента.
procedure TShapes.DrawSelf(grfx: TCanvas);
begin
  //
end;

function TShapes.GetHeight: Integer;
begin
  Result := Rectangle.Bottom - Rectangle.Top;
end;

function TShapes.GetLocation: TPoint;
begin
  Result := Rectangle.TopLeft;
end;

function TShapes.GetWidth: Integer;
begin
  Result := Rectangle.Right - Rectangle.Left;
end;

procedure TShapes.SetFillColor(const Value: TColor);
begin
  fFillColor := Value;
end;

procedure TShapes.SetBorderColor(const Value: TColor);
begin
  fBorderColor := Value;
end;

procedure TShapes.SetHeight(const Value: Integer);
begin
  Rectangle := Rect(Rectangle.Left, Rectangle.Top, Rectangle.Right, Rectangle.Top + Value);
end;

procedure TShapes.SetWidth(const Value: Integer);
begin
  Rectangle := Rect(Rectangle.Left, Rectangle.Top, Rectangle.Left + Value, Rectangle.Bottom);
end;

procedure TShapes.SetLocation(const Value: TPoint);
begin
  Rectangle := Rect(Value.X, Value.Y, Value.X + Width, Value.Y + Height);
end;

procedure TShapes.Translate(dx,dy:integer);
begin                
Location := Point(Location.X+dx,Location.Y+dy);
end;

procedure TShapes.SetBorderSize(const Value: Integer);
begin
  fBorderSize := Value;
end;


end.
























