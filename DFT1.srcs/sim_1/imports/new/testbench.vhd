library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_e is
end tb_e;

architecture tb_a of tb_e is
  
    -- Instantiate the tapc_e entity
    COMPONENT tapc_e
      port ( TDI_i    : IN STD_LOGIC;
             TDO_o    : OUT STD_LOGIC;
             TMS_i    : IN STD_LOGIC;   
             TRST_i   : IN STD_LOGIC;
             TCK_i    : IN STD_LOGIC;
             ScanEn_o  : OUT STD_LOGIC;
             ScanIn_o  : OUT STD_LOGIC;
             ScanOut_i  : IN STD_LOGIC );
    end COMPONENT;
    
    -- Instantiate the coreDesign entity
    COMPONENT coreDesign_e
     port ( a_i    : IN STD_LOGIC;   
            b_i    : IN STD_LOGIC;
            c_o    : OUT STD_LOGIC );
    end COMPONENT;
    
    -- Signal declarations
    signal a_i_tb : STD_LOGIC := '0';
    signal b_i_tb : STD_LOGIC := '0';
    signal c_o_tb : STD_LOGIC;
    signal TMS_i_tb : STD_LOGIC;
    signal TCK_i_tb : STD_LOGIC;
    signal TDI_i_tb : STD_LOGIC;
    signal TRST_i_tb : STD_LOGIC := '0';
    signal ScanEn_o_tb : STD_LOGIC;
    signal ScanIn_o_tb : STD_LOGIC;
    signal ScanOut_i_tb : STD_LOGIC;

begin
  -- Instantiate the tapc_e entity
    uut1: tapc_e port map( TMS_i  => TMS_i_tb,
                        TRST_i => TRST_i_tb,
                        TCK_i  => TCK_i_tb,
                        TDI_i  => TDI_i_tb,
                        ScanEn_o => ScanEn_o_tb,
                        ScanIn_o => ScanIn_o_tb,
                        ScanOut_i => ScanOut_i_tb );
                        
    uut2: coreDesign_e port map( a_i => a_i_tb,
                                b_i => b_i_tb,
                                c_o => c_o_tb ); 
                                                   
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
               
        --TLR 
        TRST_i_tb <= '0'; 
        TDI_i_tb <= '0';
        TMS_i_tb <= '1'; --TLR
        wait for 20ns;
        
        --RTI   
        TMS_i_tb <= '0'; --RTI
        wait for 20ns;
        
        --instr 0111 
        TMS_i_tb <= '1'; --SelectDRScan
        wait for 10ns; 
        
        TMS_i_tb <= '1'; --selectirscan
        wait for 10ns;
        
        TMS_i_tb <= '0'; --captureir
        wait for 10ns;
    
        TMS_i_tb <= '0'; --shiftir
        wait for 10ns;
        
        TDI_i_tb <= '1';
        TMS_i_tb <= '0'; --shiftir
        wait for 10ns;
      
        TDI_i_tb <= '1';
        TMS_i_tb <= '0'; --shiftir
        wait for 10ns; 
                     
        TMS_i_tb <= '1'; --exit1ir
        wait for 10ns;
        
        TMS_i_tb <= '1'; --updateir
        wait for 10ns;
        
        TDI_i_tb <= '0';
        TMS_i_tb <= '0'; --RTI
        wait for 50ns;
    end process; 
end tb_a;
