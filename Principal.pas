unit Principal;

interface

uses
  {$IF ANDROID}
    FMX.Platform.Android,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.MultiView,
  FMX.ListBox, AgrCoordenada, System.Sensors, System.Sensors.Components,
  UtilesLocalizador, FMX.Objects, System.Math, UTM_WGS84, FMX.Effects,
  System.IOUtils, Acerca;

type
  TFPrinc = class(TForm)
    LayPrincipal: TLayout;
    ToolBMenu: TToolBar;
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
    RectCoordAct: TRectangle;
    LayBrujula: TLayout;
    LayCoordsAct: TLayout;
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
    LayFlecha: TLayout;
    LDirDestino: TLabel;
    LDistancia: TLabel;
    OrntSensor: TOrientationSensor;
    Timer: TTimer;
    RectFlecha: TRectangle;
    LstBAgregar: TListBoxItem;
    LayDescr: TLayout;
    Layout1: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    SBSalir: TSpeedButton;
    MtnSensor: TMotionSensor;
    GlowEffect: TGlowEffect;
    CircPrnc: TCircle;
    CircN: TCircle;
    Label6: TLabel;
    CircS: TCircle;
    Label8: TLabel;
    CircE: TCircle;
    Label10: TLabel;
    CircO: TCircle;
    Label12: TLabel;
    CrcBrujula: TCircle;
    LayDirActual: TLayout;
    LDirActual: TLabel;
    SBAcerca: TSpeedButton;
    FrmAcerca: TFrmAcerca;
    procedure LstBGuardarClick(Sender: TObject);
    procedure FrmAgregarPncSBVolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LctSensorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure TimerTimer(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure OrntSensorSensorChoosing(Sender: TObject;
      const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
    procedure LctSensorHeadingChanged(Sender: TObject;
      const AHeading: THeading);
    procedure LstBAcercaClick(Sender: TObject);
    procedure SBAcercaClick(Sender: TObject);
    procedure FrmAcercaSBVolverClick(Sender: TObject);
  private
    { Private declarations }
    procedure RotarLetrasPolos(Grados: double);
    procedure MostrarFrame(Frame: TFrame);
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;
  Posc: TPosicion;

implementation

{$R *.fmx}

procedure TFPrinc.MostrarFrame(Frame: TFrame);
begin
  LayPrincipal.Visible:=false;
  Frame.Visible:=true;
end;

// El menú principal

procedure TFPrinc.LstBAcercaClick(Sender: TObject);
begin
  {LayPrincipal.Visible:=false;
  FrmAcerca.Visible:=true;}
  MostrarFrame(FrmAcerca);
end;

procedure TFPrinc.LstBGuardarClick(Sender: TObject);
begin
  {LayPrincipal.Visible:=false;
  FrmAgregarPnc.Visible:=true;}
  MostrarFrame(FrmAgregarPnc);
  IniciarRegistro;
end;

// fin menú

procedure TFPrinc.FormCreate(Sender: TObject);
begin
  FrmAgregarPnc.Visible:=false;   //ocultar las pantallas secundarias
  LayPrincipal.Visible:=true;     //poner visible la pantalla principal
  OrntSensor.Active:=true;        //se activa el sensor de brújula
  MtnSensor.Active:=true;         //se activa el sensor de movimiento
  ActivarGPS(LctSensor,true);     //se activa el sensor de GPS
  Timer.Enabled:=true;            //se activa el temporizador
  CrcFlecha.Fill.Bitmap.Bitmap.LoadFromFile(
    TPath.Combine(TPath.GetDocumentsPath,'flc_brujula.png'));
end;

procedure TFPrinc.FrmAcercaSBVolverClick(Sender: TObject);
begin
  FrmAcerca.SBVolverClick(Sender);
  LayPrincipal.Visible:=true;
end;

procedure TFPrinc.FrmAgregarPncSBVolverClick(Sender: TObject);
begin
  FrmAgregarPnc.SBVolverClick(Sender);
  LayPrincipal.Visible:=true;
end;

procedure TFPrinc.LctSensorHeadingChanged(Sender: TObject;
  const AHeading: THeading);
begin
  Posc.Azimut:=Aheading.Azimuth;
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
  //se muestran las coordenadas en sus diferentes formatos:
  LLonAct.Text:=FormatFloat('0.000000',Posc.Lon);
  LLatAct.Text:=FormatFloat('0.000000',Posc.Lat);
  LEsteAct.Text:=FormatFloat('0.00',Posc.X);
  LNorteAct.Text:=FormatFloat('0.00',Posc.Y);
end;

procedure TFPrinc.OrntSensorSensorChoosing(Sender: TObject;
  const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
var
  Indice,I: integer;
begin
  Indice:=-1;
  for I := 0 to High(Sensors) do
    if (TCustomOrientationSensor.TProperty.HeadingX in
         TCustomOrientationSensor(Sensors[I]).AvailableProperties) then
    begin
      Indice:=I;
      Break;
    end;
  ChoseSensorIndex:=Indice;
end;

procedure TFPrinc.SBAcercaClick(Sender: TObject);
begin
  MostrarFrame(FrmAcerca);
end;

procedure TFPrinc.SBSalirClick(Sender: TObject);
begin
  {$IF ANDROID}
    MainActivity.Finish
  {$ELSE}
    Application.Terminate;
  {$ENDIF}
end;

procedure TFPrinc.RotarLetrasPolos(Grados: double);
begin
  CircPrnc.RotationAngle:=Grados;  //el círculo donde están las letras de polos
  //las letras giran en sentido contrario a la brújula:
  CircN.RotationAngle:=-Grados;
  CircS.RotationAngle:=-Grados;
  CircE.RotationAngle:=-Grados;
  CircO.RotationAngle:=-Grados;
end;

procedure TFPrinc.TimerTimer(Sender: TObject);
var
  X,Y,D,Deg,Grd: double;
  Nivel,Ubic: string;
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
  RotarLetrasPolos(360-Deg);
  Posc.Distancia:=CalcularDistancia(Posc.X,Posc.Y,Posc.XDest,Posc.YDest);
  Grd:=Grados(Posc.Y,Posc.YDest,Posc.Distancia);
  //se alinea la flecha de búsqueda con la brújula:
  if (Posc.X>Posc.XDest) and (Posc.Y>Posc.YDest) then Grd:=Grd+180
  else
    if (Posc.X>Posc.XDest) and (Posc.Y<Posc.YDest) then Grd:=360-Grd
    else
      if (Posc.X<Posc.XDest) and (Posc.Y>Posc.YDest) then Grd:=180-Grd;
  CrcFlecha.RotationAngle:=Grd+(360-Deg);
  //los datos de dirección y distancia:
  LDirActual.Text:=FormatFloat('0.00',Deg)+'º '+Orientacion(Deg);
  LDirDestino.Text:='Dirección: '+Round(Grd).ToString+'º - '+Orientacion(Grd);
  LDistancia.Text:='Distancia: '+FormatFloat('#,##0.00',Posc.Distancia)+' m';
  //se colorea la flecha si está dentro de un rango de 15 mts del objetivo:
  if Posc.Distancia<=15 then Ubic:='crc'    //crc = cerca
                        else Ubic:='ljs';   //ljs = lejos
  //se indica si la brújula está nivelada o no:
  if EstaNivelado(MtnSensor,0.2) then
  begin
    CrcBrujula.Stroke.Color:=Chartreuse;
    Nivel:='niv_';     //niv = nivelado
  end
  else
  begin
    CrcBrujula.Stroke.Color:=Rojo;
    Nivel:='noniv_';   //noniv = no nivelado
  end;
  //se muestra la flecha indicadora según el nivel y cercanía:
  GlowEffect.Enabled:=Posc.Distancia<=15.0;
  CrcFlecha.Fill.Bitmap.Bitmap.LoadFromFile(
    TPath.Combine(TPath.GetDocumentsPath,'flc_'+Nivel+Ubic+'.png'));
end;

end.
