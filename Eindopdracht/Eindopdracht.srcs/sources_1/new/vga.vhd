library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA is
    Port (    aResetP : in STD_LOGIC;
              Pixel_clk : in STD_LOGIC;
              red, green, blue : out  STD_LOGIC_VECTOR(3 downto 0);
              R,G,B : in STD_LOGIC_VECTOR(3 downto 0);
              hsync, vsync : out  STD_LOGIC;
              Hcnt, Vcnt : out integer);
    
			  
end VGA;

architecture Behavioral of VGA is 
-- declare all constants for 1920 x 1080 timing
  constant H_pixels: integer := 1920;			--horizontal display width in pixels
  constant H_frontporch: integer := 88;			--horizontal front porch width in pixels
  constant H_syncwidth: integer := 44; 			--horizontal sync pulse width in pixels
  constant H_backporch: integer := 148;			--horizontal back porch width in pixels
  constant H_total_pixels: integer := (H_pixels + H_frontporch + H_syncwidth + H_backporch);
  constant H_sync_polarity: STD_LOGIC := '1';	--horizontal sync pulse polarity (1 = positive, 0 = negative)
  constant V_pixels: integer := 1080;			--vertical display width in rows
  constant V_frontporch: integer := 4;			--vertical front porch width in rows
  constant V_syncwidth: integer := 5;			--vertical sync pulse width in rows
  constant V_backporch: integer := 36;			--vertical back porch width in rows
  constant V_total_pixels: integer := (V_pixels + V_frontporch + V_syncwidth + V_backporch);
  constant V_sync_polarity: STD_LOGIC := '1';	--vertical sync pulse polarity (1 = positive, 0 = negative)
  signal hcount :	  INTEGER RANGE 0 TO H_total_pixels - 1 := 0;  --horizontal counter (counts the columns)
    signal vcount :   INTEGER RANGE 0 TO V_total_pixels - 1 := 0;  --vertical counter (counts the rows)


begin
  
process (Pixel_clk) 
  begin
  if (aResetP = '1') then
    hcount <= 0;
    vcount <= 0;
    red <= "0000";
    green <= "0000";
    blue <= "0000";
    vsync <= (not V_sync_polarity);
    hsync <= (not H_sync_polarity);
  elsif rising_edge(Pixel_clk) then
	   -- display time
	   if (hcount >= 0) and (hcount < H_pixels) and (vcount >= 0) and (vcount < V_pixels) then	
        red <= R;
        green <= G;
        blue <= B;
      -- blanking time
	  else 
        red <= "0000";
        green <= "0000";
        blue <= "0000";
      end if;
	  -- Horizontal sync pulse signal
      if ((hcount >= (H_pixels + H_frontporch)) and (hcount < (H_pixels + H_frontporch + H_syncwidth))) then
        hsync <= H_sync_polarity;
      else
        hsync <= (not H_sync_polarity);
      end if;
	  -- vertical sync pulse signal
      if ((vcount >= (V_pixels + V_frontporch)) and (vcount < (V_pixels + V_frontporch + V_syncwidth))) then
        vsync <= V_sync_polarity;
      else
        vsync <= (not V_sync_polarity);
      end if;
	  -- horizontal pixel counter
      hcount <= hcount + 1;
	 
      if hcount = (H_total_pixels - 1) then
	  -- vertical line counter
        vcount <= vcount + 1;
        hcount <= 0;
      end if;
	 
      if vcount = (V_total_pixels -1) then		    
        vcount <= 0;
      end if;
	 end if;
	 Hcnt <= hcount;
     Vcnt <= vcount;
	 
end process;
 
    
end Behavioral;
