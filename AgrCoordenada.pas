unit AgrCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Objects, FMX.Edit, UtilesLocalizador, UTM_WGS84;

type
  TFrmAgregar = class(TFrame)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    ToolBar1: TToolBar;
    SBVolver: TSpeedButton;
    Label1: TLabel;
    LayGCoords: TLayout;
    LayGuardar: TLayout;
    SBGuardar: TSpeedButton;
    LayCoords: TLayout;
    LayLongitud: TLayout;
    LayLatitud: TLayout;
    LayDescr: TLayout;
    Label4: TLabel;
    Rectangle1: TRectangle;
    SBSelGPS: TSpeedButton;
    EDescr: TEdit;
    Label5: TLabel;
    Layout6: TLayout;
    LLon: TLabel;
    Layout7: TLayout;
    LLat: TLabel;
    Layout9: TLayout;
    ELonEste: TEdit;
    Layout5: TLayout;
    ELatNorte: TEdit;
    Layout10: TLayout;
    SwGuardarBD: TSwitch;
    Rectangle2: TRectangle;
    Label6: TLabel;
    Layout8: TLayout;
    LGeoUTM: TLabel;
    Layout11: TLayout;
    SwGeoUTM: TSwitch;
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
begin
  XDest:=ELonEste.Text.ToDouble;
  YDest:=ELatNorte.Text.ToDouble;
  Posc.XDest:=XDest;
  Posc.YDest:=YDest;
  //el registro a guardar en la BD:
  Coords.EsteUTM:=XDest;
  Coords.NorteUTM:=YDest;
  Coords.Lat:=YDest;  //aquí hay que convertir las c. destino de utm a geo
  Coords.Lon:=XDest;
  Coords.LatGMS:=DecAGrados(YDest,true);
  Coords.LonGMS:=DecAGrados(XDest,false);
  Coords.LatLon:=Format('%2.6f',[XDest])+', '+Format('%2.6f',[YDest]);
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
  end
  else
  begin
    LGeoUTM.Text:='Coordenadas UTM:';
    LLon.Text:='Este:';
    LLat.Text:='Norte:';
  end;
end;

end.
