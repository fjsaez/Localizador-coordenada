unit AgrCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, FMX.Objects;

type
  TFrmAgregar = class(TFrame)
    ToolBar1: TToolBar;
    SBVolver: TSpeedButton;
    LayPrAgregar: TLayout;
    LayGCoords: TLayout;
    LayLongitud: TLayout;
    LayLatitud: TLayout;
    LayGuardar: TLayout;
    LayCoords: TLayout;
    LayLista: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LLongitud: TLabel;
    LLatitud: TLabel;
    SBGuardar: TSpeedButton;
    Rectangle1: TRectangle;
    SGrid: TStringGrid;
    ColDescr: TStringColumn;
    ColID: TIntegerColumn;
    ColGeoSex: TStringColumn;
    ColGeoDec: TStringColumn;
    ColUTM: TStringColumn;
    procedure SBVolverClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrmAgregar.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

end.
