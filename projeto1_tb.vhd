library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use IEEE.numeric_bit.all;


-- entidade do testbench
entity projeto1_tb is
end entity;

architecture tb of projeto1_tb is

  -- Componente a ser testado (Device Under Test -- DUT)
  component projeto1 is
  generic(
		address_size_in_bits : natural := 64;
		word_size_in_bits : natural := 32;
		delay_in_clocks : positive := 1
		);	
   port (
		ck, enable, write_enable : in bit;
		addr : in bit_vector(address_size_in_bits - 1 downto 0);
		data : inout std_logic_vector(word_size_in_bits - 1 downto 0);
		bsy : out bit
	);
	end component;
  
  ---- Declaracao de sinais de entrada para conectar o componente
  signal ck_in:     bit := '0';
  signal enable_in:     bit := '0';
  signal write_enable_in: bit := '0';
  signal addr_in: bit_vector(63 downto 0);

  ---- Declaracao dos sinais de saida
  signal bsy_out: bit := '0';
  
  ---- Declaracao do sinal de data 
  signal data_io : std_logic_vector(31 downto 0);


  -- Configurações do clock
  signal keep_simulating: std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 1 ms;     -- frequencia 1 kHz
  
begin

	reg : 


  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado. 
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  ck_in <= (not ck_in) and keep_simulating after clockPeriod/2;
  
  ---- DUT para Simulacao
  dut: circuito_projeto_final
	   generic map(address_size_in_bits=>64, word_size_in_bits=>32, delay_in_clocks=>1)
       port map
       (
          ck => ck_in,
		  enable => enable_in,
		  write_enable => write_enable_in,
		  addr => addr_in,
		  bsy => bsy_out,
		  data => data_io
       );
 
  ---- Gera sinais de estimulo para a simulacao
  -- Cenario de Teste #1: acerta as 16 rodadas

  stimulus: process is
  begin

    -- inicio da simulacao
    assert false report "inicio da simulacao" severity note;
    keep_simulating <= '1';  -- inicia geracao do sinal de clock
	 
	  -- gera pulso de reset (1 periodo de clock)
    rst_in <= '1';
    wait for clockPeriod;
    rst_in <= '0';
	 
	 wait until falling_edge(clk_in);
    -- pulso do sinal de Iniciar
    nivel_in <= "01";
    wait until falling_edge(clk_in);
	 

    wait until falling_edge(clk_in);
    -- pulso do sinal de Iniciar
    escrita_in <= '1';
    wait until falling_edge(clk_in);
    escrita_in <= '0';
    wait for clockPeriod;
	 nivel_in <= "01";
	 
	 
	 wait for 5*clockPeriod;
	 -- cenario de teste 1 - acerto das 16 rodadas
	 
	 --escrita 1a jogada
	 chaves_in <="00001";
	 wait for 5*clockPeriod;
    chaves_in <= "00000";
	---- espera
    wait for 10*clockPeriod;
	 
	 
	 ---rodada#1
	 ---- jogada #1
    chaves_in <= "00001";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    -- espera entre jogadas
    wait for 10*clockPeriod;
	 ---- escrita jogada #2
    chaves_in <= "00010";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 10*clockPeriod;	 

	 ---rodada#2
	 ---- jogada #1
    chaves_in <= "00001";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    -- espera entre jogadas
    wait for 10*clockPeriod;
    ---- jogada #2
    chaves_in <= "00010";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 10*clockPeriod;
	 ---- escrita jogada #3
    chaves_in <= "00100";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 10*clockPeriod;
 
	 ---rodada#3
	 ---- jogada #1
    chaves_in <= "00001";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    -- espera entre jogadas
    wait for 10*clockPeriod;
    ---- jogada #2
    chaves_in <= "00010";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 10*clockPeriod;
    ---- jogada #3
    chaves_in <= "00100";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    -- espera entre jogadas
    wait for 10*clockPeriod; 
	 ---- escrita jogada #4
    chaves_in <= "01000";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 10*clockPeriod; 

		 ---rodada#4
	 ---- jogada #1
    chaves_in <= "00001";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    -- espera entre jogadas
    wait for 7000*clockPeriod;
    ---- jogada #2
    chaves_in <= "00010";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 7000*clockPeriod;
    ---- jogada #3
    chaves_in <= "00100";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    -- espera entre jogadas
    wait for 7000*clockPeriod; 
    ---- jogada #4
    chaves_in <= "01000";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera entre jogadas
    wait for 7000*clockPeriod;
	 ---- escrita jogada #5
    chaves_in <= "00001";
    wait for 5*clockPeriod;
    chaves_in <= "00000";
    ---- espera
    wait for 10*clockPeriod;
	 
	 
	 
	 
 
    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;


end architecture;