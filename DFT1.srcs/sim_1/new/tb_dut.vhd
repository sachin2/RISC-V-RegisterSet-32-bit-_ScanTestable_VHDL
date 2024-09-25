library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_e is
end tb_e;

architecture tb_a of tb_e is
  
    -- Instantiate the DFT_e entity
    COMPONENT DFT_e
     port ( a_i    : IN STD_LOGIC;   
            b_i    : IN STD_LOGIC;
            c_o    : OUT STD_LOGIC;
            TDI_i  : IN STD_LOGIC;
            TDO_o  : OUT STD_LOGIC;
            TMS_i  : IN STD_LOGIC;   
            TRST_i : IN STD_LOGIC;
            TCK_i  : IN STD_LOGIC );
    end COMPONENT;
    
    -- Signal declarations
    signal a_i_tb : STD_LOGIC := '0';
    signal b_i_tb : STD_LOGIC := '0';
    signal c_o_tb : STD_LOGIC;
    signal TMS_i_tb : STD_LOGIC;
    signal TCK_i_tb : STD_LOGIC;
    signal TDI_i_tb : STD_LOGIC;
    signal TRST_i_tb : STD_LOGIC := '0';

begin
  -- Instantiate the DFT_e entity
    dut: DFT_e port map( a_i => a_i_tb,
                        b_i => b_i_tb,
                        c_o => c_o_tb,
                        TMS_i  => TMS_i_tb,
                        TRST_i => TRST_i_tb,
                        TCK_i  => TCK_i_tb,
                        TDI_i  => TDI_i_tb );                 
                                                   
    clock: process
    begin
        TCK_i_tb <= '0';
        wait for 5 ns;
        TCK_i_tb <= '1';
        wait for 5 ns;
    end process; 
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: a_i = 0, b_i = 0
        a_i_tb <= '0';
        b_i_tb <= '0';
        wait for 20 ns;
        
        -- Test case 2: a_i = 0, b_i = 1
        a_i_tb <= '0';
        b_i_tb <= '1';
        wait for 20 ns;
        
        -- Test case 3: a_i = 1, b_i = 0
        a_i_tb <= '1';
        b_i_tb <= '0';
        wait for 20 ns;
        
        -- Test case 4: a_i = 1, b_i = 1
        a_i_tb <= '1';
        b_i_tb <= '1';
        wait for 20 ns;
        
        -- End simulation
        a_i_tb <= '0';
        b_i_tb <= '0';
        wait for 20 ns;
               
        --RTI 
        TRST_i_tb <= '0'; 
        TDI_i_tb <= '0';
        wait for 20ns;
        
        --instr 11 ScanTest
        TMS_i_tb <= '1'; --SelectDRScan
        wait for 10ns; 
        
        TMS_i_tb <= '1'; --selectirscan
        wait for 10ns;
        
        TMS_i_tb <= '0'; --captureir
        wait for 10ns;
        
        TDI_i_tb <= '1';
        TMS_i_tb <= '0'; --shiftir
        wait for 10ns;
      
        TDI_i_tb <= '1';
        TMS_i_tb <= '0'; --shiftir
        wait for 10ns; 
        
        TDI_i_tb <= '1';             
        TMS_i_tb <= '1'; --exit1ir
        wait for 10ns;
        
        TDI_i_tb <= '0'; 
        TMS_i_tb <= '1'; --updateir
        wait for 10ns;
        
        TMS_i_tb <= '1'; --SelectDRScan
        wait for 10ns;
        
        TMS_i_tb <= '0'; --capturedr
        wait for 10ns;
              
        TDI_i_tb <= '1';  
        TMS_i_tb <= '0'; --shiftdr
        wait for 10ns;
                      
        TDI_i_tb <= '1';  
        TMS_i_tb <= '0'; --shiftdr
        wait for 10ns;
                      
        TDI_i_tb <= '1';  
        TMS_i_tb <= '0'; --shiftdr
        wait for 10ns;
        
        TDI_i_tb <= '0';  
        TMS_i_tb <= '1'; --exit1dr
        wait for 10ns;
         
        TMS_i_tb <= '1'; --updatedr
        wait for 10ns;
        
        TMS_i_tb <= '0'; --RTI
        wait for 50ns;
    end process; 
end tb_a;
