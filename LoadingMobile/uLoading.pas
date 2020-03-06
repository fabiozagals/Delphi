unit uLoading;

interface

uses
  System.Classes, System.Types, FMX.StdCtrls, FMX.Types, FMX.Objects, System.UITypes,
  System.SysUtils, FMX.Layouts, FMX.Forms, FGX.ProgressDialog,
  FMX.Graphics, FMX.Ani, FMX.Filter.Effects, Mobile.View.Principal,
  FMX.VirtualKeyboard, FMX.Platform;

type
  TLoading = class
  private
    class var FFundo: TRectangle;
    class var FLayout: TLayout;
    class var FImage: TImage;
    class var FTransition: TLineTransitionEffect;
    class var FAnimacao: TFLoatAnimation;
    class var FMessagem: TLabel;
    //class var FfgActivityDialog: TfgActivityDialog;
  public
    class procedure Show(Msg: String);
    class procedure Hide;
  end;

implementation

uses
  FMX.Dialogs;

{ TControllerApoioLoading }

class procedure TLoading.Show(Msg: String);
var
  Size: TSizeF;
  Container: TFmxObject;
  FService: IFMXVirtualKeyboardService;
begin
  if not Assigned(FLayout) then
  begin
    Container := Application.MainForm;

    FFundo := TRectangle.Create(Container);
    FFundo.Opacity := 0;
    FFundo.Parent := Container;
    FFundo.Visible := true;
    FFundo.Align := TAlignLayout.Contents;
    FFundo.Fill.Color := TAlphaColorRec.Black;
    FFundo.Fill.Kind := TBrushKind.Solid;
    FFundo.Stroke.Kind := TBrushKind.Solid;

    FLayout := TLayout.Create(Container);
    FLayout.Opacity := 0;
    FLayout.Parent := Container;
    FLayout.Visible := true;
    FLayout.Align := TAlignLayout.Contents;
    FLayout.Width := 250;
    FLayout.Height := 78;

    FImage := TImage.Create(Container);
    FImage.Visible := true;
    FImage.Parent := FLayout;
    FImage.Align := TAlignLayout.Center;
    FImage.Margins.Bottom := 80;
    FImage.Width := 100;
    FImage.Height := 100;
    FImage.Position.X := (FLayout.Width - FImage.Width) / 2;
    FImage.Position.Y := 0;


    Size := TSize.Create(100,100);
    FTransition := TLineTransitionEffect.Create(Container);
    FTransition.Parent := FImage;
    FTransition.Target := frmPrincipal.ImageList1.Bitmap(Size, 8);
    FTransition.Enabled := true;
    FTransition.FuzzyAmount := 0;
    FTransition.Progress := 100;

    FAnimacao := TFloatAnimation.Create(Container);
    FAnimacao.Parent := FTransition;
    FAnimacao.AnimationType := TAnimationType.In;
    FAnimacao.AutoReverse := true;
    FAnimacao.StartValue := 0;
    FAnimacao.StopValue := 37;
    FAnimacao.Delay := 0;
    FAnimacao.Duration := 1;
    FAnimacao.Loop := true;
    FAnimacao.PropertyName := 'Progress';

    FAnimacao.Interpolation := TInterpolationType.Linear;
    FAnimacao.Start;

    FMessagem := TLabel.Create(Container);
    FMessagem.Parent := FLayout;
    FMessagem.Align := TAlignLayout.Center;
    FMessagem.Margins.Top := 60;
    FMessagem.Font.Size := 15;
    FMessagem.Height := 70;
    FMessagem.Width := FFundo.Width - 100;
    FMessagem.FontColor := $FFFEFFFF;
    FMessagem.TextSettings.HorzAlign := TTextAlign.Center;
    FMessagem.TextSettings.VertAlign := TTextAlign.Leading;
    FMessagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    FMessagem.Text := Msg;
    FMessagem.VertTextAlign := TTextAlign.Leading;
    FMessagem.Trimming := TTextTrimming.None;
    FMessagem.TabStop := false;
    FMessagem.SetFocus;

    FFundo.AnimateFloat('Opacity', 0.7);
    FLayout.AnimateFloat('Opacity', 1);
    FLayout.BringToFront;
  end
  else
    FMessagem.Text := Msg;

  // Esconde o teclado virtual...
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
                                                    IInterface(FService));
  if (FService <> nil) then
  begin
      FService.HideVirtualKeyboard;
  end;
  FService := nil;
end;

class procedure TLoading.Hide;
begin
   if Assigned(FLayout) then begin
    FMessagem.DisposeOf;
    FAnimacao.DisposeOf;
    FTransition.DisposeOf;
    FImage.DisposeOf;
    FFundo.DisposeOf;
    FLayout.DisposeOf;

    FMessagem := nil;
    FAnimacao := nil;
    FTransition := nil;
    FImage := nil;
    FFundo := nil;
    FLayout := nil;
  end;

//  if Assigned(FfgActivityDialog) then
//  begin
//    FfgActivityDialog.Hide;
//    FreeAndNil(FfgActivityDialog);
//  end;
end;

end.
