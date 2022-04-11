LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY Mult_Testbench  IS 
  GENERIC (
    LP_TOP  : NATURAL   := 3 ); 
END ; 
 
ARCHITECTURE Mult_Testbench_arch OF Mult_Testbench IS
  SIGNAL R_TOP   :  UNSIGNED ((LP_TOP * 2 - 1) downto 0)  ; 
  SIGNAL clk_TOP   :  STD_LOGIC  ; 
  SIGNAL Mzao_TOP   :  UNSIGNED ((LP_TOP - 1) downto 0)  ; 
  SIGNAL mzinho_TOP   :  UNSIGNED ((LP_TOP - 1) downto 0)  ; 
  SIGNAL rst_TOP   :  STD_LOGIC  ; 
  COMPONENT Mult_top  
    GENERIC ( 
      LP_TOP  : NATURAL  );  
    PORT ( 
      R_TOP  : out UNSIGNED ((LP_TOP * 2 - 1) downto 0) ; 
      clk_TOP  : in STD_LOGIC ; 
      Mzao_TOP  : in UNSIGNED ((LP_TOP - 1) downto 0) ; 
      mzinho_TOP  : in UNSIGNED ((LP_TOP - 1) downto 0) ; 
      rst_TOP  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : Mult_top  
    GENERIC MAP ( 
      LP_TOP  => LP_TOP   )
    PORT MAP ( 
      R_TOP   => R_TOP  ,
      clk_TOP   => clk_TOP  ,
      Mzao_TOP   => Mzao_TOP  ,
      mzinho_TOP   => mzinho_TOP  ,
      rst_TOP   => rst_TOP   ) ; 



-- "Constant Pattern"
-- Start Time = 0 ps, End Time = 100 ns, Period = 0 ps
  Process
	Begin
	 Mzao_TOP  <= "101"  ;
	wait for 100 ps ;
-- dumped values till 100 ps
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ps, End Time = 100 ns, Period = 0 ps
  Process
	Begin
	 mzinho_TOP  <= "101"  ;
	wait for 100 ps ;
-- dumped values till 100 ps
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ps, End Time = 100 ns, Period = 10 ns
  Process
	Begin
	 clk_TOP  <= '0'  ;
	wait for 100 ps ;
-- dumped values till 100 ps
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ps, End Time = 100 ns, Period = 0 ps
  Process
	Begin
	 rst_TOP  <= '1'  ;
	wait for 100 ps ;
-- dumped values till 100 ps
	wait;
 End Process;
END;
