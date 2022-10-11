library ieee;
use ieee.std_logic_1164.all;

entity memory is
    port(
	 zero: in std_logic;
    Branch: in std_logic_vector (1 downto 0);
	 PCSrc: out std_logic
	 );
end entity;

architecture behav of memory is

begin
process(Branch,zero)
	begin 
		if (Branch = "01" and zero = '1') then 
			PCSrc <= '1';
		elsif (Branch = "01" and zero = '0') then 
			PCSrc <= '0';
		elsif (Branch = "10" and zero = '0') then
			PCSrc <= '1';
		elsif (Branch = "10" and zero = '1') then 
			PCSrc <= '0';
		else 
			PCSrc <= '0';
		end if;
	end process;
end architecture;