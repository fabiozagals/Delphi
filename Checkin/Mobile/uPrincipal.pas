unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  {$IFDEF ANDROID}
    FMX.Helpers.Android, FMX.Platform.Android,
  {$ENDIF}
  FMX.VirtualKeyboard, FMX.Platform;

type
  TfrmPrincipal = class(TForm)
    lytBasePrincipal: TLayout;
    actAcoes: TActionList;
    actMudarAba: TChangeTabAction;
    tbctrlPrincipal: TTabControl;
    tbitemMenu: TTabItem;
    lytBackground: TLayout;
    lytMenu: TGridLayout;
    lytClientes: TLayout;
    rndBtnCli: TRoundRect;
    imgBtnChkin: TImage;
    lytRotulos1: TLayout;
    lblTituloBtnCheckin: TLabel;
    ShadowEffect1: TShadowEffect;
    lytSync: TLayout;
    rndBtnSync: TRoundRect;
    imgBtnSync: TImage;
    lytRotulos5: TLayout;
    lblTituloBtnSync: TLabel;
    ShadowEffect5: TShadowEffect;
    lytConfig: TLayout;
    rndBtnConfig: TRoundRect;
    imgBtnConfig: TImage;
    lytRotulos6: TLayout;
    lblTituloBtnConfig: TLabel;
    ShadowEffect6: TShadowEffect;
    lytSuperior: TLayout;
    Image2: TImage;
    lytInferior: TLayout;
    tbitemApoio: TTabItem;
    lytPrincipal: TLayout;
    lblRegistroSinc: TLabel;
    ShadowEffect2: TShadowEffect;
    lytSair: TLayout;
    RoundRect1: TRoundRect;
    imgBtnSair: TImage;
    Layout2: TLayout;
    lblSair: TLabel;
    ShadowEffect3: TShadowEffect;
    procedure imgBtnChkinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgBtnSairClick(Sender: TObject);
  private
    FActiveForm : TForm;
  public
    { Public declarations }
    procedure MudarAba(ATabItem: TTabItem; Sender: TObject);
    procedure AbrirForm(AFormClass: TComponentClass);
    procedure AjustarLayout;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uCheckin, uDM;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tbctrlPrincipal.ActiveTab   := tbitemMenu;
  tbctrlPrincipal.TabPosition := TTabPosition.None;
  AjustarLayout;

  DM.qryAux.SQL.Clear;
  DM.qryAux.SQL.Add('SELECT * FROM CHECKIN');
  DM.qryAux.Active := True;
  lblRegistroSinc.Text := 'H� '+IntToStr(DM.qryAux.RecordCount)+ ' registro(s) n�o sincronizado(s)'

end;

procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  FService : IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if Key = vkHardwareBack then
  begin
     Key := 0;
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      //N�o faz nada
    end
    {$Region 'Checkin'}
    else if tbctrlPrincipal.ActiveTab = tbitemApoio then
    begin
      if Assigned(FActiveForm) and (FActiveForm.Name = 'frmCheckin') then
      begin
        if not ((FActiveForm as TfrmCheckin).tbctrlPrincipal.ActiveTab = (FActiveForm as TfrmCheckin).tbitemListagem) then
          (FActiveForm as TfrmCheckin).tbctrlPrincipal.Previous()
        else if ((FActiveForm as TfrmCheckin).tbctrlPrincipal.ActiveTab = (FActiveForm as TfrmCheckin).tbitemListagem) then
          tbctrlPrincipal.Previous()
      end
    end
    {$EndRegion}
    else
    begin
      MessageDlg('Deseja sair do aplicativo?', TMsgDlgType.mtConfirmation,
          [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
          procedure (const AResult: TModalResult)
          begin
            if AResult = mrYes then
            begin
              {$IFDEF ANDROID}
              MainActivity.finish;
              {$ELSE}
              exit;
              {$ENDIF}
            end;
          end
        );
    end

  end;
end;

procedure TfrmPrincipal.AbrirForm(AFormClass: TComponentClass);
var
  LayoutBase, BotaoMenu: TComponent;
begin
  if Assigned(FActiveForm) then
  begin
    if FActiveForm.ClassType = AFormClass then
      exit
    else
    begin
      FActiveForm.DisposeOf;
      FActiveForm := nil;
    end;
  end;

  Application.CreateForm(AFormClass, FActiveForm);
  LayoutBase := FActiveForm.FindComponent('lytBase');
  if Assigned(LayoutBase) then
    lytPrincipal.AddObject(TLayout(LayoutBase));
end;

procedure TfrmPrincipal.AjustarLayout;
begin
  lytMenu.ItemWidth := (Self.ClientWidth - 20);
end;

procedure TfrmPrincipal.imgBtnChkinClick(Sender: TObject);
begin
  AbrirForm(TfrmCheckin);
  MudarAba(tbitemApoio, Sender);
end;

procedure TfrmPrincipal.imgBtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.MudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  actMudarAba.Tab := ATabItem;
  actMudarAba.ExecuteTarget(Sender);
end;

end.
