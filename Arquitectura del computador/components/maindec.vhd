LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY maindec IS
	PORT(
		op: IN STD_LOGIC_VECTOR( 10 downto 0 );
		Reg2Loc, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite: out std_logic;
		Branch : out std_logic_vector (1 downto 0);
		AluOp: out std_logic_vector ( 1 downto 0 ));
END MAINDEC;

ARCHITECTURE synth OF maindec IS
BEGIN
	PROCESS(op)
	BEGIN	
		CASE op IS
			--R-format 
			WHEN "10001011000" | "11001011000" |
				 "10001010000" | "10101010000" =>
				Reg2Loc <= '0';
				ALUsrc <= '0';
				MemtoReg <= '0';
				RegWrite <= '1';
				MemRead <= '0';
				MemWrite <= '0'; 
				Branch <= "00"; 
				AluOp <= "10";
			-- ADDI	
			WHEN "10010001000" | "10010001001"  =>
				Reg2Loc <= '0';
				ALUsrc <= '1';
				MemtoReg <= '0';
				RegWrite <= '1';
				MemRead <= '0';
				MemWrite <= '0'; 
				Branch <= "00"; 
				AluOp <= "10";
			-- LDUR
			WHEN "11111000010" =>
				Reg2Loc <= '0';
				ALUsrc <= '1'; 
				MemtoReg <= '1'; 
				RegWrite <= '1'; 
				MemRead <= '1'; 
				MemWrite <= '0'; 
				Branch <="00"; 
				AluOp <= "00";
			-- STUR
			WHEN "11111000000" =>
				Reg2Loc <= '1'; 
				ALUsrc <= '1'; 
				MemtoReg <= '0';
				RegWrite <= '0';
				MemRead <= '0';
				MemWrite <= '1';
				Branch <= "00";
				AluOp <= "00";
			-- CBZ
			WHEN "10110100000" | "10110100001" |
				  "10110100010" | "10110100011" | 
				  "10110100100" | "10110100101" | 
				  "10110100110" | "10110100111" =>
				Reg2Loc <= '1';
				ALUsrc <= '0';
				MemtoReg <= '0'; 
				RegWrite <= '0';
				MemRead <= '0'; 
				MemWrite <= '0'; 
				Branch <="01";
				AluOp <= "01";
			WHEN "10110101000" | "10110101001" |
				  "10110101010" | "10110101011" | 
				  "10110101100" | "10110101101" | 
				  "10110101110" | "10110101111" =>
				Reg2Loc <= '1';
				ALUsrc <= '0';
				MemtoReg <= '0'; 
				RegWrite <= '0';
				MemRead <= '0'; 
				MemWrite <= '0'; 
				Branch <= "10";
				AluOp <= "01";
			WHEN OTHERS =>
				Reg2Loc <= '0';
				ALUsrc <= '0';
				MemtoReg <= '0'; 
				RegWrite <= '0'; 
				MemRead <= '0'; 
				MemWrite <= '0'; 
				Branch <= "00";
				AluOp <= "00";
		END CASE;
	END PROCESS;	
END synth;
