program LocCoordenada;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc},
  AgrCoordenada in 'AgrCoordenada.pas' {FrmAgregar: TFrame},
  UtilesLocalizador in 'UtilesLocalizador.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrinc, FPrinc);
  Application.Run;
end.
