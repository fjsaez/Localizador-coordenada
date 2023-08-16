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
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    ToolBar1: TToolBar;
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
    Layout8: TLayout;
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
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

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
  //el registro a guardar en la BD:
  Coords.EsteUTM:=Psc.XDest;
  Coords.NorteUTM:=Psc.YDest;
  Coords.Huso:=Psc.Huso;
  Coords.Lat:=Psc.Lat;  //aquí hay que convertir las c. destino de utm a geo
  Coords.Lon:=Psc.Lon;
  Coords.LatGMS:=DecAGrados(Psc.Lat,true);
  Coords.LonGMS:=DecAGrados(Psc.Lon,false);
  Coords.LatLon:=Format('%2.6f',[Psc.Lon])+', '+Format('%2.6f',[Psc.Lat]);
  Coords.Descripcion:=EDescr.Text.Trim;
  Coords.Fecha:=Now;
  //if SwGuardarBD.IsChecked then
    //código para guardar en bd
end;

procedure TFrmAgregar.SBSelGPSClick(Sender: TObject);
begin
  ELonEste.Text:=Round(Posc.X).ToString;
  ELatNorte.Text:=Round(Posc.Y).ToString;
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

// TODO: agregar componente para obtener huso UTM
