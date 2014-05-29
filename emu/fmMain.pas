unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, ExtCtrls, CheckLst, IniFiles, RSConnection, Math,
  ComCtrls, ActnList, XPStyleActnCtrls, ActnMan, ScktComp;

type
  TMainForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbPLCConnected: TCheckBox;
    Bevel1: TBevel;
    cbPLCBaud: TComboBox;
    cbPLCPort: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    cbScaleInConnected: TCheckBox;
    cbScaleInBaud: TComboBox;
    cbScaleInPort: TComboBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    cbScaleOutConnected: TCheckBox;
    cbScaleOutBaud: TComboBox;
    cbScaleOutPort: TComboBox;
    GroupBox4: TGroupBox;
    cblbOutput: TCheckListBox;
    GroupBox5: TGroupBox;
    cblbInput: TCheckListBox;
    ReadTimer: TTimer;
    rsPLC: TRSConnection;
    rsScaleIn: TRSConnection;
    rsScaleOut: TRSConnection;
    WriteTimer: TTimer;
    GroupBox6: TGroupBox;
    lvPairs: TListView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ActionManager1: TActionManager;
    aAddPair: TAction;
    aDelPair: TAction;
    aClearPairs: TAction;
    GroupBox7: TGroupBox;
    tbWeight: TTrackBar;
    lWeight: TLabel;
    cbNet: TCheckBox;
    cbStab: TCheckBox;
    ssPLC: TServerSocket;
    ssScaleOut: TServerSocket;
    mLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbPLCConnectedClick(Sender: TObject);
    procedure cbScaleInConnectedClick(Sender: TObject);
    procedure cbScaleOutConnectedClick(Sender: TObject);
    procedure ReadTimerTimer(Sender: TObject);
    procedure WriteTimerTimer(Sender: TObject);
    procedure aAddPairExecute(Sender: TObject);
    procedure aDelPairExecute(Sender: TObject);
    procedure aClearPairsExecute(Sender: TObject);
    procedure tbWeightChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Log
  end;

var
  MainForm: TMainForm;

const
  IniFileName = '.\gemu.ini';

implementation

uses fmAddPair;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var ini    : TIniFile;
    i      : integer;
    keys   : TStringList;
    values : TStringList;
begin
  ini := TIniFile.Create( IniFileName );

  cbPLCPort.ItemIndex := ini.ReadInteger( 'comm', 'plc_port', 1 ) - 1;
  cbPLCBaud.ItemIndex :=
    cbPLCBaud.Items.IndexOf( ini.ReadString( 'comm', 'plc_baud', '9600' ) );

  cbScaleInPort.ItemIndex := ini.ReadInteger( 'comm', 'scale_in_port', 1 ) - 1;
  cbScaleInBaud.ItemIndex :=
    cbScaleInBaud.Items.IndexOf( ini.ReadString( 'comm', 'scale_in_baud', '9600' ) );

  cbScaleOutPort.ItemIndex := ini.ReadInteger( 'comm', 'scale_out_port', 1 ) - 1;
  cbScaleOutBaud.ItemIndex :=
    cbScaleOutBaud.Items.IndexOf( ini.ReadString( 'comm', 'scale_out_baud', '9600' ) );

  if ini.SectionExists('pairs') then
    begin
      keys   := TStringList.Create;
      values := TStringList.Create;

      ini.ReadSection( 'pairs', keys );

      for i:=0 to keys.Count-1 do
        begin
          values.CommaText := ini.ReadString( 'pairs', keys[i], '0,0,0' );

          if values.Count = 3 then
            with lvPairs.Items.Add do begin
              Caption := cblbInput.Items[StrToIntDef(values[0], 0)];
              SubItems.Add(cblbOutput.Items[StrToIntDef(values[1], 0)]);
              if StrToBoolDef(values[2], false) then
                SubItems.Add('Yes')
              else
                SubItems.Add('No');

              Data := TxBitPair.Create( StrToIntDef(values[0], 0),
                                        StrToIntDef(values[1], 0),
                                        StrToBoolDef(values[2], false)
                                       );
            end;
        end;

      values.Free;
      keys.Free;  
    end;

  ini.Free;

  Self.tbWeightChange(Self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var ini      : TIniFile;
    i        : integer;
begin
  ini := TIniFile.Create( IniFileName );

  ini.WriteInteger( 'comm', 'plc_port', cbPLCPort.ItemIndex + 1 );
  ini.WriteString ( 'comm', 'plc_baud', cbPLCBaud.Text );

  ini.WriteInteger( 'comm', 'scale_in_port', cbScaleInPort.ItemIndex + 1 );
  ini.WriteString ( 'comm', 'scale_in_baud', cbScaleInBaud.Text );

  ini.WriteInteger( 'comm', 'scale_out_port', cbScaleOutPort.ItemIndex + 1 );
  ini.WriteString ( 'comm', 'scale_out_baud', cbScaleOutBaud.Text );

  ini.EraseSection( 'pairs' );
  for i:=0 to lvPairs.Items.Count-1 do
    begin
      ini.WriteString( 'pairs',
                       Format('pair_%d', [i]),
                       Format('%d,%d,%s', [ TxBitPair(lvPairs.Items[i].Data).BitIn,
                                            TxBitPair(lvPairs.Items[i].Data).BitOut,
                                            BoolToStr(TxBitPair(lvPairs.Items[i].Data).Inverted)
                                          ]
                             )
                     );
    end;

  ini.Free;

  ReadTimer.Enabled := false;
  WriteTimer.Enabled := false;

  rsPLC.Close;
  rsScaleIn.Close;
  rsScaleOut.Close;
end;

procedure TMainForm.cbPLCConnectedClick(Sender: TObject);
begin
  if cbPLCConnected.Checked then
    begin
      rsPLC.Port := cbPLCPort.ItemIndex + 1;
      rsPLC.Baud := StrToIntDef( cbPLCBaud.Text, 9600 );

      rsPLC.Open;
    end
  else
    rsPLC.Close;

  cbPLCConnected.Checked := rsPLC.IsOpen;      
end;

procedure TMainForm.cbScaleInConnectedClick(Sender: TObject);
begin
  if cbScaleInConnected.Checked then
    begin
      rsScaleIn.Port := cbScaleInPort.ItemIndex + 1;
      rsScaleIn.Baud := StrToIntDef( cbScaleInBaud.Text, 9600 );

      rsScaleIn.Open;
    end
  else
    rsScaleIn.Close;

  cbScaleInConnected.Checked := rsScaleIn.IsOpen;
end;

procedure TMainForm.cbScaleOutConnectedClick(Sender: TObject);
begin
  if cbScaleOutConnected.Checked then
    begin
      rsScaleOut.Port := cbScaleOutPort.ItemIndex + 1;
      rsScaleOut.Baud := StrToIntDef( cbScaleOutBaud.Text, 9600 );

      rsScaleOut.Open;
    end
  else
    rsScaleOut.Close;

  cbScaleOutConnected.Checked := rsScaleOut.IsOpen;
end;

procedure TMainForm.ReadTimerTimer(Sender: TObject);
var
  byt   : integer;
  bit   : integer;
  buff  : array[0..5] of byte;
  s     : string;
  i     : integer;
begin
  if rsPLC.IsOpen and (rsPLC.InCount > 0) then
    begin
      s := rsPLC.Read;

      if Length(s) = 7 then
        begin
          buff[0] := byte( s[2] );
          buff[1] := byte( s[1] );
          buff[2] := byte( s[4] );
          buff[3] := byte( s[3] );
          buff[4] := byte( s[6] );
          buff[5] := byte( s[5] );
        end
      else
        FillChar(buff, SizeOf(buff), 0);

      for i:=0 to 47 do
        begin
          byt := i div 8;
          bit := i mod 8;
          cblbInput.Checked[i] := buff[byt] and round(power(2,bit)) <> 0;
        end;

      for i:=0 to lvPairs.Items.Count-1 do
        if Assigned(lvPairs.Items[i].Data) then begin
          if TxBitPair(lvPairs.Items[i].Data).Inverted then
            cblbOutput.Checked[TxBitPair(lvPairs.Items[i].Data).BitOut] :=
            not cblbInput.Checked[TxBitPair(lvPairs.Items[i].Data).BitIn]
          else
            cblbOutput.Checked[TxBitPair(lvPairs.Items[i].Data).BitOut] :=
            cblbInput.Checked[TxBitPair(lvPairs.Items[i].Data).BitIn];
        end;
    end;
end;

procedure TMainForm.WriteTimerTimer(Sender: TObject);
var
  byt   : integer;
  bit   : integer;
  buff  : array[0..5] of byte;
  i     : integer;
  stat  : byte;
begin
  if rsPLC.IsOpen then
    begin
      FillChar(buff, SizeOf(buff), 0);

      for i:=0 to 47 do
        begin
          byt := i div 8;
          bit := i mod 8;

          if cblbOutput.Checked[i] then
            buff[byt] := buff[byt] or round(power(2,bit))
          else
            buff[byt] := buff[byt] and not round(power(2,bit));
        end;

      rsPLC.Write( char(buff[1]) +
                   char(buff[0]) +
                   char(buff[3]) +
                   char(buff[2]) +
                   char(buff[5]) +
                   char(buff[4])
                 );
    end;

  if rsScaleOut.IsOpen then
    begin
      stat := 0;
      if cbNet .Checked then stat := stat or 2;
      if cbStab.Checked then stat := stat or 16;

      rsScaleOut.Write( char(stat) +           // status
                        ' ' +                  // sign
                        Format('%6d', [tbWeight.Position]) +   // weight
                        ' ' +                  // empty space
                        #0#0 +                 // DigIn
                        #0#0#0 +               // DigOut
                        #13                    // package end
                      );
    end;
end;

procedure TMainForm.aAddPairExecute(Sender: TObject);
begin
  AddPairForm.cbBitIn.Items.Clear;
  AddPairForm.cbBitIn.Items.AddStrings( cblbInput.Items );

  AddPairForm.cbBitOut.Items.Clear;
  AddPairForm.cbBitOut.Items.AddStrings( cblbOutput.Items );

  if AddPairForm.ShowModal = mrOK then
    begin
      with lvPairs.Items.Add do begin
        Caption := AddPairForm.cbBitIn.Text;
        SubItems.Add( AddPairForm.cbBitOut.Text );
        if AddPairForm.cbInverted.Checked then
          SubItems.Add('Yes')
        else
          SubItems.Add('No');

        Data := TxBitPair.Create(
                  AddPairForm.cbBitIn.ItemIndex,
                  AddPairForm.cbBitOut.ItemIndex,
                  AddPairForm.cbInverted.Checked
                );
      end;
    end;
end;

procedure TMainForm.aDelPairExecute(Sender: TObject);
begin
  if Assigned(lvPairs.Selected) then lvPairs.DeleteSelected;
end;

procedure TMainForm.aClearPairsExecute(Sender: TObject);
begin
  lvPairs.Clear;
end;

procedure TMainForm.tbWeightChange(Sender: TObject);
begin
  lWeight.Caption := Format('%d kg', [tbWeight.Position]);
end;

end.
