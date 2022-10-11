LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY adder IS
	GENERIC(DATA_WIDTH: INTEGER := 64);
   PORT (
	 		a, b: IN STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
			result: OUT STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0)
		);
END;

ARCHITECTURE behavior OF adder IS
    BEGIN
    result <= STD_LOGIC_VECTOR(SIGNED(a) + SIGNED(b));
END behavior;

