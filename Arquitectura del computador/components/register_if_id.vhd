LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_if_id IS
  PORT (
    clk  : IN STD_LOGIC;
    reset: IN STD_LOGIC;
    -- intruction fetched from memory
    instr_in : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    instr_out: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    -- next address to fetch
    PC_4_in : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    PC_4_out: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)    
  );
END;

ARCHITECTURE behav OF register_if_id IS
BEGIN

  instr_if_id: ENTITY WORK.flopr
    GENERIC MAP (
      N => 32
    )
    PORT MAP (
      clk   => clk,
      reset => reset,
      d     => instr_in,
      q     => instr_out
    );

  next_addres_if_id: ENTITY WORK.flopr
      GENERIC MAP (
        N => 64
      )
      PORT MAP (
        clk   => clk,
        reset => reset,
        d     => PC_4_in,
        q     => PC_4_out
      );

END behav;
