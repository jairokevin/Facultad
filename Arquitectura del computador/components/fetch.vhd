LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY fetch IS
	GENERIC (N: INTEGER := 64);
   PORT (
			PCSrc_F,clk,reset: IN STD_LOGIC;
			PCBranch_F: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			imem_addr_F: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END;

ARCHITECTURE synth of fetch IS
CONSTANT FETCH_WIDTH : INTEGER := 64;

	-- multiplexor 2 * 1
	COMPONENT MUX2 IS
			GENERIC (
				N: integer := FETCH_WIDTH
			);
			PORT (
				d0, d1:	IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				s  		: IN STD_LOGIC;
			  y			: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

	-- signed adder
	COMPONENT ADDER IS
		GENERIC	(
			DATA_WIDTH : INTEGER := FETCH_WIDTH
		);
		PORT (
			a   	:	IN STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0);
			b  		: IN STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0);
			result: OUT STD_LOGIC_VECTOR((DATA_WIDTH-1) DOWNTO 0)
		);
	END COMPONENT;
	
	-- flip flop d
	COMPONENT FLOPR IS
	GENERIC (
		N: INTEGER := FETCH_WIDTH
	);
	PORT (
		q			: OUT STD_LOGIC_VECTOR( N-1 DOWNTO 0);
		d		: IN STD_LOGIC_VECTOR( N-1 DOWNTO 0);               
		clk		: IN  STD_LOGIC;                  
		reset	: IN  STD_LOGIC
	);
	END COMPONENT;

SIGNAL PC, PCnext, PCplus4: STD_LOGIC_VECTOR(FETCH_WIDTH-1 DOWNTO 0);

BEGIN 
FLOPR_F: FLOPR PORT MAP ( 
								d 		=> PCnext,
								clk 	=> clk, 
								reset => reset, 
								q 		=> PC
							);
ADDER_F: ADDER PORT MAP (
								a 			=> PC,
								b 			=> x"0000000000000004",
								result 	=> PCplus4
							);
MUX2_F: MUX2 PORT MAP (
							y		=> PCnext, 
							s 	=> PCsrc_F, 
							d0 	=> PCplus4,
							d1 	=> PCbranch_F
						);
imem_addr_F <= PC;
 
END synth;
