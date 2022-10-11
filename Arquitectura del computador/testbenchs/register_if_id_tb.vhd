library ieee;
use ieee.std_logic_1164.all;

entity register_if_id_tb is
end register_if_id_tb;

architecture Behavior of register_if_id_tb is

constant ADDR_WIDTH : integer := 64;
constant INSTR_WIDTH: integer := 32;
Constant CLK_PERIOD : time := 20 ns;

component register_if_id IS
  port (
    clk  : IN STD_LOGIC;
    reset: IN STD_LOGIC;
    -- intruction fetched from memory
    instr_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    instr_out: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    -- next address to fetch
    PC_4_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    PC_4_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)    
  );
end component;

-- Input Signals
signal instr_in : std_logic_vector (INSTR_WIDTH-1 downto 0);
signal PC_4_in : std_logic_vector (ADDR_WIDTH-1 downto 0);
signal clk,finish : std_logic:= '0';
signal reset		: std_logic:= '1';
-- Output Signals
signal instr_out : std_logic_vector (INSTR_WIDTH-1 downto 0);
signal PC_4_out : std_logic_vector (ADDR_WIDTH-1 downto 0);

begin
	dut: register_if_id
	port map (
		instr_in => instr_in,
		instr_out => instr_out,
		PC_4_out => PC_4_out,		
		PC_4_in => PC_4_in,
		clk => clk,
		reset => reset
	);
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal
	test_proc: process
	begin
		instr_in <= x"0000000F";
		PC_4_in <= x"0000000FFFFFFFFF";
		reset <= '1'; 
		
		wait for 20ns;
		
		assert (instr_out = x"00000000")  -- expected output
		report "test failed for reset = 1" severity error;		
		assert (PC_4_out = x"0000000000000000")
		report "test failed for reset = 1" severity error;
		
		reset <= '0'; 
		
		wait for 20ns;
		
		assert (instr_out = x"0000000F")  -- expected output
		report "test failed for reset = 0" severity error;		
		assert (PC_4_out = x"0000000FFFFFFFFF")
		report "test failed for reset = 0" severity error;
		finish <= '1';
		wait;
	end process;
end;
