library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mult_top is

	generic
	(
		LP_TOP : natural := 3
	);

	port 
	(
		clk_TOP	  : in std_logic;
		rst_TOP	  : in std_logic;
		Mzao_TOP   : in unsigned ((LP_TOP-1) downto 0);
		mzinho_TOP : in unsigned ((LP_TOP-1) downto 0);
		R_TOP 	  : out unsigned ((LP_TOP*2-1) downto 0)
	);

end entity;

architecture rtl of Mult_top is

component Mult_PC is
	generic
	(
		LP_PC : natural := 3
	);

	port(
		clk_PC		: in std_logic;
		rst_PC	 	: in std_logic;
		outm_PC	 	: in std_logic;
		startBit_PC	: in std_logic;
		count_PC		: in unsigned (5 downto 0);
		init_PC	 	: out	std_logic;
		enR_PC	 	: out	std_logic
	);
end component;


component Mult_PO is
	generic
	(
		LP_PO: natural:= 3
	);

	port 
	(
		clk_PO	  : in std_logic;
		init_PO	  : in std_logic;
		enR_PO	  : in std_logic;
		Mzao_PO    : in unsigned ((LP_PO-1) downto 0);
		mzinho_PO  : in unsigned ((LP_PO-1) downto 0);
		outm_PO    : out std_logic;
		startBit_PO: out std_logic;
		count_PO   : out unsigned (5 downto 0);
		R_PO       : out unsigned ((LP_PO*2-1) downto 0)
	);

end component;

signal count_conn: unsigned (5 downto 0);
signal init_conn, enR_conn, outm_conn, startBit_conn: std_logic;



begin


PO_BSN: Mult_PO generic map (LP_PO => LP_TOP)
				port map (clk_PO => clk_TOP, 
					       init_PO => init_conn, 
							 enR_PO => enR_conn, 
							 Mzao_PO  => Mzao_TOP, 
							 mzinho_PO  => mzinho_TOP, 
							 outm_PO  => outm_conn, 
							 startBit_PO  => startBit_conn,  
							 count_PO => count_conn,  
							 R_PO  => R_TOP);


PC_BSN: Mult_PC generic map (LP_PC => LP_TOP)
				 port map (clk_PC => clk_TOP, 
				          rst_PC => rst_TOP, 
							 outm_PC => outm_conn, 
							 startBit_PC => startBit_conn, 
							 count_PC  => count_conn, 
							 init_PC => init_conn, 
							 enR_PC => enR_conn);
				
end rtl;

	



















