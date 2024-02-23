`timescale 1ns / 1ps 
module led(
//Differential system clock
    input sys_clk_p,
    input sys_clk_n,
    input rst_n,
    (* MARK_DEBUG="true" *)output reg [3:0] led
    );
(* MARK_DEBUG="true" *)reg[31:0] timer_cnt;
wire sys_clk ;

   IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(sys_clk),  // Buffer output
      .I(sys_clk_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(sys_clk_n) // Diff_n buffer input (connect directly to top-level port)
   );

always@(posedge sys_clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        led <= 4'd0 ;
        timer_cnt <= 32'd0 ;
    end
    else if(timer_cnt >= 32'd199_999_999)   //1 second counter, 200M-1=199999999
    begin
        led <= ~led;
        timer_cnt <= 32'd0;
    end
    else
    begin
        led <= led;
        timer_cnt <= timer_cnt + 32'd1;
    end
    
end

//Instantiate ila in source file
//ila ila_inst(
//  .clk(sys_clk),
//  .probe0(timer_cnt),
//  .probe1(led)
//  );

endmodule