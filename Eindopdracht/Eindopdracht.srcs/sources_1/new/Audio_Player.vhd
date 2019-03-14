LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY Audio_player IS
	PORT (
		JB1 : OUT STD_LOGIC;
		clk : IN STD_LOGIC
	);
END Audio_player;
 
ARCHITECTURE Behavioral OF Audio_player IS

	COMPONENT ClockConverter IS
		PORT (
			Factor : IN INTEGER;
			clk100MHz : IN STD_LOGIC;
			reset : in std_logic;
			clkout : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT PlayMusic IS
		PORT (
			clk : IN STD_LOGIC;
			clkSpeed : IN STD_LOGIC;
		--	clkVar : in STD_LOGIC;
			Factor : out INTEGER;
		--	Address : out INTEGER;
			Output : out std_logic
		);
	END COMPONENT;

	SIGNAL S_clkout : std_logic := '0'; 
	SIGNAL S_clk_speed  : std_logic := '1';
	SIGNAL count : INTEGER RANGE 0 TO 10 := 0;
    SIGNAL S_factor: INTEGER;
    signal S_reset : std_logic;
	SIGNAL FactorSpeed : INTEGER RANGE 0 TO 100000000 := 5000000 / 2; -- 20000000 = goed ____ 1000000 is testcode 10ms
BEGIN
	
	Play : PlayMusic
	PORT MAP(
		clk => clk, 
		clkSpeed => S_clk_speed, 
		output => JB1,
		Factor => S_factor
	);
	
	SpeedConverter : ClockConverter
	PORT MAP(
		Factor => FactorSpeed, 
		clk100MHz => clk, 
		reset => S_reset,
		clkout => S_clk_speed
	);
 

    
END Behavioral;