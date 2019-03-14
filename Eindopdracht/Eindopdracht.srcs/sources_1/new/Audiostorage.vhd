library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;
entity AudioStorage is
    Port ( Clock : in STD_LOGIC;
           Address : in INTEGER;
           Track : IN INTEGER;
           Factor : out INTEGER);
end AudioStorage;

architecture Behavioral of AudioStorage is
Constant C : INTEGER := 1047;
Constant D : INTEGER := 1175;
Constant E : INTEGER := 1319;
Constant F : INTEGER := 1397;
Constant G : INTEGER := 1568;
Constant A : INTEGER := 1760;
Constant B : INTEGER := 1976;
Constant X : INTEGER := 1;
--TYPE Octave IS ARRAY (0 to 6) OF INTEGER;
--	CONSTANT Octave6 : Octave := (C, D, E, F, G, A, B);
--	CONSTANT Octave5 : Octave := (C/2, D/2, E/2, F/2, G/2, A/2, B/2); 
--	CONSTANT Octave4 : Octave := (C/4, D/4, E/4, F/4, G/4, A/4, B/4); 
TYPE Song IS ARRAY(0 to 15) of INTEGER;
    --Constant Song1 : Song := (12800, 6400, 3200, 1600, 800, 400, 200);
    Constant CrazyTrain : Song := (A/2, A/2, E, A/2, F, A/2, E, A/2, D, C, B/2, C, D, C, B/2, G/2);
    Constant Doremi : Song := (A/4, B/4 ,C/2, D/2, E/2, F/2, G/2, A/2, B/2, C, D, E, F, G, A, B);
    Constant FunkyTown : Song := (C, C, B/2, C, X, G/2, X, G/2, C, G, F, C, X, X, X, X);
    SIGNAL Index : INTEGER := 0;
    --SIGNAL Note : INTEGER := 0;
begin
proces : process(clock)
    begin
        if rising_edge(clock) THEN
            Index <= Address;
            if Track = 0 THEN
                Factor <= 100000000 / FunkyTown(Index);     
            elsif Track = 1 THEN
                Factor <= 100000000 / CrazyTrain(Index);     
            ELSE
                Factor <= 100000000 / Doremi(Index);     -- Testfrequencies
            END IF;
        END IF;
    end process;
end Behavioral;
