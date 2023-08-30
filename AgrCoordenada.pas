unit AgrCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Objects, FMX.Edit, UtilesLocalizador, UTM_WGS84, FMX.EditBox,
  FMX.NumberBox, FMX.ComboTrackBar;

type
  TFrmAgregar = class(TFrame)
    LayAgrPrinc: TLayout;
    LaySelGPS: TLayout;
    Layout3: TLayout;
    LayGuardarEnBD: TLayout;
    ToolBarAgregar: TToolBar;
    SBVolver: TSpeedButton;
    Label1: TLabel;
    LayGCoords: TLayout;
    LayGuardar: TLayout;
    SBGuardar: TSpeedButton;
    LayDescr: TLayout;
    Label4: TLabel;
    Rectangle1: TRectangle;
    SBSelGPS: TSpeedButton;
    EDescr: TEdit;
    Label5: TLabel;
    Layout10: TLayout;
    SwGuardarBD: TSwitch;
    Rectangle2: TRectangle;
    Label6: TLabel;
    LayTipoCoord: TLayout;
    LGeoUTM: TLabel;
    Layout11: TLayout;
    SwGeoUTM: TSwitch;
    LayCoords: TLayout;
    LayLongitud: TLayout;
    Layout1: TLayout;
    LLon: TLabel;
    Layout6: TLayout;
    ELonEste: TEdit;
    LayLatitud: TLayout;
    Layout7: TLayout;
    LLat: TLabel;
    Layout5: TLayout;
    ELatNorte: TEdit;
    LayHuso: TLayout;
    Layout9: TLayout;
    Label2: TLabel;
    Layout12: TLayout;
    CTBHuso: TComboTrackBar;
    procedure SBVolverClick(Sender: TObject);
    procedure SBGuardarClick(Sender: TObject);
    procedure SBSelGPSClick(Sender: TObject);
    procedure ELonEsteChange(Sender: TObject);
    procedure ELonEsteEnter(Sender: TObject);
    procedure ELonEsteExit(Sender: TObject);
    procedure SwGeoUTMSwitch(Sender: TObject);
  private
    { Private declarations }
    procedure CargarRegCoordenada(Psc: TPosicion);
    procedure GuardarCoordenada;
  public
    { Public declarations }
  end;

implementation

uses DataMod;

{$R *.fmx}

procedure TFrmAgregar.CargarRegCoordenada(Psc: TPosicion);
begin
  Coords.EsteUTM:=Psc.XDest;
  Coords.NorteUTM:=Psc.YDest;
  Coords.Huso:=Psc.Huso;
  Coords.Lat:=Psc.Lat;
  Coords.Lon:=Psc.Lon;
  Coords.LatGMS:=DecAGrados(Psc.Lat,true);
  Coords.LonGMS:=DecAGrados(Psc.Lon,false);
  Coords.Descripcion:=EDescr.Text.Trim;
end;

procedure TFrmAgregar.GuardarCoordenada;
begin
  DMod.Query.SQL.Text:='insert into Coordenadas (EsteUTM,NorteUTM,Huso,Lat,'+
      'Lon,LatGMS,LonGMS,Descripcion) values (:est,:nrt,:hus,:lat,:lon,:ltg,'+
      ':lng,:dsc)';
  DMod.Query.ParamByName('est').AsFloat:=Coords.EsteUTM;
  DMod.Query.ParamByName('nrt').AsFloat:=Coords.NorteUTM;
  DMod.Query.ParamByName('hus').AsByte:=Coords.Huso;
  DMod.Query.ParamByName('lat').AsFloat:=Coords.Lat;
  DMod.Query.ParamByName('lon').AsFloat:=Coords.Lon;
  DMod.Query.ParamByName('ltg').AsString:=Coords.LatGMS;
  DMod.Query.ParamByName('lng').AsString:=Coords.LonGMS;
  DMod.Query.ParamByName('dsc').AsString:=Coords.Descripcion;
  DMod.Query.ExecSQL;
end;

procedure TFrmAgregar.ELonEsteChange(Sender: TObject);
begin
  SBGuardar.Visible:=(ELonEste.Text<>'0') and (ELatNorte.Text<>'0')
      and not ELonEste.Text.IsEmpty and not ELatNorte.Text.IsEmpty;
end;

procedure TFrmAgregar.ELonEsteEnter(Sender: TObject);
begin
  if TEdit(Sender).Text='0' then TEdit(Sender).Text:='';
end;

procedure TFrmAgregar.ELonEsteExit(Sender: TObject);
begin
  if TEdit(Sender).Text='' then TEdit(Sender).Text:='0';
end;

procedure TFrmAgregar.SBGuardarClick(Sender: TObject);
var
  XDest,YDest: double;
  Psc: TPosicion;
  Huso: integer;
begin
  XDest:=ELonEste.Text.ToDouble;
  YDest:=ELatNorte.Text.ToDouble;
  Huso:=Trunc(CTBHuso.Value);
  if SwGeoUTM.IsChecked then Psc:=ConvertirAGrdUTM(XDest,YDest)
                        else Psc:=ConvertirAGrdGeo(XDest,YDest,Huso);
  Posc.XDest:=Psc.XDest;
  Posc.YDest:=Psc.YDest;
  Posc.Huso:=Psc.Huso;
  //se guardan los datos en el archivo .ini:
  Sistema.Lon:=Psc.Lon;
  Sistema.Lat:=Psc.Lat;
  Sistema.X:=Psc.XDest;
  Sistema.Y:=Psc.YDest;
  Sistema.Huso:=Psc.Huso;
  Sistema.Descripcion:=EDescr.Text.Trim;
  //GuardarINI(Trunc(Sistema.X),Trunc(Sistema.Y),EDescr.Text.Trim);
  GuardarINI(Sistema);
  CargarRegCoordenada(Psc); //el registro a guardar en la BD
  if SwGuardarBD.IsChecked then
  begin
    GuardarCoordenada;
    ShowMessage('Coordenada guardada');
  end;
end;

procedure TFrmAgregar.SBSelGPSClick(Sender: TObject);
begin
  ELonEste.FilterChar:='0123456789.-';
  ELatNorte.FilterChar:='0123456789.-';
  if SwGeoUTM.IsChecked then
  begin
    ELonEste.Text:=FormatFloat('0.000000',Posc.Lon);
    ELatNorte.Text:=FormatFloat('0.000000',Posc.Lat);
  end
  else
  begin
    ELonEste.Text:=FormatFloat('0.00',Posc.X);
    ELatNorte.Text:=FormatFloat('0.00',Posc.Y);
  end;
end;

procedure TFrmAgregar.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

procedure TFrmAgregar.SwGeoUTMSwitch(Sender: TObject);
begin
  if SwGeoUTM.IsChecked then
  begin
    LGeoUTM.Text:='Coordenadas Geográficas:';
    LLon.Text:='Longitud:';
    LLat.Text:='Latitud:';
    ELonEste.FilterChar:='0123456789.-';
    ELatNorte.FilterChar:='0123456789.-';
    LayHuso.Visible:=false;
    LayGCoords.Size.Height:=100;
  end
  else
  begin
    LGeoUTM.Text:='Coordenadas UTM:';
    LLon.Text:='Este:';
    LLat.Text:='Norte:';
    ELonEste.FilterChar:='0123456789';
    ELatNorte.FilterChar:='0123456789';
    LayGCoords.Size.Height:=150;
    CTBHuso.Value:=Posc.Huso;
    LayHuso.Visible:=true;
  end;
end;

end.
