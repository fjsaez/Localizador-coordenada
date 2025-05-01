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
    LayTitulo1: TLayout;
    PnlTitulo1: TPanel;
    Label2: TLabel;
    PnlGeneral: TPanel;
    Layout2: TLayout;
    Layout7: TLayout;
    Label4: TLabel;
    Layout8: TLayout;
    SwDistancia: TSwitch;
    LUnidad: TLabel;
    Layout3: TLayout;
    Layout5: TLayout;
    Label3: TLabel;
    Layout6: TLayout;
    EDistMinima: TEdit;
    Layout4: TLayout;
    Layout9: TLayout;
    Label5: TLabel;
    Layout10: TLayout;
    LCoords: TLabel;
    SwFrmCoord: TSwitch;
    LaySep2: TLayout;
    Layout11: TLayout;
    LayTitulo2: TLayout;
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
    Layout16: TLayout;
    Layout17: TLayout;
    Label6: TLabel;
    Layout18: TLayout;
    LSndActivo: TLabel;
    SwSndActivo: TSwitch;
    procedure SBVolverClick(Sender: TObject);
    procedure SwDistanciaSwitch(Sender: TObject);
    procedure SwFrmCoordSwitch(Sender: TObject);
    procedure SwGuardarBDSwitch(Sender: TObject);
    procedure SwPantActivaSwitch(Sender: TObject);
    procedure EDistMinimaEnter(Sender: TObject);
    procedure EDistMinimaExit(Sender: TObject);
    procedure SwSndActivoSwitch(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CargarConfig;
    procedure CargarComps;
  end;

implementation

{$R *.fmx}

procedure TFrmConfig.CargarComps;
begin
  EDistMinima.Text:=Config.DistMinima.ToString;
  SwDistancia.IsChecked:=Config.UnidDistancia;
  SwFrmCoord.IsChecked:=Config.ModoCoord;
  SwGuardarBD.IsChecked:=Config.GuardarEnBD;
  SwPantActiva.IsChecked:=Config.PantActiva;
  SwSndActivo.IsChecked:=Config.SonidoActivo;
end;

procedure TFrmConfig.CargarConfig;
begin
  Config.DistMinima:=EDistMinima.Text.ToInteger;
  Config.UnidDistancia:=SwDistancia.IsChecked;
  Config.ModoCoord:=SwFrmCoord.IsChecked;
  Config.GuardarEnBD:=SwGuardarBD.IsChecked;
  Config.PantActiva:=SwPantActiva.IsChecked;
  Config.SonidoActivo:=SwSndActivo.IsChecked;
  ActivarPantalla(Config.PantActiva);
end;

procedure TFrmConfig.EDistMinimaEnter(Sender: TObject);
begin
  if EDistMinima.Text='0' then EDistMinima.Text:='';
end;

procedure TFrmConfig.EDistMinimaExit(Sender: TObject);
begin
  if EDistMinima.Text='' then EDistMinima.Text:='0';
end;

procedure TFrmConfig.SBVolverClick(Sender: TObject);
begin
  CargarConfig;
  GuardarINI(Sistema,Config);
  Visible:=false;
end;

procedure TFrmConfig.SwDistanciaSwitch(Sender: TObject);
begin
  if SwDistancia.IsChecked then LUnidad.Text:='KMS'
                           else LUnidad.Text:='MTS';
end;

procedure TFrmConfig.SwFrmCoordSwitch(Sender: TObject);
begin
  if SwFrmCoord.IsChecked then LCoords.Text:='GEO'
                          else LCoords.Text:='UTM';
end;

procedure TFrmConfig.SwGuardarBDSwitch(Sender: TObject);
begin
  if SwGuardarBD.IsChecked then LGuardarBD.Text:='SÍ'
                           else LGuardarBD.Text:='NO';
end;

procedure TFrmConfig.SwPantActivaSwitch(Sender: TObject);
begin
  if SwPantActiva.IsChecked then LSiempreAct.Text:='SÍ'
                            else LSiempreAct.Text:='NO';
end;

procedure TFrmConfig.SwSndActivoSwitch(Sender: TObject);
begin
  if SwSndActivo.IsChecked then LSndActivo.Text:='SÍ'
                           else LSndActivo.Text:='NO';
end;

end.
