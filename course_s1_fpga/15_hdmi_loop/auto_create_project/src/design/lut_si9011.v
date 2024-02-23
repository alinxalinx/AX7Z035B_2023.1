//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//  Author: meisq                                                               //
//          msq@qq.com                                                          //
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

//================================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------------
//  2017/12/28     meisq          1.0         Original
//*******************************************************************************/

module lut_si9011(
	input[9:0]             lut_index, // Look-up table index address
	output reg[31:0]       lut_data   // I2C device address register address register data
);

always@(*)
begin
	case(lut_index)
		//si9011 configuration table
		8'd0   :   lut_data	<= 	{8'h60,24'h000510};
		8'd1   :   lut_data	<= 	{8'h60,24'h000805};
		8'd2   :   lut_data	<= 	{8'h60,24'h000901};
		8'd3   :   lut_data	<= 	{8'h60,24'h000504};
		8'd4   :   lut_data	<= 	{8'h60,24'h00b504};
		default:lut_data <= {8'hff,16'hffff,8'hff};
	endcase
end


endmodule 