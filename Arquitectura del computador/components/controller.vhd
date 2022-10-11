LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controller IS
	PORT (
    instr: IN STD_LOGIC_VECTOR (10 downto 0);
    AluControl : OUT STD_LOGIC_VECTOR (3 downto 0);
    reg2loc, regWrite, AluSrc, memtoReg, memRead, memWrite : OUT STD_LOGIC;
	 Branch : OUT STD_LOGIC_VECTOR (1 downto 0)
  );
END;

architecture cont of controller is

signal funct : std_logic_vector (10 downto 0);
signal aluop : std_logic_vector (1 downto 0);

begin

maindec_0: entity work.maindec
	port map (
    Op => instr,
    Reg2Loc => Reg2Loc,
	 	ALUsrc => ALUsrc,
		MemtoReg => MemtoReg,
	 	RegWrite => RegWrite,
	 	MemRead => MemRead,
	 	MemWrite => MemWrite,
	 	Branch => Branch,
    AluOp => aluop
  );

aludec_0: entity work.aludec
	port map (
		funct => instr,
		aluop => aluop,
		alucontrol => alucontrol
	);
	
end cont;