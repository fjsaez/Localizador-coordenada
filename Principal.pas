unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,  FMX.MultiView,
  FMX.ListBox, AgrCoordenada;

type
  TFPrinc = class(TForm)
    LayPrincipal: TLayout;
    ToolBar1: TToolBar;
    SBMenu: TSpeedButton;
    MultiView: TMultiView;
    LstBoxMenu: TListBox;
    LstBuscar: TListBoxItem;
    LstBGuardar: TListBoxItem;
    LstBSalir: TListBoxItem;
    LstBAcerca: TListBoxItem;
    FrmAgregarPnc: TFrmAgregar;
    procedure LstBGuardarClick(Sender: TObject);
    procedure FrmAgregarPncSBVolverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;

implementation

{$R *.fmx}

procedure TFPrinc.FormCreate(Sender: TObject);
begin
  //ocultar las pantallas secundarias:
  FrmAgregarPnc.Visible:=false;
  //poner visible la pantalla principal:
  LayPrincipal.Visible:=true;
end;

procedure TFPrinc.FrmAgregarPncSBVolverClick(Sender: TObject);
begin
  FrmAgregarPnc.SBVolverClick(Sender);
  LayPrincipal.Visible:=true;
end;

procedure TFPrinc.LstBGuardarClick(Sender: TObject);
begin
  LayPrincipal.Visible:=false;
  FrmAgregarPnc.Visible:=true;
end;

end.
