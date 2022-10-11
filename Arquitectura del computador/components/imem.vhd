-- Quartus II VHDL Template
-- Single-Port ROM

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY imem is
	generic( 
		N : natural := 32;
		ADDR_WIDTH : natural := 6);
	PORT(
		addr: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		q: OUT STD_LOGIC_VECTOR(N -1 DOWNTO 0));
END ENTITY;
ARCHITECTURE rtl OF imem IS
	-- Build a 2-D array type for the ROM
	SUBTYPE word_t IS STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	TYPE memory_t is array(0 TO 2**ADDR_WIDTH-1) OF word_t;
	SIGNAL rom : memory_t := (
	/* Programa del ejercicio 1
	x"f84000a6",
	x"cb010129",
	x"cb0400a5",
	x"8b0600e7",
	x"b4000109",
	x"00000000",
	x"00000000",
	x"00000000",
	x"b4ffff1f",
	x"00000000",
	x"00000000",
	x"00000000",
	*/
	/*Test para todas las instrucciones
	x"8b020021",
	x"00000000",
	x"00000000",
	x"f8008001",
	x"91000461",
	x"00000000",
	x"00000000",
	x"f8010001",
	x"cb020081",
	x"00000000",
	x"00000000",
	x"f8018001",
	x"8a0200eb",
	x"00000000",
	x"00000000",
	x"f802000b",
	x"aa08008c",
	x"00000000",
	x"00000000",
	x"f802800c",
	x"00000000",
	x"00000000",
	x"f8428005",
	x"00000000",
	x"00000000",
	x"f8030005",
	x"b40000a0",
	x"00000000",
	x"00000000",
	x"00000000",
	x"f8038005",
	x"f8040001",
	x"b50000a5",
	x"8b000000",
	x"00000000",
	x"00000000",
	x"f8048005",
	x"f8050001",
	x"b4000000",
	Programa del ejercicio 4*/
	/* Programa para ejercicio 2
	x"91000bc0",
	x"00000000",
	x"00000000",
	x"91000801",
	x"00000000",
	x"00000000",
	x"91000822",
	x"00000000",
	x"00000000",
	x"91000843",
	x"f80003c0",
	x"f80083c1",
	x"f80103c2",
	x"f80183c3",*/
	/*Programa para los led*/
	x"9102abd4",
	x"910157d5",
	x"8b1e03c0",
	x"910007c1",
	x"910033c6",
	x"910005ef",
	x"8a150285",
	x"aa150284",
	x"8b000022",
	x"8b1e0020",
	x"00000000",
	x"f80003c2",
	x"f84003c1",
	x"cb0f00c6",
	x"00000000",
	x"00000000",
	x"00000000",
	x"b5fffee6",
	x"00000000",
	x"00000000",
	x"00000000",
	x"f80003c4",
	x"f80003c5",
	x"f80003c4",
	x"b4fffd1e",
	others => x"00000000"
  );
	begin
		q <= rom(conv_integer(addr));
end rtl;
