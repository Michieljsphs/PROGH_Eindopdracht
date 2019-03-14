----------------------------------------------------------------------------------
-- Company: Avans
-- Engineer: 
-- 
-- Create Date:    10:52:39 02/16/2016 
-- Design Name: 
-- Module Name:    Sprite - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sprite is
    Port (     aResetP : in STD_LOGIC;
               hCnt : in integer;
               vCnt : in integer;
               clk148 : in  STD_LOGIC;
               R,G,B: out STD_LOGIC_VECTOR(3 downto 0);
               Backcolor: in STD_LOGIC_VECTOR(2 downto 0);
               addra : out STD_LOGIC_VECTOR(13 DOWNTO 0);
               dina : in STD_LOGIC_VECTOR(11 DOWNTO 0));
               
end Sprite;

architecture Behavioral of Sprite is
-- declare all constants for 1920 x 1080 timing
  constant H_pixels: integer := 1920;
  constant H_frontporch: integer := 88;
  constant H_syncwidth: integer := 44;
  constant H_backporch: integer := 148;
  constant H_total_pixels: integer := 2200;
  constant H_sync_polarity: STD_LOGIC := '1';
  constant V_pixels: integer := 1080;
  constant V_frontporch: integer := 4;
  constant V_syncwidth: integer := 5;
  constant V_backporch: integer := 36;
  constant V_total_pixels: integer := 1125;
  constant V_sync_polarity: STD_LOGIC := '1';

-- declare all constants for sprite
  constant spriteHight: integer := 100;
  constant spriteWidth: integer := 100;
  constant romDelay: integer := 2;
  	 SIGNAL Hup: boolean;
  SIGNAL Vup: boolean;
  -- declare counters
  SIGNAL hSpriteLoc: integer;
  SIGNAL vSpriteLoc: integer;
  SIGNAL addrCnt: STD_LOGIC_VECTOR(13 downto 0);

begin
	 location: process(clk148)
     -- declare horizontal and vertical movement booleans

	 
	 begin
	 if (aResetP = '1') then
                 addrcnt <= (others => '0');
                 Hup <= false;
                 Vup <= false;
                 hSpriteLoc <= 0;
                 vSpriteLoc <= 0;
     elsif rising_edge(clk148) then
     
	   if (vCnt = V_pixels and hCnt = H_pixels) then -- when end of screen is reached
        
         addrcnt <= (others => '0'); -- reset adrescounter for rom
        
            -- move horizontal to the right
       		if (hSpriteLoc < (H_pixels - spriteWidth)  and Hup = true) then
				hSpriteLoc <= hSpriteLoc + 1;	
			else 
				Hup <= false;

			end if;
			
			-- move horizontal to the left
			if (hSpriteLoc > 0 and Hup = false) then
				hSpriteLoc <= hSpriteLoc - 1;	
			else 
				Hup <= true;

			end if;
			
			-- move down vertical
			if (vSpriteLoc < (V_pixels - spriteHight) and Vup = true) then
				vSpriteLoc <= vSpriteLoc + 1;	
			else 
				Vup <= false;
            
            -- move up vertical
			end if;
			
			if (vSpriteLoc > 0 and Vup = false) then
				vSpriteLoc <= vSpriteLoc - 1;	
			else 
				Vup <= true;

			end if;
					
		end if;

		
		
		-- correct for ROM delay, first read from ROM and then write to screen romDelay clockcycles later
		if (hCnt >= (hSpriteLoc)) and (hCnt < (hSpriteLoc + spriteWidth)) and (vCnt >= (vSpriteLoc)) and (vCnt < (vSpriteLoc + spriteHight)) then
			  addrcnt <= addrcnt + 1;
	    end if;
	    
	    -- write sprite or backcolor	  
		if (hCnt - romDelay >= (hSpriteLoc)) and (hCnt - romDelay < (hSpriteLoc + spriteWidth)) and (vCnt >= (vSpriteLoc)) and (vCnt < (vSpriteLoc + spriteHight)) then	  
			  R <= dina(11 downto 8);
			  G <= dina(7 downto 4);
			  B <= dina(3 downto 0);
			else
			  R <= Backcolor(2) & Backcolor(2) & Backcolor(2) & Backcolor(2);
			  G <= Backcolor(1) & Backcolor(1) & Backcolor(1) & Backcolor(1);
			  B <= Backcolor(0) & Backcolor(0) & Backcolor(0) & Backcolor(0);
			  
			end if;
		end if;
	    addra <= addrcnt;
	end process;

end Behavioral;
