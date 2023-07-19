unit Acerca;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TFrmAcerca = class(TFrame)
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    SBVolver: TSpeedButton;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Layout8: TLayout;
    Label3: TLabel;
    Label4: TLabel;
    Layout9: TLayout;
    Label5: TLabel;
    Layout10: TLayout;
    Label6: TLabel;
    Layout11: TLayout;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Rectangle1: TRectangle;
    ImgFondo: TImage;
    procedure SBVolverClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation      // Agregar las fuentes: Novus y FranciscoSaez

{$R *.fmx}

procedure TFrmAcerca.SBVolverClick(Sender: TObject);
begin
  Visible:=false;
end;

end.
