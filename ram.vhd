-- from http://www.doulos.com/knowhow/vhdl_designers_guide/models/simple_ram_model/

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;
use IEEE.std_logic_unsigned.all;

entity sync_ram is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector;
    datain  : in  std_logic_vector;
    dataout : out std_logic_vector
  );
end entity sync_ram;




architecture read_write of sync_ram is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(datain'range);
   signal ram : ram_type;
   signal read_address : std_logic_vector(address'range);

procedure handle (a, b : integer) is
  begin
    assert false severity failure;
  end handle;
  attribute foreign of handle : procedure is "VHPIDIRECT handle_data";



begin

  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
	handle(conv_integer(address), conv_integer(datain));
      end if;
      read_address <= address;
    end if;
  end process RamProc;

  dataout <= ram(to_integer(unsigned(read_address)));

end architecture read_write;




architecture write_only of sync_ram is

procedure handle (a, b : integer) is
  begin
    assert false severity failure;
  end handle;
  attribute foreign of handle : procedure is "VHPIDIRECT handle_data";

begin

  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
      if we = '1' then
	handle(conv_integer(address), conv_integer(datain));
      end if;
    end if;
  end process RamProc;

end architecture write_only;
