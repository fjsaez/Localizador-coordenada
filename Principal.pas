unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.MultiView,
  FMX.ListBox, AgrCoordenada, System.Sensors, System.Sensors.Components,
  UtilesLocalizador, FMX.Objects;

type
  TFPrinc = class(TForm)
    LayPrincipal: TLayout;
    ToolBar1: TToolBar;
    SBMenu: TSpeedButton;
    MultiView: TMultiView;
    LstBoxMenu: TListBox;
    LstBuscar: TListBoxItem;
    LstBGuardar: TListBoxItem;
    LstBSalir: TListBoxItem;
    LstBAcerca: TListBoxItem;
    FrmAgregarPnc: TFrmAgregar;
    LctSensor: TLocationSensor;
    LayTop: TLayout;
    LayCentral: TLayout;
    LayBottom: TLayout;
    Rectangle1: TRectangle;
    RectCentral: TRectangle;
    Rectangle3: TRectangle;
    Layout4: TLayout;
    Layout5: TLayout;
    Label1: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    LLonLoc: TLabel;
    LLatLoc: TLabel;
    CrcFlecha: TCircle;
    LayIndicadores: TLayout;
    Rectangle4: TRectangle;
    Layout2: TLayout;
    Label6: TLabel;
    Layout3: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Label7: TLabel;
    Layout14: TLayout;
    LLonAct: TLabel;
    Layout15: TLayout;
    Layout16: TLayout;
    Label9: TLabel;
    Layout17: TLayout;
    LEsteAct: TLabel;
    Layout18: TLayout;
    Layout19: TLayout;
    Label11: TLabel;
    Layout20: TLayout;
    LLatAct: TLabel;
    Layout21: TLayout;
    Layout22: TLayout;
    Label13: TLabel;
    Layout23: TLayout;
    LNorteAct: TLabel;
    LayOrientacion: TLayout;
    LayDistancia: TLayout;
    Layout26: TLayout;
    LOrientacion: TLabel;
    LDistancia: TLabel;
    OrntSensor: TOrientationSensor;
    procedure LstBGuardarClick(Sender: TObject);
    procedure FrmAgregarPncSBVolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;

implementation

{$R *.fmx}

procedure TFPrinc.FormCreate(Sender: TObject);
begin
  FrmAgregarPnc.Visible:=false;   //ocultar las pantallas secundarias
  LayPrincipal.Visible:=true;     //poner visible la pantalla principal
  OrntSensor.Active:=true;        //se activa el sensor de brújula
  LctSensor.Active:=true;         //se activa el sensor de GPS
end;

procedure TFPrinc.FrmAgregarPncSBVolverClick(Sender: TObject);
begin
  FrmAgregarPnc.SBVolverClick(Sender);
  LayPrincipal.Visible:=true;
end;

procedure TFPrinc.LstBGuardarClick(Sender: TObject);
begin
  LayPrincipal.Visible:=false;
  FrmAgregarPnc.Visible:=true;
  IniciarRegistro;
end;

end.
