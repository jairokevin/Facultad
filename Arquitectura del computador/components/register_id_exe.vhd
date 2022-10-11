LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_id_exe IS
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
END;

ARCHITECTURE behav OF register_id_exe IS

SIGNAL WBContrLines_in, WBContrLines_out: STD_LOGIC_VECTOR (1 DOWNTO 0); 
SIGNAL MAContrLines_in, MAContrLines_out: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL EAContrLines_in, EAContrLines_out: STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN
  -- Write-back stage control lines 
  WBContrLines_in <= regWrite_in & memtoReg_in;
  WBstage_id_exe: ENTITY WORK.flopr
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
  MAstage_id_exe: ENTITY WORK.flopr
      GENERIC MAP (
        N => 4
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => MAContrLines_in,
        q     => MAContrLines_out
      );

  -- Execution/address calculation stage control lines 
  EAContrLines_in <= aluSrc_in & aluControl_in;
  EAstage_id_exe: ENTITY WORK.flopr
      GENERIC MAP (
        N => 5
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => EAContrLines_in,
        q     => EAContrLines_out
      );

  next_addres_id_exe: ENTITY WORK.flopr
      GENERIC MAP (
        N => 64
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => PC_4_in,
        q     => PC_4_out
      );

  signimm_id_exe: ENTITY WORK.flopr
      GENERIC MAP (
        N => 64
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => signimm_in,
        q     => signimm_out
      );  

  readData1_id_exe: ENTITY WORK.flopr
    GENERIC MAP (
      N => 64
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => readData1_in,
      q     => readData1_out
    );

  readData2_id_exe: ENTITY WORK.flopr
    GENERIC MAP (
      N => 64
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => readData2_in,
      q     => readData2_out
    );  

  regToWrite_id_exe: ENTITY WORK.flopr
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
aluSrc_out      <= EAContrLines_out(4);
aluControl_out  <= EAContrLines_out(3 DOWNTO 0);

END behav;
