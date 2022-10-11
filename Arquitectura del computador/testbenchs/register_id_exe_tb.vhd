library ieee;
use ieee.std_logic_1164.all;

entity register_id_exe_tb is
end register_id_exe_tb;

architecture Behavior of register_id_exe_tb is

constant ADDR_WIDTH : integer := 64;
constant INSTR_WIDTH: integer := 32;
Constant CLK_PERIOD : time := 20 ns;

component register_id_exe IS
  PORT (
    clk   : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    -- AluSrc signals
    aluSrc_in : IN STD_LOGIC;
    aluSrc_out: OUT STD_LOGIC;
    -- AluControl signals
    aluControl_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    aluControl_out: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    -- Branch signals
    branch_in : IN STD_LOGIC;
    branch_out: OUT STD_LOGIC;
    -- MemRead signals
    memRead_in : IN STD_LOGIC;
    memRead_out: OUT STD_LOGIC;
    -- MemWrite signals    
    memWrite_in : IN STD_LOGIC;
    memWrite_out: OUT STD_LOGIC;
    -- RegWrite signals    
    regWrite_in : IN STD_LOGIC;
    regWrite_out: OUT STD_LOGIC;
    -- RegWrite signals    
    memtoReg_in : IN STD_LOGIC;
    memtoReg_out: OUT STD_LOGIC;
    -- next address to fetch
    PC_4_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    PC_4_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- sign inmmediate signals
    signimm_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    signimm_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- read data signals
    readData1_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    readData1_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    readData2_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    readData2_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- register to write in write-back
    regToWrite_in : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    regToWrite_out: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  );
end component;

-- Input Signals
signal aluControl_in : std_logic_vector (3 downto 0);
signal regToWrite_in : std_logic_vector (4 downto 0);
signal PC_4_in, signimm_in, readData1_in, readData2_in : std_logic_vector (ADDR_WIDTH-1 downto 0);
signal aluSrc_in, branch_in, memRead_in, memWrite_in, regWrite_in, memtoReg_in : std_logic;
signal clk,finish : std_logic:= '0';
signal reset : std_logic:= '1';
-- Output Signals
signal PC_4_out, signimm_out, readData1_out, readData2_out : std_logic_vector (ADDR_WIDTH-1 downto 0);
signal aluControl_out : std_logic_vector (3 downto 0);
signal regToWrite_out : std_logic_vector (4 downto 0);
signal aluSrc_out, branch_out, memRead_out, memWrite_out, regWrite_out, memtoReg_out : std_logic;

begin
	dut: register_id_exe
	port map (
		clk => clk,
    	reset => reset,
       	aluSrc_in => aluSrc_in,
    	aluSrc_out => aluSrc_out,
        aluControl_in => aluControl_in,
    	aluControl_out => aluControl_out,
      	branch_in => branch_in,
    	branch_out => branch_out,
        memRead_in => memRead_in, 
    	memRead_out => memRead_out,
		memWrite_in => memWrite_in,
	    memWrite_out => memWrite_out,
    	regWrite_in => regWrite_in,
    	regWrite_out => regWrite_out,
        memtoReg_in => memtoReg_in,
    	memtoReg_out => memtoReg_out,
        PC_4_in => PC_4_in,
    	PC_4_out => PC_4_out,
        signimm_in => signimm_in,
    	signimm_out => signimm_out,
        readData1_in => readData1_in,
    	readData1_out => readData1_out,
    	readData2_in => readData2_in,
    	readData2_out => readData2_out,
	    regToWrite_in => regToWrite_in,
    	regToWrite_out => regToWrite_out
	);
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal
	test_proc: process
	begin

       	aluSrc_in <= '0';
    	aluControl_in <= "0101";
    	branch_in <= '1';
    	memRead_in <= '0'; 
    	memWrite_in <= '0';
	    regWrite_in <= '1';
    	memtoReg_in <= '0';
    	PC_4_in <= x"0000000FFFFFFFFF";
    	signimm_in <= x"0004000FFFFFFFFF";
    	readData1_in <= x"0004200FFFFFFFFF";
    	readData2_in <= x"0004215FFFFFFFFF";
    	regToWrite_in <= "00101"; 
    	reset <= '1'; 
		
		wait for 20ns;
		
		assert (aluSrc_out = '0')  -- expected output
		report "test failed for reset = 0 in aluSrc" severity error;		
		assert (aluControl_out = "0000")
		report "test failed for reset = 0 in aluControl" severity error;
		assert (branch_out = '0')  -- expected output
		report "test failed for reset = 1 in branch" severity error;		
		assert (memRead_out = '0')
		report "test failed for reset = 1 in memRead" severity error;		
		assert (memWrite_out = '0')  -- expected output
		report "test failed for reset = 1 in memWrite" severity error;		
		assert (regWrite_out = '0')
		report "test failed for reset = 1 in regWrite" severity error;
		assert (memtoReg_out = '0')
		report "test failed for reset = 1 in memtoReg" severity error;
		assert (PC_4_out = x"0000000000000000")
		report "test failed for reset = 1 in PC_4" severity error;
		assert (signimm_out = x"0000000000000000")
		report "test failed for reset = 1 in signimm" severity error;
		assert (readData1_out = x"0000000000000000")
		report "test failed for reset = 1 in readData1" severity error;
		assert (readData2_out = x"0000000000000000")
		report "test failed for reset = 1 in readData2" severity error;
		assert (regToWrite_out = "00000")
		report "test failed for reset = 1 in regToWrite" severity error;
	
		reset <= '0'; 
		
		wait for 20ns;
		
		assert (aluSrc_out = '0')  -- expected output
		report "test failed for reset = 0 in aluSrc" severity error;		
		assert (aluControl_out = "0101")
		report "test failed for reset = 0 in aluControl" severity error;
		assert (branch_out = '1')  -- expected output
		report "test failed for reset = 0 in branch" severity error;		
		assert (memRead_out = '0')
		report "test failed for reset = 0 in memRead" severity error;		
		assert (memWrite_out = '0')  -- expected output
		report "test failed for reset = 0 in memWrite" severity error;		
		assert (regWrite_out = '1')
		report "test failed for reset = 0 in regWrite" severity error;
		assert (memtoReg_out = '0')
		report "test failed for reset = 0 in memtoReg" severity error;
		assert (PC_4_out = x"0000000FFFFFFFFF")
		report "test failed for reset = 0 in PC_4" severity error;
		assert (signimm_out = x"0004000FFFFFFFFF")
		report "test failed for reset = 0 in sigimm" severity error;
		assert (readData1_out = x"0004200FFFFFFFFF")
		report "test failed for reset = 0 in readData1" severity error;
		assert (readData2_out = x"0004215FFFFFFFFF")
		report "test failed for reset = 0 in readData2" severity error;
		assert (regToWrite_in = "00101")
		report "test failed for reset = 0 in regToWrite" severity error;
	
		finish <= '1';
		wait;
	end process;
end;
