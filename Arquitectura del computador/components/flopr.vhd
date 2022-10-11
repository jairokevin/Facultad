LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

ENTITY flopr IS
	GENERIC (N: INTEGER := 64);
	PORT (q: out STD_LOGIC_VECTOR( N-1 downto 0);
			d: in  STD_LOGIC_VECTOR( N-1 downto 0);               
			clk: in  STD_LOGIC;                  
			reset: in  STD_LOGIC);
END;
ARCHITECTURE synth of flopr IS
BEGIN
	PROCESS(clk, reset)
	BEGIN
		IF (reset = '1') THEN
			q <= (OTHERS => '0');
		ELSIF RISING_EDGE(clk) THEN
			q <= d;
		END IF;
	END PROCESS;
END synth;	
