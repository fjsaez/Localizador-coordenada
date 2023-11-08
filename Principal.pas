unit Principal;

interface

uses
  {$IF ANDROID}
    FMX.Platform.Android,
  {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.ListBox,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.MultiView,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Types,
  FMX.ActnList, FMX.Objects, FMX.Effects, System.Sensors.Components, System.Math,
  System.Sensors, System.IOUtils, System.Actions, UTM_WGS84, UtilesLocalizador,
  SelCoordenada, AgrCoordenada, Acerca, System.ImageList, FMX.ImgList,
  Configuracion, FMX.Media, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFPrinc = class(TForm)
    LayPrincipal: TLayout;
    ToolBMenu: TToolBar;
    SBMenu: TSpeedButton;
    MultiView: TMultiView;
    LstBoxMenu: TListBox;
    LstBSeleccionar: TListBoxItem;
    LstBSalir: TListBoxItem;
    LstBAcerca: TListBoxItem;
    LctSensor: TLocationSensor;
    LayTop: TLayout;
    LayCentral: TLayout;
    LayBottom: TLayout;
    RectUbicActual: TRectangle;
    RectCentral: TRectangle;
    RectDestino: TRectangle;
    Layout4: TLayout;
    Layout5: TLayout;
    Label1: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    LLonDest: TLabel;
    LEsteDest: TLabel;
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
    LayFlecha: TLayout;
    OrntSensor: TOrientationSensor;
    Timer: TTimer;
    RectFlecha: TRectangle;
    LstBAgregar: TListBoxItem;
    LayDescr: TLayout;
    Layout1: TLayout;
    Label4: TLabel;
    LDescr: TLabel;
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
    FrmAgregar: TFrmAgregar;
    FrmSeleccionar: TFrmSeleccionar;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout24: TLayout;
    Label5: TLabel;
    Layout25: TLayout;
    LZona: TLabel;
    Rectangle1: TRectangle;
    Label14: TLabel;
    Layout26: TLayout;
    Layout27: TLayout;
    Layout28: TLayout;
    LLatDest: TLabel;
    Layout29: TLayout;
    Layout30: TLayout;
    Layout31: TLayout;
    LNorteDest: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ImageList: TImageList;
    LstBConfig: TListBoxItem;
    FrmConfig: TFrmConfig;
    MPlay: TMediaPlayer;
    RectMsj: TRectangle;
    LMensaje: TLabel;
    TimerMsj: TTimer;
    ImgSonido: TImage;
    Layout32: TLayout;
    Layout33: TLayout;
    Layout34: TLayout;
    LayDistancia: TLayout;
    LDistancia: TLabel;
    LayOrientacion: TLayout;
    LDirDestino: TLabel;
    RectVelocidad: TRectangle;
    LVelocidad: TLabel;
    StyleBook: TStyleBook;
    procedure LstBSeleccionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LctSensorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure TimerTimer(Sender: TObject);
    procedure OrntSensorSensorChoosing(Sender: TObject;
      const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
    procedure LctSensorHeadingChanged(Sender: TObject;
      const AHeading: THeading);
    procedure LstBAcercaClick(Sender: TObject);
    procedure FrmAcercaSBVolverClick(Sender: TObject);
    procedure LstBSalirClick(Sender: TObject);
    procedure LstBAgregarClick(Sender: TObject);
    procedure LstBoxMenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FrmAgregarSBVolverClick(Sender: TObject);
    procedure FrmSeleccionarSBVolverClick(Sender: TObject);
    procedure LstBConfigClick(Sender: TObject);
    procedure FrmConfigSBVolverClick(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure TimerMsjTimer(Sender: TObject);
  private
    { Private declarations }
    procedure RotarLetrasPolos(Grados: double);
    procedure MostrarFrame(Frame: TFrame);
    procedure MostrarPrincipal;
    procedure CargarCoordsDestino;
    procedure ActivarMensaje(Activo: boolean);
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;

implementation

uses DataMod;

{$R *.fmx}

procedure TFPrinc.MostrarFrame(Frame: TFrame);
begin
  LayPrincipal.Visible:=false;
  ToolBMenu.Visible:=false;
  Frame.Visible:=true;
end;

procedure TFPrinc.MostrarPrincipal;
begin
  ToolBMenu.Visible:=true;
  LayPrincipal.Visible:=true;
end;

procedure TFPrinc.RotarLetrasPolos(Grados: double);
begin
  //el círculo donde están las letras de polos
  CircPrnc.RotationAngle:=Grados;
  //las letras giran en sentido contrario a la brújula:
  CircN.RotationAngle:=-Grados;
  CircS.RotationAngle:=-Grados;
  CircE.RotationAngle:=-Grados;
  CircO.RotationAngle:=-Grados;
end;

procedure TFPrinc.CargarCoordsDestino;
begin
  LLonDest.Text:=FormatFloat('0.000000',Sistema.Lon);
  LLatDest.Text:=FormatFloat('0.000000',Sistema.Lat);
  LEsteDest.Text:=FormatFloat('0.00',Sistema.X);
  LNorteDest.Text:=FormatFloat('0.00',Sistema.Y);
  LDescr.Text:=Sistema.Descripcion;
  MostrarPrincipal;
end;

procedure TFPrinc.ActivarMensaje(Activo: boolean);
begin
  if RectMsj.Opacity>0 then
    if Activo then
    begin
      ImgSonido.Bitmap.LoadFromFile(TPath.GetDocumentsPath+'/sound_48px.png');
      LMensaje.TextSettings.FontColor:=Verde;
      LMensaje.Text:='Sonido activado';
    end
    else
    begin
      ImgSonido.Bitmap.LoadFromFile(TPath.GetDocumentsPath+'/mute_48px.png');
      LMensaje.TextSettings.FontColor:=Rojo;
      LMensaje.Text:='Sonido desactivado';
    end
  else
  begin
    if Activo then LMensaje.TextSettings.FontColor:=Rojo
              else LMensaje.TextSettings.FontColor:=Verde;
    LMensaje.Text:='';
  end;
end;

/// El menú principal ///

procedure TFPrinc.LstBoxMenuItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Item.IsSelected:=false;
  MultiView.HideMaster;
end;

procedure TFPrinc.LstBSeleccionarClick(Sender: TObject);
begin
  FrmSeleccionar.SBCompartir.Visible:=false;
  FrmSeleccionar.SBEliminar.Visible:=false;
  FrmSeleccionar.CargarLista;
  IniciarRegistro;
  MostrarFrame(FrmSeleccionar);
end;

procedure TFPrinc.LstBAgregarClick(Sender: TObject);
begin
  IniciarRegistro;
  FrmAgregar.SwGeoUTM.IsChecked:=Config.ModoCoord;
  FrmAgregar.SwGuardarBD.IsChecked:=Config.GuardarEnBD;
  FrmAgregar.CTBHuso.Value:=Posc.Huso;
  FrmAgregar.LimpiarComps;
  FrmAgregar.LayResultado.Visible:=false;
  MostrarFrame(FrmAgregar);
end;

procedure TFPrinc.LstBConfigClick(Sender: TObject);
begin
  FrmConfig.CargarComps;
  MostrarFrame(FrmConfig);
end;

procedure TFPrinc.LstBAcercaClick(Sender: TObject);
begin
  MostrarFrame(FrmAcerca);
end;

procedure TFPrinc.LstBSalirClick(Sender: TObject);
begin
  DMod.FDConn.Connected:=false;
  GuardarINI(Sistema,Config);
  {$IF ANDROID}
    MainActivity.Finish
  {$ELSE}
    Application.Terminate;
  {$ENDIF}
end;

/// Eventos ///

procedure TFPrinc.FormCreate(Sender: TObject);
begin
  //borrar luego:
  //DeleteFile(TPath.GetHomePath+'/LocCoord.ini');
  //
  FrmAcerca.Visible:=false;
  FrmAgregar.Visible:=false;
  FrmSeleccionar.Visible:=false;
  FrmConfig.Visible:=false;
  LayPrincipal.Visible:=true;
  IniciarRegistro;
  IniciarRegCoord;
  RectMsj.Opacity:=0;
  MPlay.FileName:=TPath.GetDocumentsPath+'/beep-sound.mp3';
  OrntSensor.Active:=true;        //se activa el sensor de brújula
  MtnSensor.Active:=true;         //se activa el sensor de movimiento
  ActivarGPS(LctSensor,true);     //se activa el sensor de GPS
  TimerMsj.Enabled:=false;
  CrcFlecha.Fill.Bitmap.Bitmap.LoadFromFile(
    TPath.Combine(TPath.GetDocumentsPath,'flc_brujula.png'));
  //se crea/carga el archivo .ini:
  Sistema.ArchivoIni:=TPath.GetHomePath+'/LocCoord.ini';
  if FileExists(Sistema.ArchivoIni) then CargarINI
  else
  begin
    IniciarRegSistema;
    GuardarINI(Sistema,Config);
  end;
  //se carga lo demás:
  ActivarPantalla(Config.PantActiva);
  CargarCoordsDestino;
  Posc.XDest:=Sistema.X;
  Posc.YDest:=Sistema.Y;
  Timer.Enabled:=true;            //se activa el temporizador
end;

procedure TFPrinc.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  //se activa/desactiva el sonido a partir de un doble tap:
  if EventInfo.GestureID=System.UITypes.igiDoubleTap then
  begin
    Config.SonidoActivo:=not Config.SonidoActivo;
    RectMsj.Opacity:=1;
    TimerMsj.Enabled:=RectMsj.Opacity>0;
    GuardarINI(Sistema,Config);
  end;
end;

procedure TFPrinc.FrmAcercaSBVolverClick(Sender: TObject);
begin
  FrmAcerca.SBVolverClick(Sender);
  MostrarPrincipal;
end;

procedure TFPrinc.FrmAgregarSBVolverClick(Sender: TObject);
begin
  FrmAgregar.SBVolverClick(Sender);
  CargarCoordsDestino;
  MostrarPrincipal;
end;

procedure TFPrinc.FrmConfigSBVolverClick(Sender: TObject);
begin
  FrmConfig.SBVolverClick(Sender);
  FrmConfig.CargarConfig;
  MostrarPrincipal;
end;

procedure TFPrinc.FrmSeleccionarSBVolverClick(Sender: TObject);
begin
  FrmSeleccionar.SBVolverClick(Sender);
  CargarCoordsDestino;
  MostrarPrincipal;
end;

procedure TFPrinc.LctSensorHeadingChanged(Sender: TObject;
  const AHeading: THeading);
begin
  Posc.Azimut:=Aheading.Azimuth;
end;

procedure TFPrinc.LctSensorLocationChanged(Sender: TObject; const OldLocation,
  NewLocation: TLocationCoord2D);
var
  CadVelocidad: string;
begin
  Posc:=ConvertirAGrdUTM(NewLocation.Longitude,NewLocation.Latitude);
  Posc.XDest:=Sistema.X;
  Posc.YDest:=Sistema.Y;
  //se muestran las coordenadas en sus diferentes formatos:
  LLonAct.Text:=FormatFloat('0.000000',Posc.Lon);
  LLatAct.Text:=FormatFloat('0.000000',Posc.Lat);
  LEsteAct.Text:=FormatFloat('0.00',Posc.X);
  LNorteAct.Text:=FormatFloat('0.00',Posc.Y);
  LZona.Text:=Posc.Huso.ToString;
  //la velocidad de desplazamiento, en caso de haberla:
  if IsNaN(LctSensor.Sensor.Speed) then CadVelocidad:='0.00'
  else
    CadVelocidad:=FormatFloat('0.00',LctSensor.Sensor.Speed*3.5999999999971);
  LVelocidad.Text:=CadVelocidad+' km/h';
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

procedure TFPrinc.TimerMsjTimer(Sender: TObject);
begin
  RectMsj.Opacity:=RectMsj.Opacity-0.02;
  ActivarMensaje(Config.SonidoActivo);
  TimerMsj.Enabled:=RectMsj.Opacity>0;
end;

procedure TFPrinc.TimerTimer(Sender: TObject);
var
  X,Y,D,Deg,Grd: double;
  Nivel,Ubic,Dist: string;
begin
  //se obtienen los datos para orientar las brújulas:
  X:=OrntSensor.Sensor.HeadingX;
  Y:=OrntSensor.Sensor.HeadingY;
  if Y=0 then D:=Abs(X/1)  //<-- se evita una división por cero
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
  //distancia y grados entre ubicación actual y destino:
  Posc.Distancia:=CalcularDistancia(Posc.X,Posc.Y,Posc.XDest,Posc.YDest);
  Grd:=Grados(Posc.Y,Posc.YDest,Posc.Distancia);
  //se alinea la flecha de búsqueda con la brújula:
  if (Posc.X>Posc.XDest) and (Posc.Y>Posc.YDest) then Grd:=Grd+180
  else
    if (Posc.X>Posc.XDest) and (Posc.Y<Posc.YDest) then Grd:=360-Grd
    else
      if (Posc.X<Posc.XDest) and (Posc.Y>Posc.YDest) then Grd:=180-Grd;
  CrcFlecha.RotationAngle:=Grd+(360-Deg);
  //se colorea la flecha si está dentro de un rango de X mts del objetivo:
  if Posc.Distancia<=Config.DistMinima then Ubic:='crc'    //crc = cerca
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
  GlowEffect.Enabled:=Posc.Distancia<=Config.DistMinima;
  CrcFlecha.Fill.Bitmap.Bitmap.LoadFromFile(
    TPath.Combine(TPath.GetDocumentsPath,'flc_'+Nivel+Ubic+'.png'));
  //los datos de dirección y distancia:
  if Config.UnidDistancia then
    Dist:=FormatFloat('#,##0.00',MetrosToKm(Posc.Distancia))+' km'
  else Dist:=FormatFloat('#,##0.00',Posc.Distancia)+' m';
  LDirActual.Text:=FormatFloat('0.00',Deg)+'º '+Orientacion(Deg);
  LDirDestino.Text:='Dirección: '+Round(Grd).ToString+'º - '+Orientacion(Grd);
  LDistancia.Text:='Dist: '+Dist;
  //se activa/desactiva el audio según esté cerca del punto de destino:
  if Config.SonidoActivo then
    if Posc.Distancia<=Config.DistMinima then MPlay.Play;
end;

end.      //384  383  395  464

{ TODO :
Otras:
- Validar que entren una sola vez los caracteres . y -
- Hacer funcionar el TabOrder en módulo Agregar coordenada
}
