LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY execute IS 
	GENERIC(N: INTEGER := 64);
	PORT(
		aluSrc: IN STD_LOGIC;
		aluControl: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		PC_E, SignImm_E: IN STD_LOGIC_VECTOR(N-1 downto 0);
		readData1_E, readData2_E: IN STD_LOGIC_VECTOR(N-1 downto 0);
		PCBranch_E, aluResult_E: OUT std_logic_vector(N-1 downto 0);
		writeData_E: OUT std_logic_vector(N-1 downto 0);
		zero_E: OUT std_logic);

END;
ARCHITECTURE synth of execute IS
CONSTANT EXECUTE_WIDTH : INTEGER := 64;
	-- ADDER
	COMPONENT ADDER IS
		GENERIC(DATA_WIDTH : INTEGER := EXECUTE_WIDTH);
		PORT(
			a: IN STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0);
			b: IN STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0);
			result : out STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0)
		);
	END COMPONENT;
	--- SHIFT LEFT
	COMPONENT SL2 IS
		GENERIC(WIDTH: INTEGER := EXECUTE_WIDTH);
		PORT (
			a : in STD_LOGIC_VECTOR(N-1 downto 0);
         y : out STD_LOGIC_VECTOR(N-1 downto 0)); 
	END COMPONENT;
	--- ALU
	COMPONENT ALU IS
		GENERIC (N: INTEGER := EXECUTE_WIDTH);
		PORT (a,b: IN STD_LOGIC_VECTOR(N-1 downto 0);
         alucontrol: IN STD_LOGIC_VECTOR(3 downto 0);
         result: OUT STD_LOGIC_VECTOR(N-1 downto 0);
         zero: OUT STD_LOGIC); 
	END COMPONENT;
	--- MUX2
	COMPONENT MUX2 IS
			GENERIC (N: INTEGER := EXECUTE_WIDTH);
			PORT(d0,d1: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				  s: IN STD_LOGIC;
			     y: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;
	
	SIGNAL SrcB_add, SrcB_alu: STD_LOGIC_VECTOR(EXECUTE_WIDTH-1 DOWNTO 0) := (others => '0');
BEGIN 		
	
	ADDER_E: ADDER PORT MAP(a=> PC_E, b=> SrcB_add, result=> PCBranch_E);
	ALU_E: ALU PORT MAP(a=>readData1_E, b=>SrcB_alu, alucontrol=> aluControl, result=> AluResult_E, zero=> Zero_E);	
	MUX2_E: MUX2 PORT MAP(d0=> readData2_E, d1=> SignImm_E, y=> SrcB_alu, s=> AluSrc);
	SL2_E: SL2 PORT MAP (a=> SignImm_E, y=> SrcB_add);
	
	writeData_E <= readData2_E;

END synth;			
			
