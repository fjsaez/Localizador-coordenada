unit AgrCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Objects, FMX.Edit, UtilesLocalizador, UTM_WGS84, FMX.EditBox,
  FMX.NumberBox, FMX.ComboTrackBar, FireDAC.Stan.Param, FMX.DialogService,
  FMX.TabControl;

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
    LayResultado: TLayout;
    Layout4: TLayout;
    LayResHuso: TLayout;
    LResHuso: TLabel;
    Layout8: TLayout;
    LResLonEste: TLabel;
    Layout13: TLayout;
    LResLatNorte: TLabel;
    procedure SBVolverClick(Sender: TObject);
    procedure SBGuardarClick(Sender: TObject);
    procedure SBSelGPSClick(Sender: TObject);
    procedure ELonEsteChange(Sender: TObject);
    procedure ELonEsteEnter(Sender: TObject);
    procedure ELonEsteExit(Sender: TObject);
    procedure SwGeoUTMSwitch(Sender: TObject);
  private
    procedure CargarRegCoordenada(Psc: TPosicion);
    procedure GuardarCoordenada;
  public
    { Public declarations }
    procedure LimpiarComps;
  end;

implementation

uses DataMod;

{$R *.fmx}

procedure TFrmAgregar.LimpiarComps;
begin
  ELonEste.Text:='';
  ELatNorte.Text:='';
  EDescr.Text:='';
end;

procedure TFrmAgregar.CargarRegCoordenada(Psc: TPosicion);
begin
  Coords.EsteUTM:=Psc.X;
  Coords.NorteUTM:=Psc.Y;
  Coords.Huso:=Psc.Huso;
  Coords.Lat:=Psc.Lat;
  Coords.Lon:=Psc.Lon;
  Coords.LatGMS:=DecAGrados(Psc.Lat,true);
  Coords.LonGMS:=DecAGrados(Psc.Lon,false);
  Coords.Descripcion:=EDescr.Text.Trim;
end;

procedure TFrmAgregar.GuardarCoordenada;
begin
  DMod.Query.SQL.Text:='insert into Coordenadas (EsteUTM,NorteUTM,Huso,Lat,Lon,'+
    'LatGMS,LonGMS,Descripcion) values (:est,:nrt,:hus,:lat,:lon,:ltg,:lng,:dsc)';
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
    and not ELonEste.Text.IsEmpty and not ELatNorte.Text.IsEmpty
    and not EDescr.Text.IsEmpty;
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
  EsNumeroValido: boolean;

  procedure MostrarResultado(Activo: boolean);
  begin
    if Activo then
    begin
      LResLonEste.Text:='Este: '+FormatFloat('0.00',Psc.X);
      LResLatNorte.Text:='Norte: '+FormatFloat('0.00',Psc.Y);
      LayResHuso.Visible:=true;
    end
    else
    begin
      LResLonEste.Text:='Lon: '+FormatFloat('0.000000',Psc.Lon);
      LResLatNorte.Text:='Lat: '+FormatFloat('0.000000',Psc.Lat);
      LayResHuso.Visible:=false;
    end;
    LResHuso.Text:='Zona: '+Psc.Huso.ToString;
  end;

begin
  XDest:=0.0;
  YDest:=0.0;
  EsNumeroValido:=true;
  try
    XDest:=ELonEste.Text.ToDouble;
    YDest:=ELatNorte.Text.ToDouble;
  except
    EsNumeroValido:=false;
    ShowMessage('Introduzca coordenada(s) válida(s)');
  end;
  //sólo se introducirán datos en caso de que sean números válidos:
  if EsNumeroValido then
  begin
    Huso:=Trunc(CTBHuso.Value);
    if SwGeoUTM.IsChecked then Psc:=ConvertirAGrdUTM(XDest,YDest)
                          else Psc:=ConvertirAGrdGeo(XDest,YDest,Huso);
    LayResultado.Visible:=true;
    MostrarResultado(SwGeoUTM.IsChecked);
    Posc:=Psc;
    //se guardan los datos en el archivo .ini:
    Sistema.Lon:=Psc.Lon;
    Sistema.Lat:=Psc.Lat;
    Sistema.X:=Psc.X;
    Sistema.Y:=Psc.Y;
    Sistema.Huso:=Psc.Huso;
    Sistema.Descripcion:=EDescr.Text.Trim;
    GuardarINI(Sistema,Config);
    CargarRegCoordenada(Psc); //el registro a guardar en la BD
    Posc.XDest:=Sistema.X;
    Posc.YDest:=Sistema.Y;
    if SwGuardarBD.IsChecked then
      TDialogService.MessageDialog('¿Desea guardar esta coordenada?',
      TMsgDlgType.mtConfirmation,mbYesNo,TMsgDlgBtn.mbNo,0,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
            begin
              GuardarCoordenada;
              ShowMessage('La coordenada fue guardada exitosamente');
            end;
          mrNo: ShowMessage('La coordenada no fue guardada');
        end;
      end);
  end;
end;

procedure TFrmAgregar.SBSelGPSClick(Sender: TObject);
var
  Filtro,Formato: string;
  X,Y: double;
begin
  Filtro:='0123456789'+FormatSettings.DecimalSeparator;
  if SwGeoUTM.IsChecked then
  begin
    Filtro:=Filtro+'-';
    Formato:='0.000000';
    X:=Posc.Lon;
    Y:=Posc.Lat;
  end
  else
  begin
    //Filtro:='0123456789'+FormatSettings.DecimalSeparator;
    Formato:='0.00';
    X:=Posc.X;
    Y:=Posc.Y;
  end;
  //showmessage('Filtro: '+Filtro+' / '+'Formato: '+Formato);
  ELonEste.FilterChar:=Filtro;
  ELatNorte.FilterChar:=Filtro;
  ELonEste.Text:=FormatFloat(Formato,X);
  ELatNorte.Text:=FormatFloat(Formato,Y);
  CTBHuso.Value:=Posc.Huso;
  ELonEsteChange(Self);
  EDescr.SetFocus;
end;

procedure TFrmAgregar.SBVolverClick(Sender: TObject);
begin
  LayResultado.Visible:=false;
  Visible:=false;
end;

procedure TFrmAgregar.SwGeoUTMSwitch(Sender: TObject);
var
  Filtro: string;
begin
  ELonEste.Text:='0';
  ELatNorte.Text:='0';
  EDescr.Text:='';
  if SwGeoUTM.IsChecked then
  begin
    LGeoUTM.Text:='Coordenadas Geográficas:';
    LLon.Text:='Longitud:';
    LLat.Text:='Latitud:';
    Filtro:='0123456789.-';
    LayGCoords.Size.Height:=100;
  end
  else
  begin
    LGeoUTM.Text:='Coordenadas UTM:';
    LLon.Text:='Este:';
    LLat.Text:='Norte:';
    Filtro:='0123456789.';
    LayGCoords.Size.Height:=150;
    CTBHuso.Value:=Posc.Huso;
  end;
  ELonEste.FilterChar:=Filtro;
  ELatNorte.FilterChar:=Filtro;
  LayHuso.Visible:=not SwGeoUTM.IsChecked;
end;

end.
