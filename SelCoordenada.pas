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
    ColLon: TStringColumn;
    ColLat: TStringColumn;
    ColEste: TStringColumn;
    MmDescr: TMemo;
    Layout1: TLayout;
    LayNorte: TLayout;
    Label4: TLabel;
    LNorte: TLabel;
    LayEste: TLayout;
    Label6: TLabel;
    LEste: TLabel;
    Panel1: TPanel;
    LTotPtos: TLabel;
    ColNorte: TFloatColumn;
    procedure SBVolverClick(Sender: TObject);
    //procedure SBGuardarClick(Sender: TObject);
    {procedure LctSensorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D); }
    procedure MmDescrChange(Sender: TObject);
  private
    { Private declarations }
    //procedure Guardar;
  public
    { Public declarations }
    procedure CargarLista;
  end;
var
  UTM: TRecUTM;
  LatLon: TRecLatLon;

implementation

uses DataMod;

{$R *.fmx}

procedure TFrmSeleccionar.CargarLista;
var
  Ind: word;
begin
  ColDescr.Width:=SGrid.Width;
  SGrid.BeginUpdate;
  with DMod do
  begin
    QrLista.Open;
    QrLista.Refresh;
    LTotPtos.Text:='Total puntos: '+QrLista.RecordCount.ToString;
    QrLista.First;
    Ind:=0;
    SGrid.RowCount:=0;
    while not QrLista.Eof do
    begin
      SGrid.RowCount:=SGrid.RowCount+1;
      SGrid.Cells[0,Ind]:=QrLista.FieldByName('Descripcion').AsString;
      SGrid.Cells[1,Ind]:=QrLista.FieldByName('IDCoord').AsString;
      SGrid.Cells[2,Ind]:=QrLista.FieldByName('Lon').AsString;
      SGrid.Cells[3,Ind]:=QrLista.FieldByName('Lat').AsString;
      SGrid.Cells[4,Ind]:=QrLista.FieldByName('EsteUTM').AsString;
      SGrid.Cells[5,Ind]:=QrLista.FieldByName('NorteUTM').AsString;
      Inc(Ind);
      QrLista.Next;
    end;
  end;
  SGrid.EndUpdate;
end;

procedure TFrmSeleccionar.MmDescrChange(Sender: TObject);
begin
  SBGuardar.Enabled:=MmDescr.Text.Trim<>'';
end;

procedure TFrmSeleccionar.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

end.
