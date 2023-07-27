unit AgrCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo;

type
  TFrmAgregar = class(TFrame)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    ToolBar1: TToolBar;
    SBVolver: TSpeedButton;
    Label1: TLabel;
    LayGCoords: TLayout;
    LayGuardar: TLayout;
    SBGuardar: TSpeedButton;
    LayCoords: TLayout;
    LayLongitud: TLayout;
    Label2: TLabel;
    LLongitud: TLabel;
    LayLatitud: TLayout;
    Label3: TLabel;
    LLatitud: TLabel;
    LayDescr: TLayout;
    MmDescr: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
