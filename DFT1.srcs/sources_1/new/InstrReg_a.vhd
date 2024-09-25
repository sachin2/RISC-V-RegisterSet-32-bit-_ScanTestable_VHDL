
architecture instrreg_a of instrreg_e is
 signal instrreg1_s : std_logic_vector(1 DOWNTO 0);
 signal instr_s : std_logic_vector(1 DOWNTO 0);
 signal buff_s : std_logic_vector(2 DOWNTO 0);
 
begin
buff_s(0) <= TDI_i;
  gen_R1: for i in 0 to 1 generate
    CAPTURE: process(clock_ir_i, shift_ir_i)
    begin
      if rising_edge(clock_ir_i) then
        if shift_ir_i = '1' then
          instrreg1_s(i) <= buff_s(i);
        else
          instrreg1_s(i) <= '0';  
        end if;
      end if;
    end process; 
    buff_s(i+1) <= instrreg1_s(i);
    TDO_o <= buff_s(2);
     
    UPDATE: process(update_ir_i)
    begin
      if rising_edge(update_ir_i) then
        instr_s(i) <= instrreg1_s(i);
      end if;
    end process;  
  end generate gen_R1;
  
   IR_Decode: process(instr_s)
     begin 
        case instr_s is
        when "11" => -- SCAN
          ScanEn_o <= '1'; --ScanEnable
          drmux_o <= '1';
        when others => -- INVLD
          ScanEn_o <= '0';
          drmux_o <= '0';
       end case;
     end process;  
end instrreg_a;