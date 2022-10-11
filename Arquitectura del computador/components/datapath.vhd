library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity datapath is
	generic (N: integer := 64);
  port (
    reset,
    clk,
    reg2loc, 
    regWrite, 
    AluSrc,
    memtoReg, 
    memRead,
    memWrite				: in std_logic;
	 Branch 					: in std_logic_vector (1 downto 0);
    AluControl 			: in std_logic_vector (3 downto 0);
		IM_readData 		: in std_logic_vector (31 downto 0);
		DM_readData 		: in std_logic_vector (N-1 downto 0);
		IM_addr,DM_addr, 
		DM_writeData		: out std_logic_vector (N-1 downto 0);
    DM_writeEnable, DM_readEnable : out std_logic
  );
end;

architecture behav of datapath is
--- Signals
-- PCSrc = sale de memory y llega hasta el fetch.
-- PCBranch = sale de memory y llega hasta el fetch. 
signal 	PCSrc, AluSrc_id_exe, 
				zero, zero_exe_mem,  				
				memRead_id_exe, memRead_exe_mem, 
				memWrite_id_exe, memWrite_exe_mem,
				regWrite_id_exe, regWrite_exe_mem, regWrite_mem_wb, 
				memtoReg_id_exe, memtoReg_exe_mem, memtoReg_mem_wb : std_logic := ('-');

signal Branch_id_exe, Branch_exe_mem : std_logic_vector (1 downto 0);
				
				
signal 	PCBranch, PCBranch_exe_mem, 
				PC_4, PC_4_if_id, PC_4_id_exe, 
				writeData_D, signImm, signImm_id_exe,
				readData1, readData1_id_exe,
				readData2, readData2_id_exe,
			 	DM_readData_s, DM_readData_s_mem_wb: std_logic_vector (N-1 downto 0) := (OTHERS => '0');

signal aluResult, aluResult_exe_mem, aluResult_mem_wb,
		 writeData, writeData_exe_mem: std_logic_vector (N-1 downto 0) := (OTHERS => '0');

signal AluControl_id_exe: std_logic_vector (3 downto 0) := (OTHERS => '0');				
				
signal 	regToWrite, regToWrite_id_exe,
				regToWrite_exe_mem, regToWrite_mem_wb : std_logic_vector (4 downto 0) := (OTHERS => '-');

signal 	instr_if_id: std_logic_vector (31 downto 0) := (OTHERS => '0');

begin

-- Fetch Inst
fetch_0: entity work.fetch 
	generic map (
		N => N
	)
	port map (
		-- inputs 
		clk 				=> clk,
		reset 			=> reset,
		PCSrc_F 		=> PCSrc,
		PCBranch_F 	=> PCBranch_exe_mem,
		-- outputs
		imem_addr_F => PC_4
	);
	
-- Register IF/ID
register_if_id_0: entity work.register_if_id
	port map (
		-- inputs
		clk 			=> clk,
		reset 		=> reset,
		instr_in 	=> IM_readData,
		PC_4_in 	=> PC_4,
		-- outputs 
		PC_4_out 	=> PC_4_if_id,
		instr_out => instr_if_id
	); 

regToWrite <= instr_if_id(4 downto 0);

-- Decode Inst
decode_0: entity work.decode 
	generic map (
		N => N)
	port map (
		clk 					=> clk,
		regWrite_D 		=> regWrite_mem_wb,
		reg2loc_D 		=> reg2loc,
		writeData3_D 	=> writeData_D,
		writeReg3_D 	=> regToWrite_mem_wb,
		instr_D 			=> instr_if_id,
		-- outputs
		signImm_D 		=> signImm,
		readData1_D 	=> readData1,
		readData2_D 	=> readData2	
	);

-- Register ID/EXE	
register_id_exe_0: ENTITY WORK.register_id_exe
	port map (
	 clk 	=> clk,
    reset => reset,
    aluSrc_in 	=> AluSrc,
    aluSrc_out 	=> AluSrc_id_exe,
    aluControl_in => AluControl,
    aluControl_out => AluControl_id_exe,
    branch_in => Branch,
    branch_out => Branch_id_exe,
    memRead_in => memRead,
    memRead_out => memRead_id_exe,
    memWrite_in => memWrite,
    memWrite_out => memWrite_id_exe,
    regWrite_in => RegWrite,
    regWrite_out => regWrite_id_exe,
    memtoReg_in => memtoReg,
    memtoReg_out => memtoReg_id_exe,
    PC_4_in => PC_4_if_id,
    PC_4_out => PC_4_id_exe,
    signimm_in => signImm,
    signimm_out => signImm_id_exe,
    readData1_in => readData1,
    readData1_out => readData1_id_exe,
    readData2_in => readData2,
    readData2_out => readData2_id_exe,
    regToWrite_in => regToWrite,
    regToWrite_out => regToWrite_id_exe
	);

-- Excecute
execute_0: entity work.execute 
	generic map (
		N => N)
	port map (
		aluSrc => AluSrc_id_exe,
		aluControl => AluControl_id_exe,
		PC_E => PC_4_id_exe,
		SignImm_E => signImm_id_exe,
		readData1_E => readData1_id_exe,
		readData2_E => readData2_id_exe,
		PCBranch_E => PCBranch,
		aluResult_E => aluResult,
		writeData_E => writeData,	
		zero_E => zero	
	);

-- Register EXE/MEM	
register_exe_mem_0: ENTITY WORK.register_exe_mem
	port map (
		clk 	=> clk,
		reset => reset,
    branch_in => Branch_id_exe,
    branch_out => Branch_exe_mem,
    memRead_in => memRead_id_exe,
    memRead_out => memRead_exe_mem,
    memWrite_in => memWrite_id_exe,
    memWrite_out => memWrite_exe_mem,
    regWrite_in => regWrite_id_exe,
    regWrite_out => regWrite_exe_mem,
    memtoReg_in => memtoReg_id_exe,
    memtoReg_out => memtoReg_exe_mem,
    PC_Branch_in => PCBranch,
    PC_Branch_out => PCBranch_exe_mem,
    zero_in => zero,
    zero_out => zero_exe_mem,
    aluResult_in => aluResult,
    aluResult_out => aluResult_exe_mem,
    writeData_in => writeData,
    writeData_out => writeData_exe_mem,
    regToWrite_in => regToWrite_id_exe,
    regToWrite_out => regToWrite_exe_mem
	);

-- Memory
DM_addr <= aluResult_exe_mem;
DM_writeData <= writeData_exe_mem;
DM_writeEnable <= memWrite_exe_mem;
DM_readEnable <= memRead_exe_mem;
DM_readData_s <= DM_readData;

memory_0: entity work.memory
    port map (
	 		Branch 	=> Branch_exe_mem, 
	 		zero 		=> zero_exe_mem,
			PCSrc 	=> PCSrc
	 );

-- Register MEM/WB
register_mem_wb_0: ENTITY WORK.register_mem_wb
	port map (
		clk => clk,
		reset => reset,
		regWrite_in => regWrite_exe_mem,
		regWrite_out => regWrite_mem_wb, 
		memtoReg_in => memtoReg_exe_mem,
		memtoReg_out => memtoReg_mem_wb,
		writeData_in => aluResult_exe_mem,
		writeData_out => aluResult_mem_wb,
		readData_in => DM_readData_s,
		readData_out => DM_readData_s_mem_wb,
		regToWrite_in => regToWrite_exe_mem, 
		regToWrite_out => regToWrite_mem_wb
	);
		
-- Writeback
writeback_0: entity work.writeback 
  port map (
	 	aluResult 	=> aluResult_mem_wb,
	 	DM_readData => DM_readData_s_mem_wb,
	 	memtoReg 	=> memtoReg_mem_wb,
   	writeData 	=> writeData_D 
	);

-- Other 
IM_addr <= PC_4;

end architecture;
