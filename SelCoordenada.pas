unit SelCoordenada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, FMX.Objects, FMX.Memo, System.Sensors, System.Sensors.Components,
  FMX.Memo.Types, FireDAC.Stan.Param, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.DialogService, UTM_WGS84, UtilesLocalizador;

type
  TFrmSeleccionar = class(TFrame)
    ToolBarSelCoord: TToolBar;
    SBVolver: TSpeedButton;
    LayPrAgregar: TLayout;
    LayGCoords: TLayout;
    LayLongitud: TLayout;
    LayLatitud: TLayout;
    LaySeleccionar: TLayout;
    LayCoords: TLayout;
    LayLista: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LLongitud: TLabel;
    LLatitud: TLabel;
    SBEliminar: TSpeedButton;
    RectGrid: TRectangle;
    SGrid: TStringGrid;
    ColDescr: TStringColumn;
    ColID: TIntegerColumn;
    ColLon: TStringColumn;
    ColLat: TStringColumn;
    ColEste: TStringColumn;
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
    ColHuso: TIntegerColumn;
    Layout2: TLayout;
    LayCompartir: TLayout;
    SBCompartir: TSpeedButton;
    ActionList: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    LayDescr: TLayout;
    MmDescr: TMemo;
    Layout4: TLayout;
    Label5: TLabel;
    LHuso: TLabel;
    procedure SBVolverClick(Sender: TObject);
    procedure SGridCellClick(const Column: TColumn; const Row: Integer);
    procedure SBEliminarClick(Sender: TObject);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
  private
    { Private declarations }
    procedure LimpiarComponentes;
  public
    { Public declarations }
    IDCoord: integer;
    procedure CargarLista;
  end;
var
  UTM: TRecUTM;
  LatLon: TRecLatLon;

implementation

uses DataMod;

{$R *.fmx}

procedure TFrmSeleccionar.LimpiarComponentes;
begin
  LLongitud.Text:='';
  LLatitud.Text:='';
  LEste.Text:='';
  LNorte.Text:='';
  MmDescr.Text:='';
end;

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
      SGrid.Cells[2,Ind]:=FormatFloat('0.000000',QrLista.FieldByName('Lon').AsSingle);
      SGrid.Cells[3,Ind]:=FormatFloat('0.000000',QrLista.FieldByName('Lat').AsSingle);
      SGrid.Cells[4,Ind]:=FormatFloat('0.00',QrLista.FieldByName('EsteUTM').AsSingle);
      SGrid.Cells[5,Ind]:=FormatFloat('0.00',QrLista.FieldByName('NorteUTM').AsSingle);
      SGrid.Cells[6,Ind]:=QrLista.FieldByName('Huso').AsString;
      Inc(Ind);
      QrLista.Next;
    end;
  end;
  SGrid.EndUpdate;
end;

procedure TFrmSeleccionar.SBEliminarClick(Sender: TObject);
begin
  TDialogService.MessageDialog('¿Desea eliminar esta coordenada?',
    TMsgDlgType.mtConfirmation,mbYesNo,TMsgDlgBtn.mbNo,0,
    procedure(const AResult: TModalResult)
    begin
      case AResult of
        mrYes:
          begin
            DMod.Query.SQL.Text:='delete from Coordenadas where IDCoord=:idc';
            DMod.Query.ParamByName('idc').AsInteger:=IDCoord;
            DMod.Query.ExecSQL;
            CargarLista;
            LimpiarComponentes;
            ShowMessage('La coordenada fue eliminada');
          end;
        mrNo: ShowMessage('La coordenada no fue eliminada');
      end;
    end);
end;

procedure TFrmSeleccionar.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

procedure TFrmSeleccionar.SGridCellClick(const Column: TColumn;
  const Row: Integer);
begin
  IniciarRegSistema;
  //se carga el registro:
  Sistema.Descripcion:=SGrid.Cells[0,Row];
  IDCoord:=SGrid.Cells[1,Row].ToInteger;
  Sistema.Lon:=SGrid.Cells[2,Row].ToDouble;
  Sistema.Lat:=SGrid.Cells[3,Row].ToDouble;
  Sistema.X:=SGrid.Cells[4,Row].ToDouble;
  Sistema.Y:=SGrid.Cells[5,Row].ToDouble;
  Sistema.Huso:=SGrid.Cells[6,Row].ToInteger;
  GuardarINI(Sistema,Config);
  Posc.XDest:=Sistema.X;
  Posc.YDest:=Sistema.Y;
  //se cargan los componentes:
  MmDescr.Text:=Sistema.Descripcion;
  LLongitud.Text:=SGrid.Cells[2,Row];
  LLatitud.Text:=SGrid.Cells[3,Row];
  LEste.Text:=SGrid.Cells[4,Row];
  LNorte.Text:=SGrid.Cells[5,Row];
  LHuso.Text:=SGrid.Cells[6,Row];
  SBCompartir.Visible:=SGrid.RowCount>0;
  SBEliminar.Visible:=SGrid.RowCount>0;
end;

procedure TFrmSeleccionar.ShowShareSheetAction1BeforeExecute(Sender: TObject);
var
  CoordGeo,CoordUTM,Descripcion: string;
begin
  CoordGeo:='─ Lon: '+FormatFloat('0.000000',Sistema.Lon)+'; Lat: '+
    FormatFloat('0.000000',Sistema.Lat);
  CoordUTM:='─ Este: '+FormatFloat('0.00',Sistema.X)+'; Norte: '+
    FormatFloat('0.00',Sistema.Y)+'; Huso: '+Sistema.Huso.ToString;
  Descripcion:='─ '+Sistema.Descripcion;
  //se comparte el texto (WhatsApp, Bluetooth, etc, etc...)
  ShowShareSheetAction1.Caption:='Compartir coordenada:';
  ShowShareSheetAction1.TextMessage:='● Descripción:'+#13#10+Descripcion+
    #13#10+'● Coordenadas geográficas:'+#13#10+CoordGeo+#13#10+
    '● Coordenadas UTM:'+#13#10+CoordUTM+#13#10;
end;

end.
