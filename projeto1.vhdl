library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;

entity projeto1 is
	generic(
		address_size_in_bits : natural := 64;
		word_size_in_bits : natural := 32;
		delay_in_clocks : positive := 1
		);
	
	port(
		ck, enable, write_enable : in bit;
		addr : in bit_vector(address_size_in_bits - 1 downto 0);
		data : inout std_logic_vector(word_size_in_bits - 1 downto 0);
		bsy : out bit
		);

end projeto1;


architecture ram_arch of projeto1 is
	-- Tipo do vetor com tamanho
	type mem_tipo is array (0 to 2**address_size_in_bits - 1) of std_logic_vector(word_size_in_bits-1 downto 0);
	-- Vetor de palavras
	signal mem: mem_tipo;
	signal cont: integer := 0;
begin

	process(addr, write_enable, enable, data, ck, cont) is
	
	begin
		if (ck = '1' and ck'event) then
			if(enable = '0') then
				data <= (others => 'Z');
				bsy <= '0';
			else
				bsy <= '1';
				if(cont = delay_in_clocks) then

					if(write_enable = '1') then
						mem(to_integer(unsigned(addr))) <= data;
					else
						data <= mem(to_integer(unsigned(addr)));
					end if;
					bsy <= '0';
					cont <= 0;
				else
					cont <= cont + 1;
				end if;								
			end if;
		end if;
		
	end process;
	
	
	
end architecture ram_arch;
		
		
		
		
		
		
		
		
		
		
		
		
