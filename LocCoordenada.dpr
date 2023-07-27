program LocCoordenada;

uses
  {$IFDEF ANDROID}
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  {$ENDIF }
  System.StartUpCopy,
  System.SysUtils,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc},
  SelCoordenada in 'SelCoordenada.pas' {FrmSeleccionar: TFrame},
  UtilesLocalizador in 'UtilesLocalizador.pas',
  DataMod in 'DataMod.pas' {DMod: TDataModule},
  Acerca in 'Acerca.pas' {FrmAcerca: TFrame},
  FMX.FontGlyphs.Android in 'FMX.FontGlyphs.Android.pas',
  AgrCoordenada in 'AgrCoordenada.pas' {FrmAgregar: TFrame};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ANDROID}
  TAndroidHelper.Activity.getWindow.addFlags(
	  TJWindowManager_LayoutParams.JavaClass.FLAG_KEEP_SCREEN_ON);
  {$ENDIF}
  Application.CreateForm(TFPrinc, FPrinc);
  Application.CreateForm(TDMod, DMod);
  Application.Run;
end.
