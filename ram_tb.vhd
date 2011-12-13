entity ram_tb is
end ram_tb;


library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



architecture behav of ram_tb is

component sync_ram
port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector;
    datain  : in  std_logic_vector;
    dataout : out std_logic_vector
  );
end component;

signal data_in : std_logic_vector (15 downto 0):=   (others => '0');
signal data_out: std_logic_vector (7 downto 0);
signal address: std_logic_vector (18 downto 0) :=  (others => '0');
signal enable: std_logic := '0';
signal clock: std_logic:='0';

begin

myRam: sync_ram port map (clock, enable, address, data_in, data_out);
clock   <= not clock  after 5 ns;


enable <= '1' after 5 ns, not enable  after 10 ns;


address   <= address + 1  after 20 ns;
data_in   <= data_in + 1  after 20 ns;


end behav;
