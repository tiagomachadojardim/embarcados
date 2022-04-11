library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Mult_PC is


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

end entity;


architecture rtl of Mult_PC is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3);

	-- Register to hold the current state
	signal state: state_type;	
	constant limit: unsigned(5 downto 0):= (0|1=> '1', others => '0');
	
begin

	-- Logic to advance to the next state
	process (clk_PC)
	begin
		if(rising_edge(clk_PC)) then
			if rst_PC = '1' then
				state <= S0;
			else
				case state is
					when S0=>
							if (startBit_PC = '1') then
								state <= S1;
							else
								state <= S2;
							end if;
				
					when S1=>
							if (count_PC = limit) then
								state <= S3;
							else
								if (outm_PC = '1') then
									state <= S1;
								else
									state <= S2;
								end if;
							end if;
							
					when S2=>
							if (count_PC = limit) then
								state <= S3;
							else
								if (outm_PC = '1') then
									state <= S1;
								else
									state <= S2;
								end if;
							end if;
					when S3 =>
							state <= S3;
				end case;
			end if;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				init_PC <= '1';
				enR_PC <= '0';
			when s1 =>
				init_PC <= '0';
				enR_PC <= '1';
			when s2 =>
				init_PC <= '0';
				enR_PC <= '0';
			when s3 =>
				init_PC <= '0';
				enR_PC <= '0';
		end case;
	end process;

end rtl;