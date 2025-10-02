program DLLClientP;

uses
  Vcl.Forms,
  frmClientU in 'frmClientU.pas' {frmClient},
  ProfitFunctionsU in 'Wrapper\ProfitFunctionsU.pas',
  CallbackHandlerU in 'Wrapper\CallbackHandlerU.pas',
  ProfitCallbackTypesU in 'Types\ProfitCallbackTypesU.pas',
  ProfitConstantsU in 'Types\ProfitConstantsU.pas',
  ProfitDataTypesU in 'Types\ProfitDataTypesU.pas',
  LegacyProfitFunctionsU in 'Wrapper\LegacyProfitFunctionsU.pas',
  LegacyProfitDataTypesU in 'Types\LegacyProfitDataTypesU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title:= 'DataFeed Client';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmClient, frmClient);
  Application.Run;
end.
