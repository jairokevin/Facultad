LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY regfile IS
   PORT (
		ra1, ra2, wa3: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		wd3: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		clk, we3: IN STD_LOGIC;
		rd1, rd2: OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END;
ARCHITECTURE synth of regfile IS
	SUBTYPE register_t IS STD_LOGIC_VECTOR(63 DOWNTO 0);
	TYPE ARM_registers IS ARRAY(0 to 31) of register_t; 
	SIGNAL regfile: ARM_registers := (
	/*0=>x"0000000000000000",
	1=>x"0000000000000001",
	2=>x"0000000000000002",
	3=>x"0000000000000003",
	4=>x"0000000000000004",
	5=>x"0000000000000005",
	6=>x"0000000000000006",
	7=>x"0000000000000007",
	8=>x"0000000000000008",
	9=>x"0000000000000009",
	10=>x"000000000000000a",	
	11=>x"000000000000000b",
	12=>x"000000000000000c",
	13=>x"000000000000000d",
	14=>x"000000000000000e",
	15=>x"000000000000000f",
	16=>x"0000000000000010",
	17=>x"0000000000000011",
	18=>x"0000000000000012",
	19=>x"0000000000000013",
	20=>x"0000000000000014",
	21=>x"0000000000000015",
	22=>x"0000000000000016",
	23=>x"0000000000000017",
	24=>x"0000000000000018",
	25=>x"0000000000000019",	
	26=>x"000000000000001a",
	27=>x"000000000000001b",
	28=>x"000000000000001c",
	29=>x"000000000000001d",
	30=>x"000000000000001e",*/
	OTHERS => (OTHERS => '0')); 
BEGIN
	PROCESS(clk)
	BEGIN
	-- Write register
		IF RISING_EDGE(clk) THEN
			IF we3 = '1' THEN
				regfile(to_integer(unsigned(wa3))) <= wd3;
			END IF;
		END IF;
	END PROCESS;
	-- Read registers
		rd1 <= wd3 when (wa3 = ra1 and we3='1') else regfile(to_integer(unsigned(ra1)));
		rd2 <= wd3 when (wa3 = ra2 and we3='1') else regfile(to_integer(unsigned(ra2)));	
END synth;
	
