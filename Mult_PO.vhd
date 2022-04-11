
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Mult_PO is

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

end entity;


		
architecture rtl of Mult_PO is

signal mzinho_reg: unsigned ((LP_PO-1) downto 0);
signal count_reg: unsigned (5 downto 0);
signal Mzao_reg, R: unsigned ((LP_PO*2-1) downto 0);

begin

	process(clk_PO)is
	begin
		if (rising_edge(clk_PO))then
			if (init_PO = '1') then
				Mzao_reg <= (5|4|3 => '0') & Mzao_PO;
				mzinho_reg <= mzinho_PO;
				count_reg <= (0=>'1', others=>'0');
				R <= (others=>'0');
			else
				Mzao_reg <= Mzao_reg sll 1;
				count_reg <= count_reg + 1; 
				if (enR_PO = '1') then
					R <= R + Mzao_reg;
				end if;
			end if;
		end if;
	end process;
	
	
	outm_PO <=  mzinho_reg(1) when count_reg = "000001" else
				   mzinho_reg(2);
	
	startBit_PO <= mzinho_reg(0);
	
	count_PO <= count_reg;
	
	R_PO <= R;
	
end rtl; 















