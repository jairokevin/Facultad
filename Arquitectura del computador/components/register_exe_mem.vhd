LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_exe_mem IS
  PORT (
    clk   : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    -- Branch signals
    branch_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    branch_out: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
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
    PC_Branch_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    PC_Branch_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- Zero signal
    zero_in : IN STD_LOGIC; 
    zero_out: OUT STD_LOGIC;
    -- sign inmmediate signals
    aluResult_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    aluResult_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- read data signals
    writeData_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    writeData_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- register to wirte in write-back
    regToWrite_in : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    regToWrite_out: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  );
END;

ARCHITECTURE behav OF register_exe_mem IS

SIGNAL WBContrLines_in, WBContrLines_out: STD_LOGIC_VECTOR (1 DOWNTO 0); 
SIGNAL MAContrLines_in, MAContrLines_out: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL zero_in_s, zero_out_s: STD_LOGIC_VECTOR (0 DOWNTO 0);

BEGIN
  -- Write-back stage control lines 
  WBContrLines_in <= regWrite_in & memtoReg_in;
  WBstage_exe_mem: ENTITY WORK.flopr
      GENERIC MAP (
        N => 2
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => WBContrLines_in,
        q     => WBContrLines_out
      );

  -- Memory access stage control lines 
  MAContrLines_in <= branch_in & memRead_in & memWrite_in;
  MAstage_exe_mem: ENTITY WORK.flopr
      GENERIC MAP (
        N => 4
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => MAContrLines_in,
        q     => MAContrLines_out
      );

  PCBranch_exe_mem: ENTITY WORK.flopr
      GENERIC MAP (
        N => 64
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => PC_Branch_in,
        q     => PC_Branch_out
      );

  zero_in_s(0) <= zero_in; 	
  zero_exe_mem: ENTITY WORK.flopr
    GENERIC MAP (
      N => 1
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => zero_in_s,
      q     => zero_out_s
    );    

  aluResult_exe_mem: ENTITY WORK.flopr
      GENERIC MAP (
        N => 64
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => aluResult_in,
        q     => aluResult_out
      );  

  writeData_exe_mem: ENTITY WORK.flopr
    GENERIC MAP (
      N => 64
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => writeData_in,
      q     => writeData_out
    );

  regToWrite_exe_mem: ENTITY WORK.flopr
    GENERIC MAP (
      N => 5
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => regToWrite_in,
      q     => regToWrite_out
    );

regWrite_out    <= WBContrLines_out(1);
memtoReg_out    <= WBContrLines_out(0);
branch_out      <= MAContrLines_out(3 DOWNTO 2); 
memRead_out     <= MAContrLines_out(1);
memWrite_out    <= MAContrLines_out(0);
zero_out <= zero_out_s(0);

END behav;