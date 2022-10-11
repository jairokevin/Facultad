LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY alu IS
	GENERIC (N: INTEGER := 64);
   PORT (
   		a,b: IN STD_LOGIC_VECTOR(N-1 downto 0);
      alucontrol: IN STD_LOGIC_VECTOR(3 downto 0);
      result: OUT STD_LOGIC_VECTOR(N-1 downto 0);
      zero: OUT STD_LOGIC
    ); 
END;

ARCHITECTURE synth of alu is
	SIGNAL a_sig, b_sig: SIGNED(N-1 DOWNTO 0);
	SIGNAL result_temp: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN
	a_sig <= SIGNED(a);
	b_sig <= SIGNED(b);

	PROCESS(a,b,alucontrol,a_sig,b_sig)
	BEGIN
		CASE alucontrol IS
			WHEN "0000" =>  
				result_temp <= a AND b;
			WHEN "0001" =>
				result_temp <= a OR b;
			WHEN "0010" => 	
				result_temp <= STD_LOGIC_VECTOR(a_sig + b_sig);
			WHEN "0110" =>
				result_temp <= STD_LOGIC_VECTOR(a_sig - b_sig);
			WHEN "0111" =>	
				result_temp <= b;
			WHEN "1100" => 
				result_temp <= a NOR b;
			WHEN OTHERS =>
				result_temp <= (OTHERS => '-');
			END CASE;	
	END PROCESS;
	
	result <= result_temp;
	zero <= '1' WHEN result_temp = (result_temp'range => '0') ELSE '0';
END synth;