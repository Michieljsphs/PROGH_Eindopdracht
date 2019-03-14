library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_top is
        Port (  aResetP : in STD_LOGIC;
                clk_100 : in STD_LOGIC;
                red, green, blue : out  STD_LOGIC_VECTOR(3 downto 0);
                hsync, vsync : out  STD_LOGIC;
                Backcolor: in std_logic_vector(2 downto 0));
end VGA_top;

architecture Behavioral of VGA_top is
    
component VGA is
    Port (   aResetP : in STD_LOGIC;
             Pixel_clk : in STD_LOGIC;
             red, green, blue : out  STD_LOGIC_VECTOR(3 downto 0);
             R,G,B : in STD_LOGIC_VECTOR(3 downto 0);
             hsync, vsync : out  STD_LOGIC;
             Hcnt, Vcnt : out integer);
end component;

component clk_148 is
    Port (  clk100: in STD_LOGIC;
            reset: in STD_LOGIC;
            clk148: out STD_LOGIC);
end component;

component Sprite is
    Port ( aResetP : in STD_LOGIC;
           hcnt : in integer;
           vcnt : in integer;
           clk148 : in  STD_LOGIC;
           R,G,B: out STD_LOGIC_VECTOR(3 downto 0);
           Backcolor: in STD_LOGIC_VECTOR(2 downto 0);
           addra : out STD_LOGIC_VECTOR(13 DOWNTO 0);
           dina : in STD_LOGIC_VECTOR(11 DOWNTO 0));
end component;

component blk_mem_gen_0 IS
    Port (    clka : IN STD_LOGIC;
            rsta : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            rsta_busy : OUT STD_LOGIC);
END component;

signal clk148: STD_LOGIC;
signal hcount,vcount: integer; 
signal R,G,B: STD_LOGIC_VECTOR(3 downto 0);
signal colorData: STD_LOGIC_VECTOR(11 downto 0);
signal addr: STD_LOGIC_VECTOR(13 DOWNTO 0);
begin

VIDEO: vga port map(
    aResetP => aResetP, 
    Pixel_clk => clk148,
    red => red, 
    green => green, 
    blue => blue, 
    R => R, 
    G => G,
    B => B, 
    hsync => hsync, 
    vsync => vsync, 
    Hcnt => hcount, 
    Vcnt => vcount
);

Clock: clk_148 port map(
    clk100 => clk_100,
    reset => aResetP, 
    clk148 => clk148
);
Sprt: sprite port map(
    aResetP => aResetP, 
    hCnt => hcount, 
    vCnt => vcount, 
    clk148 => clk148, 
    R => R, 
    G => G, 
    B => B, 
    Backcolor => Backcolor,
    addra => addr,
    dina => colorData
);

ROM: blk_mem_gen_0 port map(clka => clk148, 
    rsta => aResetP, 
    addra => addr, 
    douta => colorData, 
    rsta_busy => open
); 

end Behavioral;
