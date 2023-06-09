﻿program LocCoordenada;

uses
  {$IFDEF ANDROID}
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  {$ENDIF}
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc},
  AgrCoordenada in 'AgrCoordenada.pas' {FrmAgregar: TFrame},
  UtilesLocalizador in 'UtilesLocalizador.pas',
  DataMod in 'DataMod.pas' {DMod: TDataModule};

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
