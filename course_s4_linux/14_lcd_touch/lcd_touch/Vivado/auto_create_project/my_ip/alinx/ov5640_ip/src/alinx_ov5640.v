`timescale 1ns / 1ps
module alinx_ov5640#(
  // Video Format
	parameter PIXELS_FORMAT = "RGB565"
)
(
	input                                        cmos_xclk,
	inout                                        cmos_scl,         //cmos i2c clock
	inout                                        cmos_sda,         //cmos i2c data
	input                                        cmos_vsync,       //cmos vsync
	input                                        cmos_href,        //cmos hsync refrence
	input                                        cmos_pclk,        //cmos pxiel clock
	input   [9:0]                                cmos_d,           //cmos data
	output                                       cmos_reset,       //cmos reset

	// AXI4-Stream signals
	input                                        aclk,                  // AXI4-Stream clock
	input                                        aclken,                // AXI4-Stream clock enable
	input                                        aresetn,               // AXI4-Stream reset, active low 
	output [15:0]                                m_axis_video_tdata,    // AXI4-Stream data
	output                                       m_axis_video_tvalid,   // AXI4-Stream valid 
	input                                        m_axis_video_tready,   // AXI4-Stream ready 
	output                                       m_axis_video_tuser,    // AXI4-Stream tuser (SOF)
	output                                       m_axis_video_tlast,    // AXI4-Stream tlast (EOL)
	output[1:0]                                  m_axis_video_tkeep,    // AXI4-Stream tkeep
	output                                       fid,                   // Field-id output
  
	// Video timing detector locked
	input                                        axis_enable                 // AXI4-Stream locked

    );
localparam AXIS_TDATA_WIDTH	 = 16;
//CMOS OV5640上电延迟部分
wire initial_en;                       //OV5640 register configure enable
assign m_axis_video_tkeep = 2'b11;
power_on_delay	power_on_delay_inst(
	.clk_50M                 (cmos_xclk),
	.reset_n                 (1'b1),	
	.camera1_rstn            (cmos_reset),
	.camera2_rstn            (),	
	.camera_pwnd             (),
	.initial_en              (initial_en)		
);
 
//-------------------------------------
//CMOS1 Camera 
wire Cmos1_Config_Done;
reg_config	reg_config_inst1(
	.clk_25M                 (cmos_xclk),
	.camera_rstn             (cmos_reset),
	.initial_en              (initial_en),		
	.i2c_sclk                (cmos_scl),
	.i2c_sdat                (cmos_sda),
	.reg_conf_done           (Cmos1_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);


wire[15:0] cmos_d_16bit;
wire cmos_href_16bit;
reg[7:0] cmos_d_d0;
reg cmos_href_d0;
reg cmos_vsync_d0;
wire cmos_hblank;

always@(posedge cmos_pclk)
begin
    cmos_d_d0 <= cmos_d[9:2];
    cmos_href_d0 <= cmos_href;
    cmos_vsync_d0 <= cmos_vsync;
end



cmos_8_16bit cmos_8_16bit_m0(
	.rst(1'b0),
	.pclk(cmos_pclk),
	.pdata_i(cmos_d_d0),
	.de_i(cmos_href_d0),
	
	.pdata_o(cmos_d_16bit),
	.hblank(cmos_hblank),
	.de_o(cmos_href_16bit)
);


wire vid_io_in_active_video;
wire vid_io_in_clk;
wire[15:0] vid_io_in_data;
wire vid_io_in_hsync;
wire vid_io_in_vsync;
assign vid_io_in_clk = cmos_pclk;
assign vid_io_in_active_video = cmos_href_16bit;
assign vid_io_in_data = {cmos_d_16bit[7:0],cmos_d_16bit[15:8]};
assign vid_io_in_hsync = cmos_href_d0;
assign vid_io_in_vsync = cmos_vsync_d0;


wire[15:0] m_axis_video_tdata;
wire m_axis_video_tvalid;
wire m_axis_video_tready;
wire m_axis_video_tuser;
wire m_axis_video_tlast;



cmos_in_axi4s cmos_in_axi4s_m0
  (
  // Native video signals
  .vid_io_in_clk           (vid_io_in_clk              ), // Native video clock
  .vid_io_in_ce            (1'b1                       ), // Native video clock enable
  .vid_io_in_reset         (1'b0                       ), // Native video reset active high
  .vid_active_video        (vid_io_in_active_video     ), // Native video data enable
  .vid_vblank              (1'b0                       ), // Native video vertical blank
  .vid_hblank              (cmos_hblank               ), // Native video horizontal blank
  .vid_vsync               (vid_io_in_vsync            ), // Native video vertical sync
  .vid_hsync               (vid_io_in_hsync            ), // Native video horizontal sync
  .vid_field_id            (1'b0                       ), // Native video field-id
  .vid_data                (vid_io_in_data             ), // Native video data 
  

  // AXI4-Stream signals
  .aclk                    (aclk                 ), // AXI4-Stream clock
  .aclken                  (aclken               ), // AXI4-Stream clock enable
  .aresetn                 (aresetn              ), // AXI4-Stream reset active low 
  .m_axis_video_tdata      (m_axis_video_tdata   ), // AXI4-Stream data
  .m_axis_video_tvalid     (m_axis_video_tvalid  ), // AXI4-Stream valid 
  .m_axis_video_tready     (m_axis_video_tready  ), // AXI4-Stream ready 
  .m_axis_video_tuser      (m_axis_video_tuser   ), // AXI4-Stream tuser (SOF)
  .m_axis_video_tlast      (m_axis_video_tlast   ), // AXI4-Stream tlast (EOL)
  .fid                     (                     ), // Field-id output


  // Video timing detector locked
	.axis_enable(axis_enable)
);
endmodule
