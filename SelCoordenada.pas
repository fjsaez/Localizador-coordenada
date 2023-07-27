unit SelCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, FMX.Objects, System.Sensors, System.Sensors.Components,
  UTM_WGS84, UtilesLocalizador, FMX.Memo.Types, FMX.Memo, FireDAC.Stan.Param;

type
  TFrmSeleccionar = class(TFrame)
    ToolBar1: TToolBar;
    SBVolver: TSpeedButton;
    LayPrAgregar: TLayout;
    LayGCoords: TLayout;
    LayLongitud: TLayout;
    LayLatitud: TLayout;
    LayGuardar: TLayout;
    LayCoords: TLayout;
    LayLista: TLayout;
    LayDescr: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LLongitud: TLabel;
    LLatitud: TLabel;
    SBGuardar: TSpeedButton;
    RectGrid: TRectangle;
    SGrid: TStringGrid;
    ColDescr: TStringColumn;
    ColID: TIntegerColumn;
    ColGeoSex: TStringColumn;
    ColGeoDec: TStringColumn;
    ColUTM: TStringColumn;
    MmDescr: TMemo;
    procedure SBVolverClick(Sender: TObject);
    procedure SBGuardarClick(Sender: TObject);
    procedure LctSensorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure MmDescrChange(Sender: TObject);
  private
    { Private declarations }
    procedure Guardar;
  public
    { Public declarations }
  end;
var
  UTM: TRecUTM;
  LatLon: TRecLatLon;

implementation

uses DataMod;

{$R *.fmx}

procedure TFrmSeleccionar.Guardar;
begin
  Coords.Descripcion:=Trim(MmDescr.Text);
  Coords.Fecha:=Now;
  DMod.Query.SQL.Text:='insert into Coordenadas (EsteUTM,NorteUTM,Lat,Lon,LatGMS,'+
    'LonGMS,LatLon,Descripcion) values (:esu,:nou,:lat,:lon,:lag,:log,:lln,:dsc)';
  DMod.Query.ParamByName('esu').AsSingle:=Coords.EsteUTM;
  DMod.Query.ParamByName('nou').AsSingle:=Coords.NorteUTM;
  DMod.Query.ParamByName('lat').AsSingle:=Coords.Lat;
  DMod.Query.ParamByName('lon').AsSingle:=Coords.Lon;
  DMod.Query.ParamByName('lag').AsString:=Coords.LatGMS;
  DMod.Query.ParamByName('log').AsString:=Coords.LonGMS;
  DMod.Query.ParamByName('lln').AsString:=Coords.LatLon;
  DMod.Query.ParamByName('dsc').AsString:=Coords.Descripcion;
  DMod.Query.ExecSQL;
  DMod.QrLista.Close;
  ShowMessage('Coordenada agregada');
  SBVolver.OnClick(Self);
end;

procedure TFrmSeleccionar.LctSensorLocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  LatLon.Lat:=NewLocation.Latitude;
  LatLon.Lon:=NewLocation.Longitude;
end;

procedure TFrmSeleccionar.MmDescrChange(Sender: TObject);
begin
  SBGuardar.Enabled:=MmDescr.Text.Trim<>'';
end;

procedure TFrmSeleccionar.SBGuardarClick(Sender: TObject);
var
  PuntoLon,PuntoLat: string;
begin
  if LatLon.Lon>=0 then PuntoLon:=' N'
                   else PuntoLon:=' S';
  if LatLon.Lat>=0 then PuntoLon:=' E'
                   else PuntoLon:=' O';
  //se completa el registro a guardar:
  LatLon_To_UTM(LatLon,UTM);
  Coords.Lat:=LatLon.Lat;
  Coords.Lon:=LatLon.Lon;
  Coords.EsteUTM:=UTM.X;
  Coords.NorteUTM:=UTM.Y;
  Coords.LatGMS:=DecAGrados(Coords.Lat,true);
  Coords.LonGMS:=DecAGrados(Coords.Lon,false);
  Coords.LatLon:=FormatFloat('0.000000',LatLon.Lon)+PuntoLon+','+
                 FormatFloat('0.000000',LatLon.Lat)+PuntoLat;
  Coords.Descripcion:=MmDescr.Text.Trim;
  Coords.Fecha:=Date;
  //se guarda el registro en la BD:
  DMod.Query.SQL.Text:='';
  DMod.Query.ParamByName('');
  DMod.Query.ExecSQL;
  IniciarRegistro;  //se limpia el registro
end;

procedure TFrmSeleccionar.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

end.
