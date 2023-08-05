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
    Layout8: TLayout;
    Layout6: TLayout;
    Label2: TLabel;
    Layout7: TLayout;
    Label3: TLabel;
    Layout9: TLayout;
    EEste: TEdit;
    Layout5: TLayout;
    ENorte: TEdit;
    Layout10: TLayout;
    SwGuardarBD: TSwitch;
    Rectangle2: TRectangle;
    Label6: TLabel;
    procedure SBVolverClick(Sender: TObject);
    procedure SBGuardarClick(Sender: TObject);
    procedure SBSelGPSClick(Sender: TObject);
    procedure EEsteChange(Sender: TObject);
    procedure EEsteEnter(Sender: TObject);
    procedure EEsteExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrmAgregar.EEsteChange(Sender: TObject);
begin
  SBGuardar.Visible:=(EEste.Text<>'0') and (ENorte.Text<>'0')
      and not EEste.Text.IsEmpty and not ENorte.Text.IsEmpty;
end;

procedure TFrmAgregar.EEsteEnter(Sender: TObject);
begin
  if TEdit(Sender).Text='0' then TEdit(Sender).Text:='';
end;

procedure TFrmAgregar.EEsteExit(Sender: TObject);
begin
  if TEdit(Sender).Text='' then TEdit(Sender).Text:='0';
end;

procedure TFrmAgregar.SBGuardarClick(Sender: TObject);
begin
  Posc.XDest:=EEste.Text.ToDouble;
  Posc.YDest:=ENorte.Text.ToDouble;
  Coords.EsteUTM:=Posc.XDest;
  Coords.NorteUTM:=Posc.YDest;
  Coords.Lat:=Posc.YDest;   //aquí hay que convertir las c. destino de utm a geo
  Coords.Lon:=Posc.XDest;
  Coords.LatGMS:=DecAGrados(Posc.Y,true);
  Coords.LonGMS:=DecAGrados(Posc.X,false);
  Coords.LatLon:=Format('%2.6f',[Posc.Lon])+', '+Format('%2.6f',[Posc.Lat]);
  Coords.Descripcion:=EDescr.Text.Trim;
  Coords.Fecha:=Now;
  //if SwGuardarBD.IsChecked then
    //código para guardar en bd
end;

procedure TFrmAgregar.SBSelGPSClick(Sender: TObject);
begin
  EEste.Text:=Round(Posc.X).ToString;
  ENorte.Text:=Round(Posc.Y).ToString;
end;

procedure TFrmAgregar.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

end.
