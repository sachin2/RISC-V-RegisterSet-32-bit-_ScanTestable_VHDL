architecture coreDesign_a of coreDesign_e is

begin
    core: process(a_i, b_i)
    begin
        c_o <= a_i XOR b_i;
    end process;

end coreDesign_a;