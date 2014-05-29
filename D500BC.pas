unit D500BC;

interface

uses SysUtils;

const
  chSTX = #$02;
  chETX = #$03;

function FormatData( Address: char; FileType: char; Data: string ): string;
function ASCIIHex( Value: char ): string;

implementation

function FormatData( Address: char; FileType: char; Data: string ): string;
var xs: byte;  { xOR sum }
    i : integer;
begin
  Result := chSTX +
            Address +
            FileType +
            '0' +
            Data;

  xs := Byte( Result[1] );

  for i:=2 to Length( Result ) do
    xs := xs xor Byte( Result[i] );

  Result := Result +
            Char( Byte('0') + ( xs mod 16) ) +
            Char( Byte('0') + ( xs div 16) ) +
            chETX;
end;

function ASCIIHex( Value: char ): string;
begin
{
  Result := Char( Byte('0') + ( byte(Value) div 16) ) +
            Char( Byte('0') + ( byte(Value) mod 16) );
}
  Result := IntToHex( Byte(Value), 2 );
end;

end.
