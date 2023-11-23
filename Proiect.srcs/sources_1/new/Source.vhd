    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.std_logic_unsigned.all;   
    
    entity TIMER0 is
            port ( 
            clk_in : 	in 	STD_LOGIC;
            clk_ex : 	in 	STD_LOGIC;
            set_clk : 	in 	STD_LOGIC;
            EN       : in  STD_LOGIC;
            RESET    : in  STD_LOGIC;
            DATA_init   :in STD_LOGIC_VECTOR(7 downto 0);
            TMRIF   :out STD_LOGIC;
            TMR0    : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end TIMER0;
    
    architecture behavior of TIMER0 is
        
        Signal out_div : STD_LOGIC;
        Signal s_bar : STD_LOGIC;
        Signal x_int : STD_LOGIC;
        Signal y_int : STD_LOGIC;
        Signal m : STD_LOGIC;
        signal a : std_logic_vector(7 downto 0);
        Signal overflow : STD_LOGIC;
    begin
        
        process(clk_in)
    		variable  n : integer range 0 to 1000000000;
        begin
            if clk_in'event and clk_in='1' then
                if n < 100000000 then
                    n := n+1;
                else
                    n := 0; 
                end if;
            
                if n <= 50000000 then
                    out_div <= '1';
                else
                    out_div <= '0';
                end if;
            end if;
        end process;
    
        
        s_bar <= not set_clk;
        x_int <= out_div and s_bar;
        y_int <= clk_ex and set_clk;
        m <= x_int or y_int;
    
        process(m, EN, RESET, DATA_init)
        begin
           
            if RESET = '1' then        
                a <= (others => '0');
                overflow <= '0';
                TMRIF <= '0';
            elsif EN = '1' then
                  a <= DATA_init;
            elsif (m'event and m = '1') then
                if a = "11111111" then
                    overflow <= '1';
                    TMRIF <= '1';
                    a <= (others => '0');
                else
                    if overflow = '0' then
                        a <=  a + 1;
                    end if;
                end if;             
            end if;                        
        end process; 
        
       
        TMR0 <= a;
    end behavior;
