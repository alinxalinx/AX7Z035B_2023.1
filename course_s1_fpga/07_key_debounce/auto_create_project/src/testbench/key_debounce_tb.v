`timescale 1ns/1ns
module key_debounce_tb;
reg sys_clk_p;
wire sys_clk_n;
reg rst_n;
reg key;
wire[3:0] led;


initial
begin
	sys_clk_p = 1'b0;
	rst_n = 1'b0;
	key = 1'b1;
	#100 rst_n = 1'b1;
	#2000 key = 1'b0;
	#({$random} %1000)
	key = ~key;
	#({$random} %1000)
	key = ~key;
	#({$random} %1000)
	key = ~key;
	#({$random} %1000)
	key = ~key;	
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;	
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = 1'b0;
	#1000000000
	key = 1'b1;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = 1'b1;
	
	#1000000000 key = 1'b0;
	#({$random} %1000)
	key = ~key;
	#({$random} %1000)
	key = ~key;
	#({$random} %1000)
	key = ~key;
	#({$random} %1000)
	key = ~key;	
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;	
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = 1'b0;
	#1000000000
	key = 1'b1;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = ~key;
	#({$random} %10000000)
	key = 1'b1;
	#10 $stop;
	
end
always #2.5 sys_clk_p = ~ sys_clk_p;   //5ns一个周期，产生200MHz时钟源

assign sys_clk_n = ~ sys_clk_p;

key_debounce dut
(
	.sys_clk_p	 (sys_clk_p), 		
	.sys_clk_n	 (sys_clk_n), 
	.rst_n       (rst_n),
	.key         (key),
	.led         (led)

);
endmodule 