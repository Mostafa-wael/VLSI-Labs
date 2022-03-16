library IEEE;    
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std_unsigned.all;
ENTITY Ripple_adder_test IS
END Ripple_adder_test;

ARCHITECTURE testbench_a OF Ripple_adder_test IS
SIGNAL testa,  testb,testSum : std_logic_vector(15 downto 0);
SIGNAL testcout, testcin,testClk,testrst,testen : std_logic;
constant clk_period : time := 100 ps;
BEGIN

--
PROCESS
BEGIN
    testClk <= '0';
    wait for clk_period/2;
    testClk <= '1';
    wait for clk_period/2;
END PROCESS;

PROCESS
BEGIN
--testrst <= '1';
--testen <= '0';
--WAIT FOR clk_period;
testa <= x"1111";
testb <= x"0001";
testcin <= '0';
testrst <= '1';
testen <= '0';
WAIT FOR clk_period;
ASSERT(testSum = x"0000") REPORT "out is not correct for reset" SEVERITY ERROR;
testrst <= '0';
testen <= '1';

for i in 0 to 16 loop
	testa <= testa - x"0001";	
	WAIT FOR clk_period;
	if ( i > 0 ) then 
	ASSERT(testSum = (testa + testb)+ x"0001") REPORT "out is not correct" & INTEGER'IMAGE(i) SEVERITY ERROR;
	end if;
end loop;

WAIT;
END PROCESS;


-- Adder under Test
uut: entity work.myRippleAdder_withRegisters  PORT MAP (A => testa, B => testb, clk => testClk, rst => testrst, en => testen, 
cin => testcin, Sum => testSum, cout=>testcout);

END testbench_a;