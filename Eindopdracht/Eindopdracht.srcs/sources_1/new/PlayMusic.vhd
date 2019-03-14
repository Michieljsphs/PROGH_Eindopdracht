library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity PlayMusic is
    Port ( clk : in STD_LOGIC;
           clkSpeed : in STD_LOGIC;
           Factor : out INTEGER;
           output : out STD_LOGIC
           );
end PlayMusic;

architecture Behavioral of PlayMusic is

COMPONENT ClockConverter IS
		PORT (
			Factor : IN INTEGER;
			clk100MHz : IN STD_LOGIC;
			Reset : in std_logic;
			clkout : OUT STD_LOGIC
		);
	END COMPONENT;


COMPONENT AudioStorage
		PORT (
			Clock : IN STD_LOGIC;
			address : IN INTEGER;
			Track : IN INTEGER;
			Factor : OUT INTEGER
		);
	END COMPONENT;


SIGNAL clkSpeedOLD : std_logic := not clkspeed;
SIGNAL SubClockSpeed : INTEGER range 0 to 3 := 0;
SIGNAL clkVar : std_logic;
SIGNAL clkVarOLD : std_logic := not clkvar;
signal flag : std_logic := '1';
SIGNAL count : INTEGER := 0;
signal S_reset : std_logic := '0';
SIGNAL S_Address : INTEGER := 0;
SIGNAL S_Track : INTEGER := 1;
SIGNAL S_Factor : INTEGER RANGE 0 TO 100000000; -- := 50000;
SIGNAL S_FactorOut : INTEGER RANGE 0 TO 100000000; -- := 50000;
begin


        Audio : AudioStorage
        PORT MAP(
            Clock => clk, 
            Address => S_Address,
            Track => S_track, 
            Factor => S_Factor
        );
 
 	ConverterVar : ClockConverter
        PORT MAP(
            Factor => S_FactorOut, 
            clk100MHz => clk, 
            reset => S_reset,
            clkout => clkVar
        );

Walk_Through_Song : PROCESS (clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF (clkSpeed /= clkSpeedOLD) AND (clkSpeed = '1') THEN
			SubClockSpeed <= SubClockSpeed + 1;
			S_factorOut <= s_factorOut * 2;
                if (SubClockSpeed = 3) THEN
                    S_factorOut <= S_factor;
                    S_reset <= not S_reset;
                    SubClockSpeed <= 0;
                    count <= count + 1;
                END IF;
				
				IF (count = 15) THEN
					count <= 0;
				END IF;
			END IF;
            clkSpeedOLD <= clkSpeed;
		END IF;
	END PROCESS;
		
    S_Address <= count;
 
 GenerateTone : PROCESS (clk)
        BEGIN
            IF rising_edge(clk) THEN
                IF (clkvar /= clkvarold) AND (clkvar = '1') THEN
                     flag <= not flag;
                END IF;
                clkvarold <= clkvar;
            END IF;
        END PROCESS;
        
    
    Output <= flag;
        

end Behavioral;