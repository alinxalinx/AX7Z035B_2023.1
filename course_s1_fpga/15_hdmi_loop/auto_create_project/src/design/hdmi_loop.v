`timescale 1ns/1ps
module hdmi_loop
(
//Differential system clock
    input  sys_clk_p,
    input  sys_clk_n,
	
	inout hdmi_scl,
	inout hdmi_sda,

    inout vin_scl,
    inout vin_sda,
	
	output hdmi_in_nreset,
	input vin_clk,
	input vin_hs,
	input vin_vs,
	input vin_de,
	input[23:0] vin_data,
	
	output vout_clk,
	output vout_hs,
	output vout_vs,
	output vout_de,
	output[23:0] vout_data
);

wire[9:0]    adv7511_lut_index;
wire[31:0]   adv7511_lut_data;
wire[9:0]    si9011_lut_index;
wire[31:0]   si9011_lut_data;
wire clk_100m;
wire rst_n;
wire locked;
reg vin_hs_d0;
reg vin_vs_d0;
reg vin_de_d0;
reg[23:0] vin_data_d0;
reg vin_hs_d1;
reg vin_vs_d1;
reg vin_de_d1;
reg[23:0] vin_data_d1;
reg vin_hs_d2;
reg vin_vs_d2;
reg vin_de_d2;
reg[23:0] vin_data_d2;
assign vout_clk = vin_clk;
assign vout_hs = vin_hs_d2;
assign vout_vs = vin_vs_d2;
assign vout_de = vin_de_d2;
assign vout_data = vin_data_d2;
assign rst_n = locked;
assign hdmi_in_nreset = locked;




sys_pll sys_pll_i
 (
	// Clock in ports
	.clk_in1_p(sys_clk_p),
	.clk_in1_n(sys_clk_n),
	// Clock out ports
	.clk_out1(),
	.clk_out2(clk_100m),
	// Status and control signals
	.reset(1'b0),
	.locked(locked)
 );
//I2C master controller
 i2c_config i2c_config_m0(
     .rst                        (~locked              ),
     .clk                        (clk_100m               ),
     .clk_div_cnt                (16'd499                  ),
     .i2c_addr_2byte             (1'b0                     ),
     .lut_index                  (si9011_lut_index                ),
     .lut_dev_addr               (si9011_lut_data[31:24]          ),
     .lut_reg_addr               (si9011_lut_data[23:8]           ),
     .lut_reg_data               (si9011_lut_data[7:0]            ),
     .error                      (                         ),
     .done                       (                         ),
     .i2c_scl                    (vin_scl                 ),
     .i2c_sda                    (vin_sda                 )
 );
 
i2c_config i2c_config_m1(
     .rst                        (~locked              ),
     .clk                        (clk_100m               ),
     .clk_div_cnt                (16'd499                  ),
     .i2c_addr_2byte             (1'b0                     ),
     .lut_index                  (adv7511_lut_index                ),
     .lut_dev_addr               (adv7511_lut_data[31:24]          ),
     .lut_reg_addr               (adv7511_lut_data[23:8]           ),
     .lut_reg_data               (adv7511_lut_data[7:0]            ),
     .error                      (                         ),
     .done                       (                         ),
     .i2c_scl                    (hdmi_scl                 ),
     .i2c_sda                    (hdmi_sda                 )
 );
 //configure look-up table
 lut_adv7511 lut_adv7511_m0(
     .lut_index                  (adv7511_lut_index                ),
     .lut_data                   (adv7511_lut_data                 )
 ); 

 //configure look-up table
 lut_si9011 lut_si9011_m0(
     .lut_index                  (si9011_lut_index                ),
     .lut_data                   (si9011_lut_data                 )
 ); 

always@(posedge vin_clk)
begin
    vin_hs_d0 <= vin_hs;
    vin_vs_d0 <= vin_vs;
    vin_de_d0 <= vin_de;
    vin_data_d0 <= vin_data;
    vin_hs_d1 <= vin_hs_d0;
    vin_vs_d1 <= vin_vs_d0;
    vin_de_d1 <= vin_de_d0;
    vin_data_d1 <= vin_data_d0; 
    
    vin_hs_d2 <= vin_hs_d1;
    vin_vs_d2 <= vin_vs_d1;
    vin_de_d2 <= vin_de_d1;
    vin_data_d2 <= vin_data_d1;   
end

endmodule 