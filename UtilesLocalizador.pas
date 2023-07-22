unit UtilesLocalizador;

interface

uses
  {$IFDEF ANDROID}
  FMX.FontGlyphs.Android,
  {$ENDIF}
  FMX.Forms, FMX.Objects, FMX.StdCtrls, FMX.Graphics, FMX.DialogService,
  System.Sensors.Components, System.SysUtils, System.Classes, System.Types,
  System.Permissions, System.Math, System.IniFiles;

type
  TCoord = record
    IDCoord: Cardinal;
    EsteUTM,NorteUTM,Lat,Lon: single;
    LatGMS,LonGMS,LatLon,Descripcion: string;
    Fecha: TDate;
  end;

  TPosicion = record
    Lat,Lon,        //coords geográficas
    X,Y,            //coords UTM
    XDest,YDest,    //coords UTM destino
    Azimut,Distancia: double;
  end;

  TSistema = record
    X,Y: double;
    ArchivoINI: string;
  end;

const
  Blanco=4294967295;
  Negro=4278190080;
  Lima=4278255360;
  Chartreuse=$FF7FFF00;
  Rojo=$FFFF0000;
  //ArchivoINI='/LocSimple.ini';

var
  Coords: TCoord;
  Posc: TPosicion;
  Sistema: TSistema;

  function Grados(Norte1,Norte2,DistH: double): double;
  function CalcularDistancia(X1,Y1,X2,Y2: double): double;
  function Orientacion(Grados: double): string;
  procedure RotarFlecha(Circulo: TCircle; Azimut: Double);
  function EstaNivelado(MSensor: TMotionSensor; Rng: single): boolean;
  procedure CargarFuente(Etq: TLabel);
  procedure ActivarGPS(LcSensor: TLocationSensor; Activo: boolean);
  procedure IniciarRegistro;
  procedure IniciarRegCoord;
  procedure CargarINI;
  procedure GuardarINI(X,Y: integer);

implementation

function CalcularDistancia(X1,Y1,X2,Y2: double): double;
begin
  Result:=Sqrt(Sqr(Abs(X1-X2))+Sqr(Abs(Y1-Y2)));
end;

function Grados(Norte1,Norte2,DistH: double): double;
begin
  if DistH>0 then Result:=RadToDeg(ArcCos(Abs(Norte1-Norte2)/DistH))
             else Result:=0;
end;

{Devuelve el azimut y orientación según los grados}
function Orientacion(Grados: double): string;
begin
  case Round(Grados) of
    0..10,350..360: Result:='N';  //norte
    11..34: Result:='N - NE';     //norte-noreste
    35..54: Result:='NE';         //noreste
    55..79: Result:='E - NE';     //este-noreste
    80..100: Result:='E';         //este
    101..124: Result:='E - SE';   //este-sureste
    125..144: Result:='SE';       //sureste
    145..169: Result:='S - SE';   //sur-sureste
    170..190: Result:='S';        //sur
    191..214: Result:='S - SW';   //sur-suroeste
    215..234: Result:='SW';       //suroeste
    235..259: Result:='W - SW';   //oeste-suroeste
    260..280: Result:='W';        //oeste
    281..304: Result:='W - NW';   //oeste-noroeste
    305..324: Result:='NW';       //noroeste
    325..349: Result:='N - NW';   //norte-noroeste
  end;
end;

procedure RotarFlecha(Circulo: TCircle; Azimut: Double);
var
  I,AntGrados,NvoGrados,Diferencia: Word;

  procedure MoverFlecha(I: word);
  begin
    Application.ProcessMessages;
    Sleep(50);
    Circulo.RotationAngle:=I;
  end;

begin
  if Round(Circulo.RotationAngle)=0 then AntGrados:=360
  else AntGrados:=Round(Circulo.RotationAngle);
  if Azimut=0 then NvoGrados:=360
              else NvoGrados:=Round(Azimut);
  Diferencia:=Abs(NvoGrados-AntGrados);
  if Diferencia<=180 then
  begin
    if NvoGrados>AntGrados then
      for I:=AntGrados to NvoGrados do MoverFlecha(I)
    else
      for I:=AntGrados downto NvoGrados do MoverFlecha(I);
  end
  else
  begin
    Circulo.RotationAngle:=AntGrados+NvoGrados;
    if AntGrados>NvoGrados then
      for I:=AntGrados to 360+NvoGrados do MoverFlecha(I)
    else
      for I:=AntGrados downto NvoGrados do MoverFlecha(I)
  end;
end;

function EstaNivelado(MSensor: TMotionSensor; Rng: single): boolean;
var
  X,Y: double;
begin
  X:=MSensor.Sensor.AccelerationX;
  Y:=MSensor.Sensor.AccelerationY;
  Result:=((X>=-Rng) and (X<=Rng)) and ((Y>=-Rng) and (Y<=Rng));
end;

procedure CargarFuente(Etq: TLabel);
var
  Recursos: TResourceStream;
  Fuente: TFont;
begin
  Fuente:=TFont.Create;
  Recursos:=TResourceStream.Create(hInstance,'1',RT_RCDATA);
end;

{Activa/desactiva el GPS del teléfono móvil}
procedure ActivarGPS(LcSensor: TLocationSensor; Activo: boolean);
const
  PermissionAccessFineLocation='android.permission.ACCESS_FINE_LOCATION';
begin
  PermissionsService.RequestPermissions([PermissionAccessFineLocation],
    procedure(const APermissions: TClassicStringDynArray;
              const AGrantResults: TClassicPermissionStatusDynArray)
    begin
      if (Length(AGrantResults)=1) and (AGrantResults[0]=TPermissionStatus.Granted) then
        LcSensor.Active:=Activo
      else
      begin
        Activo:=false;
        TDialogService.ShowMessage('Permiso a Localización no concedido');
      end;
    end);
end;

{Inicializa el registro de los datos de las coordenadas}
procedure IniciarRegistro;
begin
  Coords.IDCoord:=0;
  Coords.EsteUTM:=0.0;
  Coords.NorteUTM:=0.0;
  Coords.Lat:=0.0;
  Coords.Lon:=0.0;
  Coords.LatGMS:='';
  Coords.LonGMS:='';
  Coords.LatLon:='';
  Coords.Descripcion:='';
  Coords.Fecha:=Date;
end;

procedure IniciarRegCoord;
begin
  Posc.Lat:=0.0;
  Posc.Lon:=0.0;
  Posc.X:=0.0;
  Posc.Y:=0.0;
  Posc.XDest:=0.0;
  Posc.XDest:=0.0;
  Posc.Azimut:=0.0;
  Posc.Distancia:=0.0;
end;

{Lee los valores guardados del respectivo archivo .ini}
procedure CargarINI;
var
  Ini: TIniFile;
begin
  try
    Ini:=TIniFile.Create(Sistema.ArchivoINI);
    Sistema.X:=Ini.ReadString('Valor','Este','').ToInteger;
    Sistema.Y:=Ini.ReadString('Valor','Norte','').ToInteger;
  finally
    Ini.Free;
  end;
end;

{Crea el archivo ini con los el valor del zoom}
procedure GuardarINI(X,Y: integer);
var
  Ini: TIniFile;
begin
  try
    Ini:=TIniFile.Create(Sistema.ArchivoIni);
    Ini.WriteString('Valor','Este',X.ToString);
    Ini.WriteString('Valor','Norte',Y.ToString);
    Sistema.X:=Ini.ReadString('Valor','Este','').ToInteger;
    Sistema.Y:=Ini.ReadString('Valor','Norte','').ToInteger;
  finally
    Ini.Free;
  end;
end;

end.

//uses
  //System.Permissions, FMX.DialogService;

/// Útiles ///

{function MetrosToKm(DistMetros: single): single;
begin
  Result:=DistMetros/1000;
end;

function Sentido(Este1,Norte1,Este2,Norte2: Double): string;
var
  Cad: string;
begin
  if (Norte1<Norte2) and (Este1=Este2) then Cad:='N';
  if (Norte1>Norte2) and (Este1=Este2) then Cad:='S';
  if (Norte1=Norte2) and (Este1<Este2) then Cad:='E';
  if (Norte1=Norte2) and (Este1>Este2) then Cad:='O';
  if (Norte1<Norte2) and (Este1<Este2) then Cad:='N - E';
  if (Norte1<Norte2) and (Este1>Este2) then Cad:='N - O';
  if (Norte1>Norte2) and (Este1<Este2) then Cad:='S - E';
  if (Norte1>Norte2) and (Este1>Este2) then Cad:='S - O';
  Result:=Cad;
end;}
