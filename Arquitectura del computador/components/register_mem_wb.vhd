LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_mem_wb IS
  PORT (
    clk   : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    -- RegWrite signals    
    regWrite_in : IN STD_LOGIC;
    regWrite_out: OUT STD_LOGIC;
    -- RegWrite signals    
    memtoReg_in : IN STD_LOGIC;
    memtoReg_out: OUT STD_LOGIC;
    -- write data signals (comes from alu)
    writeData_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    writeData_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- read data signals (comes from memory)
    readData_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    readData_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    -- register to write in write-back
    regToWrite_in : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    regToWrite_out: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  );
END;

ARCHITECTURE behav OF register_mem_wb IS

SIGNAL WBContrLines_in, WBContrLines_out: STD_LOGIC_VECTOR (1 DOWNTO 0); 

BEGIN
  -- Write-back stage control lines 
  WBContrLines_in <= regWrite_in & memtoReg_in;
  WBstage_mem_wb: ENTITY WORK.flopr
      GENERIC MAP (
        N => 2
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => WBContrLines_in,
        q     => WBContrLines_out
      );

  writeData_mem_wb: ENTITY WORK.flopr
      GENERIC MAP (
        N => 64
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => writeData_in,
        q     => writeData_out
      );

  readData_mem_wb: ENTITY WORK.flopr
    GENERIC MAP (
      N => 64
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => readData_in,
      q     => readData_out
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

END behav;