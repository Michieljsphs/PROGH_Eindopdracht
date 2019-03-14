LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.numeric_std.ALL;

entity ClockConverter is
    Port (
        Factor : in INTEGER;
        clk100MHz     : in STD_LOGIC;
        reset : in std_logic;
        clkout   : out STD_LOGIC
    );
end ClockConverter;

architecture Behavioral of ClockConverter is
SIGNAL count : INTEGER range 0 to 100000000 := 1;
SIGNAL state : std_logic := '1';
SIGNAL S_resetOLD : std_logic;
begin

Clock_Converter : PROCESS (clk100MHz)
	BEGIN
		IF (RISING_EDGE(clk100MHz)) THEN
			count <= count + 1;
			if (reset /= S_resetOLD) THEN
			     count <= 1;
			END IF;
			S_resetOLD <= reset;
			IF (count = Factor - 1) THEN
				state <= not state;
				count <= 1;
			END IF;
		END IF;
	END PROCESS;
clkout <= state;
end Behavioral;