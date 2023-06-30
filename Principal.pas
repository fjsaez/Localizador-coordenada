unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.MultiView,
  FMX.ListBox, AgrCoordenada, System.Sensors, System.Sensors.Components,
  UtilesLocalizador, FMX.Objects, System.Math, UTM_WGS84;

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
    Timer: TTimer;
    procedure LstBGuardarClick(Sender: TObject);
    procedure FrmAgregarPncSBVolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LctSensorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;
  Posc: TPosicion;

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

procedure TFPrinc.LctSensorLocationChanged(Sender: TObject; const OldLocation,
  NewLocation: TLocationCoord2D);
var
  LatLon: TRecLatLon;
  UTM: TRecUTM;
begin
  LatLon.Lon:=NewLocation.Longitude;
  LatLon.Lat:=NewLocation.Latitude;
  LatLon_To_UTM(LatLon,UTM);
  Posc.X:=UTM.X;
  Posc.Y:=UTM.Y;
  Posc.Lon:=NewLocation.Longitude;
  Posc.Lat:=NewLocation.Latitude;
  LCoord.Text:=FormatFloat('0.00',Posc.X)+' E - '+FormatFloat('0.00',Posc.Y)+' N';
end;

procedure TFPrinc.LstBGuardarClick(Sender: TObject);
begin
  LayPrincipal.Visible:=false;
  FrmAgregarPnc.Visible:=true;
  IniciarRegistro;
end;

procedure TFPrinc.TimerTimer(Sender: TObject);
var
  X,Y,D,Deg,X2,Y2,Grd: double;
begin
  X:=OrntSensor.Sensor.HeadingX;
  Y:=OrntSensor.Sensor.HeadingY;
  if Y=0 then D:=Abs(X/1)  //se evita una división por cero
         else D:=Abs(X/Y);
  Deg:=RadToDeg(ArcTan(D));
  if (Y>=0) and (X<=0) then Deg:=Deg
  else
    if (Y<0) and (X<=0) then Deg:=180-Deg
    else
      if (Y<0) then Deg:=180+Deg
      else
        if (Y>=0) and (X>0) then Deg:=360-Deg;
  CrcBujula.RotationAngle:=360-Deg;
  Posc.Distancia:=CalcularDistancia(Posc.X,Posc.Y,Posc.XDest,Posc.YDest);
  Grd:=Grados(Posc.Y,Posc.YDest,Posc.Distancia);

  if (Posc.X>Posc.XDest) and (Posc.Y>Posc.YDest) then Grd:=Grd+180
  else
    if (Posc.X>Posc.XDest) and (Posc.Y<Posc.YDest) then Grd:=360-Grd
    else
      if (Posc.X<Posc.XDest) and (Posc.Y>Posc.YDest) then Grd:=180-Grd
      else
        if (Posc.X<Posc.XDest) and (Posc.Y<Posc.YDest) then Grd:=Grd;

  CrcFlecha.RotationAngle:=Grd+(360-Deg);
  LOrntBrj.Text:='Orientación: '+FormatFloat('0.00',CrcBujula.RotationAngle)+
                 'º '+Orientacion(CrcBujula.RotationAngle);
  LOrientacion.Text:=Round(Grd).ToString+'º - '+Orientacion(Grd);
  LDistancia.Text:=FormatFloat('#,##0.00',Posc.Distancia)+' mts';
  //se indica si la brújula está nivelada o no:
  if EstaNivelado(MtnSensor,0.2) then
  begin
    LNivel.TextSettings.FontColor:=Chartreuse;
    LNivel.Text:='NIVELADO'
  end
  else
  begin
    LNivel.TextSettings.FontColor:=Blanco;
    LNivel.Text:='NO nivelado';
  end;
end;

end.
