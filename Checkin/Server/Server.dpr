program Server;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uPrincipal in 'View\uPrincipal.pas' {Form1},
  uSMControl in 'Controller\uSMControl.pas' {SMControl: TDSServerModule},
  uSCModel in 'Model\uSCModel.pas' {SCModel: TDataModule},
  uWMModel in 'Model\uWMModel.pas' {WM: TWebModule},
  uLocalizacaoModel in 'Model\uLocalizacaoModel.pas',
  uConexao in 'Dao\uConexao.pas',
  uLocalizacaoDao in 'Dao\uLocalizacaoDao.pas',
  uSystem.JSONUtil in 'Model\uSystem.JSONUtil.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
