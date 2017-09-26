unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  RPersonagens = (Avatar, Batman, CapitaoAmerica, Cyborg, DarthVader, FreddyKrueger, HomemDeFerro, TartarugaNinja,
                  Pikachu, Predador, R2D2, Sonic, HomemAranha, SuperMario, SuperMan, Flash, Thor, PicaPau);
  TfrmMain = class(TForm)
    pnlMain: TPanel;
    pnlMenu: TPanel;
    pnlScreen: TPanel;
    btnSair: TSpeedButton;
    btnNovoJogo: TSpeedButton;
    pcHash: TPageControl;
    tbCharacters: TTabSheet;
    tbGame: TTabSheet;
    pnlBoard: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Vertical1: TPanel;
    Horizontal2: TPanel;
    Horizontal1: TPanel;
    Panel5: TPanel;
    pnlMenuCharacters: TPanel;
    tbHome: TTabSheet;
    imgHome: TImage;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    Label2: TLabel;
    lblNomePersonagem1: TLabel;
    Label3: TLabel;
    lblNomePersonagem2: TLabel;
    btnJogar: TSpeedButton;
    imgListPersonagens: TImageList;
    pnlEstatisticas: TPanel;
    lblNumeroJogadas: TLabel;
    pnlPlacar: TPanel;
    pnlTituloPlacar: TPanel;
    Image10: TImage;
    imgPlacarPerson1: TImage;
    imgPlacarPerson2: TImage;
    lblVitoriasPerson1: TLabel;
    lblVitoriasPerson2: TLabel;
    Label6: TLabel;
    pnlTurno: TPanel;
    imgTurno: TImage;
    lblTurno: TLabel;
    btnRevanche: TSpeedButton;
    btnInicio: TSpeedButton;
    imgListVelha: TImageList;
    pnlContato: TPanel;
    pnlGitHub: TPanel;
    pnlLinkedin: TPanel;
    Image14: TImage;
    pnlEmail: TPanel;
    Image11: TImage;
    Image13: TImage;
    Panel1: TPanel;
    Image12: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoJogoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnJogarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure btnRevancheClick(Sender: TObject);
    procedure btnInicioClick(Sender: TObject);
  private
    FJogoEmAndamento: Boolean;
    FCodigoPersonagem1, FCodigoPersonagem2, FNumeroJogadas: Integer;

    //Tabuleiro
    { Personagem 1}
    FVitoriasPersonagem1: Integer;
    FPersonagem1Linha1, FPersonagem1Coluna1, FPersonagem1Horizontal1: Integer;
    FPersonagem1Linha2, FPersonagem1Coluna2, FPersonagem1Horizontal2: Integer;
    FPersonagem1Linha3, FPersonagem1Coluna3: Integer;

    { Personagem 2 }
    FVitoriasPersonagem2: Integer;
    FPersonagem2Linha1, FPersonagem2Coluna1, FPersonagem2Horizontal1: Integer;
    FPersonagem2Linha2, FPersonagem2Coluna2, FPersonagem2Horizontal2: Integer;
    FPersonagem2Linha3, FPersonagem2Coluna3: Integer;

    procedure EsconderSheets();
    procedure HabilitarPersonagens;
    procedure LimparTabuleiro();
    procedure MecanicaPadraoTabuleiro(Sender: TObject);
    procedure ControlarTabuleiro(AHabilitar: Boolean);
    procedure NovoJogo();
    procedure Empatar();
    procedure VencedorPersonagem2();
    procedure VencedorPersonagem1();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnInicioClick(Sender: TObject);
begin
  pcHash.ActivePage := tbHome;
end;

procedure TfrmMain.btnNovoJogoClick(Sender: TObject);
begin
  if FJogoEmAndamento then
  begin
    if Application.MessageBox('Existe um jogo em andamento!' + sLineBreak +
                              'Deseja iniciar um novo?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = mrYes
    then
    begin
      pcHash.ActivePage := tbCharacters;
      HabilitarPersonagens();
    end;
  end
  else
  begin
    pcHash.ActivePage := tbCharacters;
    HabilitarPersonagens();
  end;

end;

procedure TfrmMain.HabilitarPersonagens();
var
  I: Integer;
begin
  for I := 0 to ComponentCount -1 do
    if (Components[I].ClassType = TSpeedButton) then
      TSpeedButton(Components[I]).Enabled := True;

  lblNomePersonagem1.Caption := EmptyStr;
  lblNomePersonagem2.Caption := EmptyStr;

end;

procedure TfrmMain.Image1Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha1);
    Inc(FPersonagem1Coluna1);
    Inc(FPersonagem1Horizontal1);
  end
  else
  begin
    Inc(FPersonagem2Linha1);
    Inc(FPersonagem2Coluna1);
    Inc(FPersonagem2Horizontal1);
  end;

  if (FPersonagem1Coluna1 = 3) or (FPersonagem1Linha1 = 3) or (FPersonagem1Horizontal1 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna1 = 3) or (FPersonagem2Linha1 = 3) or (FPersonagem2Horizontal1 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image2Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha1);
    Inc(FPersonagem1Coluna2);
  end
  else
  begin
    Inc(FPersonagem2Linha1);
    Inc(FPersonagem2Coluna2);
  end;

  if (FPersonagem1Coluna2 = 3) or (FPersonagem1Linha1 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna2 = 3) or (FPersonagem2Linha1 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image3Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha1);
    Inc(FPersonagem1Coluna3);
    Inc(FPersonagem1Horizontal2);
  end
  else
  begin
    Inc(FPersonagem2Linha1);
    Inc(FPersonagem2Coluna3);
    Inc(FPersonagem2Horizontal2);
  end;

  if (FPersonagem1Coluna3 = 3) or (FPersonagem1Linha1 = 3) or (FPersonagem1Horizontal2 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna3 = 3) or (FPersonagem2Linha1 = 3) or (FPersonagem2Horizontal2 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image4Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha2);
    Inc(FPersonagem1Coluna1);
  end
  else
  begin
    Inc(FPersonagem2Linha2);
    Inc(FPersonagem2Coluna1);
  end;

  if (FPersonagem1Coluna1 = 3) or (FPersonagem1Linha2 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna1 = 3) or (FPersonagem2Linha2 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image5Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha2);
    Inc(FPersonagem1Coluna2);
    Inc(FPersonagem1Horizontal1);
    Inc(FPersonagem1Horizontal2);
  end
  else
  begin
    Inc(FPersonagem2Linha2);
    Inc(FPersonagem2Coluna2);
    Inc(FPersonagem2Horizontal1);
    Inc(FPersonagem2Horizontal2);
  end;

  if (FPersonagem1Coluna2 = 3) or (FPersonagem1Linha2 = 3) or (FPersonagem1Horizontal1 = 3) or (FPersonagem1Horizontal2 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna2 = 3) or (FPersonagem2Linha2 = 3) or (FPersonagem2Horizontal1 = 3) or (FPersonagem2Horizontal2 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image6Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha2);
    Inc(FPersonagem1Coluna3);
  end
  else
  begin
    Inc(FPersonagem2Linha2);
    Inc(FPersonagem2Coluna3);
  end;

  if (FPersonagem1Coluna3 = 3) or (FPersonagem1Linha2 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna3 = 3) or (FPersonagem2Linha2 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image7Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha3);
    Inc(FPersonagem1Coluna1);
    Inc(FPersonagem1Horizontal2);
  end
  else
  begin
    Inc(FPersonagem2Linha3);
    Inc(FPersonagem2Coluna1);
    Inc(FPersonagem2Horizontal2);
  end;

  if (FPersonagem1Coluna1 = 3) or (FPersonagem1Linha3 = 3) or (FPersonagem1Horizontal2 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna1 = 3) or (FPersonagem2Linha3 = 3) or (FPersonagem2Horizontal2 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image8Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha3);
    Inc(FPersonagem1Coluna2);
  end
  else
  begin
    Inc(FPersonagem2Linha3);
    Inc(FPersonagem2Coluna2);
  end;

  if (FPersonagem1Coluna2 = 3) or (FPersonagem1Linha3 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna2 = 3) or (FPersonagem2Linha3 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.Image9Click(Sender: TObject);
begin
  MecanicaPadraoTabuleiro(Sender);

  if ((FNumeroJogadas mod 2) = 0) then
  begin
    Inc(FPersonagem1Linha3);
    Inc(FPersonagem1Coluna3);
    Inc(FPersonagem1Horizontal1);
  end
  else
  begin
    Inc(FPersonagem2Linha3);
    Inc(FPersonagem2Coluna3);
    Inc(FPersonagem2Horizontal1);
  end;

  if (FPersonagem1Coluna3 = 3) or (FPersonagem1Linha3 = 3) or (FPersonagem1Horizontal1 = 3) then
    VencedorPersonagem1()
  else
  if (FPersonagem2Coluna3 = 3) or (FPersonagem2Linha3 = 3) or (FPersonagem2Horizontal1 = 3) then
    VencedorPersonagem2()
  else
  if FNumeroJogadas = 9 then
    Empatar();

end;

procedure TfrmMain.LimparTabuleiro();
var
  I: Integer;
begin
  for I := 0 to pnlBoard.ControlCount -1 do
    if (pnlBoard.Controls[I].ClassType = TImage) then
      if TImage(pnlBoard.Controls[I]).Picture.Bitmap <> nil then
      begin
        TImage(pnlBoard.Controls[I]).Picture := nil;
        TImage(pnlBoard.Controls[I]).Tag := 0;
      end;

end;

procedure TfrmMain.MecanicaPadraoTabuleiro(Sender: TObject);
begin
  TImage(Sender).Picture := nil;
  imgTurno.Picture := nil;
  Inc(FNumeroJogadas);
  lblNumeroJogadas.Caption := 'Número de Jogadas: ' + IntToStr(FNumeroJogadas);
  lblTurno.Caption := 'é sua vez de jogar!';
  if ((FNumeroJogadas mod 2) = 0) then
  begin
    imgListPersonagens.GetBitmap(FCodigoPersonagem1, TImage(Sender).Picture.Bitmap);
    TImage(Sender).Enabled := False;
    TImage(Sender).Tag := 1;
    imgListPersonagens.GetBitmap(FCodigoPersonagem2, imgTurno.Picture.Bitmap);
  end
  else
  begin
    imgListPersonagens.GetBitmap(FCodigoPersonagem2, TImage(Sender).Picture.Bitmap);
    TImage(Sender).Enabled := False;
    TImage(Sender).Tag := 1;
    imgListPersonagens.GetBitmap(FCodigoPersonagem1, imgTurno.Picture.Bitmap);
  end;
end;

procedure TfrmMain.NovoJogo;
begin
  FNumeroJogadas := 0;

  { Personagem 1}
  FPersonagem1Linha1 := 0;
  FPersonagem1Coluna1 := 0;
  FPersonagem1Horizontal1 := 0;
  FPersonagem1Linha2 := 0;
  FPersonagem1Coluna2 := 0;
  FPersonagem1Horizontal2 := 0;
  FPersonagem1Linha3 := 0;
  FPersonagem1Coluna3 := 0;

  { Personagem 2 }
  FPersonagem2Linha1 := 0;
  FPersonagem2Coluna1 := 0;
  FPersonagem2Horizontal1 := 0;
  FPersonagem2Linha2 := 0;
  FPersonagem2Coluna2 := 0;
  FPersonagem2Horizontal2 := 0;
  FPersonagem2Linha3 := 0;
  FPersonagem2Coluna3 := 0;

end;

procedure TfrmMain.btnRevancheClick(Sender: TObject);
begin

  FJogoEmAndamento := True;
  btnRevanche.Visible := False;
  LimparTabuleiro();
  ControlarTabuleiro(True);
  NovoJogo();
  imgTurno.Picture := nil;
  imgListPersonagens.GetBitmap(FCodigoPersonagem2, imgTurno.Picture.Bitmap);
  lblTurno.Caption := 'é sua vez de jogar!';

end;

procedure TfrmMain.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.ControlarTabuleiro(AHabilitar: Boolean);
var
  i: Integer;
begin
  for i := 0 to pnlBoard.ControlCount -1 do
    if pnlBoard.Controls[i] is TImage then
      if TImage(pnlBoard.Controls[i]).Tag = 0 then
        TImage(pnlBoard.Controls[i]).Enabled := AHabilitar;
end;

procedure TfrmMain.Empatar();
begin
  imgTurno.Picture := nil;
  imgListVelha.GetBitmap(0, imgTurno.Picture.Bitmap);
  lblTurno.Caption := 'Velha!';
  Application.MessageBox(PChar('A Batalha entre ' + lblNomePersonagem1.Caption + ' e ' + lblNomePersonagem2.Caption + ' terminou empatada!'), 'Informação', MB_ICONINFORMATION);
  btnRevanche.Visible := True;
  FJogoEmAndamento := False;
end;
procedure TfrmMain.VencedorPersonagem1();
begin
  Inc(FVitoriasPersonagem1);
  lblVitoriasPerson1.Caption := IntToStr(FVitoriasPersonagem1);
  imgTurno.Picture := nil;
  imgListPersonagens.GetBitmap(FCodigoPersonagem1, imgTurno.Picture.Bitmap);
  lblTurno.Caption := 'O Vencedor foi ' + lblNomePersonagem1.Caption +'!';
  ControlarTabuleiro(False);
  btnRevanche.Visible := True;
  FJogoEmAndamento := False;
end;
procedure TfrmMain.VencedorPersonagem2();
begin
  Inc(FVitoriasPersonagem2);
  lblVitoriasPerson2.Caption := IntToStr(FVitoriasPersonagem2);
  imgTurno.Picture := nil;
  imgListPersonagens.GetBitmap(FCodigoPersonagem2, imgTurno.Picture.Bitmap);
  lblTurno.Caption := 'O Vencedor foi ' + lblNomePersonagem2.Caption +'!';
  ControlarTabuleiro(False);
  btnRevanche.Visible := True;
  FJogoEmAndamento := False;
end;

procedure TfrmMain.EsconderSheets;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if (Components[I].ClassType = TTabSheet) then
      TTabSheet(Components[I]).TabVisible := False;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  EsconderSheets();

  FJogoEmAndamento := False;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  pcHash.ActivePage := tbHome;
end;

procedure TfrmMain.btnJogarClick(Sender: TObject);
begin
  if (lblNomePersonagem1.Caption <> EmptyStr) and (lblNomePersonagem2.Caption <> EmptyStr) then
  begin
    pcHash.ActivePage := tbGame;
    FJogoEmAndamento := True;
    LimparTabuleiro();
    ControlarTabuleiro(True);
    NovoJogo();
    imgPlacarPerson1.Picture := nil;
    imgPlacarPerson2.Picture := nil;
    imgTurno.Picture := nil;
    imgListPersonagens.GetBitmap(FCodigoPersonagem1, imgPlacarPerson1.Picture.Bitmap);
    imgListPersonagens.GetBitmap(FCodigoPersonagem2, imgPlacarPerson2.Picture.Bitmap);
    imgListPersonagens.GetBitmap(FCodigoPersonagem2, imgTurno.Picture.Bitmap);
    lblTurno.Caption := 'é sua vez de jogar!';
    FVitoriasPersonagem1 := 0;
    FVitoriasPersonagem2 := 0;
    lblVitoriasPerson1.Caption := IntToStr(FVitoriasPersonagem1);
    lblVitoriasPerson2.Caption := IntToStr(FVitoriasPersonagem2);

  end
  else
    Application.MessageBox('Selecione os personagens antes de continuar.', 'Informação', MB_ICONINFORMATION);
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  if lblNomePersonagem1.Caption = EmptyStr then
  begin
    TSpeedButton(Sender).Enabled := False;
    lblNomePersonagem1.Caption := TSpeedButton(Sender).Caption;
    FCodigoPersonagem1 := TSpeedButton(Sender).Tag;
  end
  else
  if lblNomePersonagem2.Caption = EmptyStr then
  begin
    TSpeedButton(Sender).Enabled := False;
    lblNomePersonagem2.Caption := TSpeedButton(Sender).Caption;
    FCodigoPersonagem2 := TSpeedButton(Sender).Tag;
  end
  else
    Application.MessageBox('Personagens já foram escolhidos, clique em "Jogar!" para iniciar.', 'Informação', MB_ICONINFORMATION);
end;

end.

