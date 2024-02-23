//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//  Author: lhj                                                                 //
 //                                                                             //
//          ALINX(shanghai) Technology Co.,Ltd                                  //
//          heijin                                                              //
//     WEB: http://www.alinx.cn/                                                //
//     BBS: http://www.heijin.org/                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
//                    All rights reserved                                       //
//                                                                              //
// This source file may be used and distributed without restriction provided    //
// that this copyright statement is not removed from the file and that any      //
// derivative work contains the original copyright notice and the associated    //
// disclaimer.                                                                  //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

//===============================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//-------------------------------------------------------------------------------
//  2018/01/03    lhj        1.0         Original
//*******************************************************************************/
module key_debounce
(
input      	 sys_clk_p,            //system clock 200Mhz postive pin
input      	 sys_clk_n,            //system clock 200Mhz negetive pin 
input        rst_n,
input        key,
output [3:0] led
);

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

wire        button_negedge; //Key falling edge

ax_debounce ax_debounce_m0
(
    .clk             (sys_clk       ),
    .rst             (~rst_n        ),
    .button_in       (key           ),
    .button_posedge  (              ),
    .button_negedge  (button_negedge),
    .button_out      (              )
);

wire[3:0]   count;

counter count_m0
(
    .clk             (sys_clk       ),
    .rst_n           (rst_n         ),
    .en              (button_negedge),
    .clr             (1'b0          ),
    .data            (count         )
);
assign led = count;
endmodule 