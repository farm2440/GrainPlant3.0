unit uGlobals;

interface

uses
  Windows, SysUtils, Classes, IniFiles, Registry, ScktComp;

const
  cConfigFileName = '.\grain.ini';
  cRegistryRoot = '\Software\STIV\Grain';


  eCommonError      = 0;
  eFlapTimeoutError = 1;
  cZeroTolerance    = 2;

var
  { PLC port settings }
  plc_port      : integer;
  plc_baud      : integer;
  plc_parity    : integer;

  // Изходяща маска на байтовете в plc_out_buff
  plc_out_mask  : Byte;


  { scale port settings }
  scale_port   : integer;
  scale_baud   : integer;
  scale_parity : integer;

  { printer port settings }
  printer_port   : integer;
  printer_baud   : integer;
  printer_parity : integer;

  { other settings }
  debug_mode     : boolean;

  { device timeout settings }
  flap1_timeout   : integer;
  flap2_timeout   : integer;
  roulette_timeout: integer;
  elevator_timeout: integer;
  auger_timeout   : integer;

  {  }
  manual          : boolean;
  capacity        : integer;
  zero_tolerance  : integer;
  disch_time      : integer;

  { liquid flows }
  water_qty       : double;
  water_flow      : double;
  oil_qty         : double;
  oil_flow        : double;

  { automation variables }
  autostart_next_dose : boolean;
  autostart_next_order: boolean;
  alert_dose_done   : boolean;
  alert_order_done  : boolean;
  //ss-start
  {SDispenser}
  sdSDispenserConnection : boolean;
  sdTag, sdBase : String;
  sdStartStop : boolean; //TRUE - start FALSE - stop
  sdSocket : TClientSocket;
  //ss-end


procedure LoadSettings;
procedure SaveSettings;

function HexToInt( hex: string ): longint;

implementation

procedure LoadSettings;
var ini: TIniFile;
    reg: TRegistry;
begin
  { Load ini-stored settings }
  ini := TIniFile.Create( cConfigFileName );

  plc_out_mask := Byte( ini.ReadInteger( 'Communication', 'plc_out_mask', 0 ));

  plc_port   := ini.ReadInteger( 'Communication', 'plc_port', 1 );
  plc_baud   := ini.ReadInteger( 'Communication', 'plc_baud', 9600 );
  plc_parity := ini.ReadInteger( 'Communication', 'plc_parity', 3 );

  scale_port   := ini.ReadInteger( 'Communication', 'scale_port', 1 );
  scale_baud   := ini.ReadInteger( 'Communication', 'scale_baud', 9600 );
  scale_parity := ini.ReadInteger( 'Communication', 'scale_parity', 3 );

  printer_port   := ini.ReadInteger( 'Communication', 'printer_port', 1 );
  printer_baud   := ini.ReadInteger( 'Communication', 'printer_baud', 9600 );
  printer_parity := ini.ReadInteger( 'Communication', 'printer_parity', 3 );

  flap1_timeout   := ini.ReadInteger( 'Timeouts', 'flap1_timeout'   , 60 );
  flap2_timeout   := ini.ReadInteger( 'Timeouts', 'flap2_timeout'   , 60 );
  roulette_timeout:= ini.ReadInteger( 'Timeouts', 'roulette_timeout', 30 );
  elevator_timeout:= ini.ReadInteger( 'Timeouts', 'elevator_timeout', 5 );
  auger_timeout   := ini.ReadInteger( 'Timeouts', 'auger_timeout'   , 5 );

  water_qty       := ini.ReadFloat( 'Liquids', 'water_qty'   , 0 );
  water_flow      := ini.ReadFloat( 'Liquids', 'water_flow'  , 1 );
  oil_qty         := ini.ReadFloat( 'Liquids', 'oil_qty'   , 0 );
  oil_flow        := ini.ReadFloat( 'Liquids', 'oil_flow'  , 1 );

  capacity        := ini.ReadInteger( 'System', 'capacity', 1000 );
  zero_tolerance  := ini.ReadInteger( 'System', 'zero_tolerance', 5 );
  disch_time      := ini.ReadInteger( 'System', 'discharge_time', 5 );

  autostart_next_dose := ini.ReadBool( 'System', 'autostart_next_dose', True );
  autostart_next_order:= ini.ReadBool( 'System', 'autostart_next_order', True );
  alert_dose_done   := ini.ReadBool( 'System', 'alert_dose_done', True );
  alert_order_done  := ini.ReadBool( 'System', 'alert_order_done', True );

  sdSDispenserConnection := ini.ReadBool( 'System', 'sdSDispenserConnection', True );

  debug_mode     := ini.ReadBool( 'config', 'debug', false );

  ini.Free;

  { Load registry-stored settings }
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
{
  reg.OpenKey( cRegistryRoot + '\Communication\PLC', True );
  if reg.ValueExists( 'Port' ) then plc_port   := reg.ReadInteger( 'Port' )
  else plc_port := 1;
  if reg.ValueExists( 'Baud' ) then plc_baud   := reg.ReadInteger( 'Baud' )
  else plc_baud := 9600;
  if reg.ValueExists( 'Parity' ) then plc_parity := reg.ReadInteger( 'Parity' )
  else plc_parity := 2;

  reg.OpenKey( cRegistryRoot + '\Communication\Scales', True );
  if reg.ValueExists( 'Port' ) then scales_port   := reg.ReadInteger( 'Port' )
  else scales_port := 2;
  if reg.ValueExists( 'Baud' ) then scales_baud   := reg.ReadInteger( 'Baud' )
  else scales_baud := 9600;
  if reg.ValueExists( 'Parity' ) then scales_parity := reg.ReadInteger( 'Parity' )
  else scales_parity := 2;
}
  reg.Free;
end;

procedure SaveSettings;
var ini: TIniFile;
    reg: TRegistry;
begin
  { Save ini-stored settings }
  ini := TIniFile.Create( cConfigFileName );

  ini.WriteInteger( 'Communication', 'plc_port', plc_port );
  ini.WriteInteger( 'Communication', 'plc_baud', plc_baud );
  ini.WriteInteger( 'Communication', 'plc_parity', plc_parity );

  ini.WriteInteger( 'Communication', 'scale_port', scale_port );
  ini.WriteInteger( 'Communication', 'scale_baud', scale_baud );
  ini.WriteInteger( 'Communication', 'scale_parity', scale_parity );

  ini.WriteInteger( 'Communication', 'printer_port', printer_port );
  ini.WriteInteger( 'Communication', 'printer_baud', printer_baud );
  ini.WriteInteger( 'Communication', 'printer_parity', printer_parity );

  ini.WriteInteger( 'Timeouts', 'flap1_timeout'   , flap1_timeout );
  ini.WriteInteger( 'Timeouts', 'flap2_timeout'   , flap2_timeout );
  ini.WriteInteger( 'Timeouts', 'roulette_timeout', roulette_timeout );
  ini.WriteInteger( 'Timeouts', 'elevator_timeout', elevator_timeout );
  ini.WriteInteger( 'Timeouts', 'auger_timeout'   , auger_timeout );

  ini.WriteFloat( 'Liquids', 'water_qty' , water_qty );
  ini.WriteFloat( 'Liquids', 'water_flow', water_flow );
  ini.WriteFloat( 'Liquids', 'oil_qty'   , oil_qty );
  ini.WriteFloat( 'Liquids', 'oil_flow'  , oil_flow );

  ini.WriteInteger( 'System', 'capacity', capacity );
  ini.WriteInteger( 'System', 'zero_tolerance', zero_tolerance );
  ini.WriteInteger( 'System', 'discharge_time', disch_time );

  ini.WriteBool( 'System', 'autostart_next_dose', autostart_next_dose );
  ini.WriteBool( 'System', 'autostart_next_order', autostart_next_order );
  ini.WriteBool( 'System', 'alert_dose_done', alert_dose_done );
  ini.WriteBool( 'System', 'alert_order_done', alert_order_done );

  ini.WriteBool( 'System', 'sdSDispenserConnection', sdSDispenserConnection );

  ini.Free;

  { Save registry-stored settings }
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
{
  reg.OpenKey( cRegistryRoot + '\Communication\PLC', True );
  reg.WriteInteger( 'Port', plc_port );
  reg.WriteInteger( 'Baud', plc_baud );
  reg.WriteInteger( 'Parity', plc_parity );

  reg.OpenKey( cRegistryRoot + '\Communication\Scales', True );
  reg.WriteInteger( 'Port', scales_port );
  reg.WriteInteger( 'Baud', scales_baud );
  reg.WriteInteger( 'Parity', scales_parity );
}
  reg.Free;
end;

function HexToInt( hex: string ): longint;
var i: integer;
begin
  Result := 0;
  for i:=1 to Length(hex) do
    begin
      Result := Result * 16;
      if hex[i] in ['0'..'9'] then
        Result := Result + Ord(hex[i]) - Ord('0') else
      if UpCase(hex[i]) in ['A'..'F'] then
        Result := Result + Ord(UpCase(hex[i])) - Ord('A') + 10;
    end;
end;

initialization
  LoadSettings;
finalization
  SaveSettings;
end.

