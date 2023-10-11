unit Configuracion;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  UtilesLocalizador;

type
  TFrmConfig = class(TFrame)
    LayConfig: TLayout;
    ToolBarConfig: TToolBar;
    SBVolver: TSpeedButton;
    Label1: TLabel;
    LaySep1: TLayout;
    LayGeneral: TLayout;
    LaySep2: TLayout;
    Layout1: TLayout;
    PnlTitulo1: TPanel;
    Label2: TLabel;
    PnlGeneral: TPanel;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Label3: TLabel;
    NBDistMinima: TNumberBox;
    Layout7: TLayout;
    Label4: TLabel;
    Layout8: TLayout;
    Layout9: TLayout;
    Label5: TLabel;
    Layout10: TLayout;
    SwDistancia: TSwitch;
    LUnidad: TLabel;
    LCoords: TLabel;
    SwFrmCoord: TSwitch;
    Layout11: TLayout;
    Layout12: TLayout;
    Panel1: TPanel;
    Label8: TLabel;
    Panel2: TPanel;
    Layout13: TLayout;
    Layout14: TLayout;
    Label9: TLabel;
    Layout15: TLayout;
    SwGuardarBD: TSwitch;
    LGuardarBD: TLabel;
    Layout19: TLayout;
    Layout20: TLayout;
    Label12: TLabel;
    Layout21: TLayout;
    LSiempreAct: TLabel;
    SwPantActiva: TSwitch;
    procedure SBVolverClick(Sender: TObject);
    procedure SwDistanciaSwitch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargarConfig;
  end;

implementation

{$R *.fmx}

procedure TFrmConfig.CargarConfig;
begin
  Config.DistMinima:=Trunc(NBDistMinima.Value);
  Config.UnidDistancia:=SwDistancia.IsChecked;
  Config.ModoCoord:=SwFrmCoord.IsChecked;
  Config.GuardarEnBD:=SwGuardarBD.IsChecked;
  Config.PantActiva:=SwPantActiva.IsChecked;
end;

procedure TFrmConfig.SBVolverClick(Sender: TObject);
begin
  CargarConfig;
  Visible:=false;
end;

procedure TFrmConfig.SwDistanciaSwitch(Sender: TObject);
begin
  if SwDistancia.IsChecked then LUnidad.Text:=''
                           else LUnidad.Text:=''
end;

end.
