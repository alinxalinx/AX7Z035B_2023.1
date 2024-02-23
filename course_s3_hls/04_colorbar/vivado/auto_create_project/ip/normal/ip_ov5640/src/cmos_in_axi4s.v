`timescale 1ps/1ps
module cmos_in_axi4s
  (
  // Native video signals
  input  wire vid_io_in_clk,              // Native video clock
  input  wire vid_io_in_ce,               // Native video clock enable
  input  wire vid_io_in_reset,            // Native video reset, active high
  input  wire vid_active_video,           // Native video data enable
  input  wire vid_vblank,                 // Native video vertical blank
  input  wire vid_hblank,                 // Native video horizontal blank
  input  wire vid_vsync,                  // Native video vertical sync
  input  wire vid_hsync,                  // Native video horizontal sync
  input  wire vid_field_id,               // Native video field-id
  input  wire [15:0] vid_data, // Native video data 

  // AXI4-Stream signals
  input  wire aclk,                       // AXI4-Stream clock
  input  wire aclken,                     // AXI4-Stream clock enable
  input  wire aresetn,                    // AXI4-Stream reset, active low 
  output wire [15:0] m_axis_video_tdata, // AXI4-Stream data
  output wire m_axis_video_tvalid,        // AXI4-Stream valid 
  input  wire m_axis_video_tready,        // AXI4-Stream ready 
  output wire m_axis_video_tuser,         // AXI4-Stream tuser (SOF)
  output wire m_axis_video_tlast,         // AXI4-Stream tlast (EOL)
  output wire fid,                        // Field-id output

  // Video timing detector signals
  output wire vtd_active_video,           // VTD data enable
  output wire vtd_vblank,                 // VTD vertical blank
  output wire vtd_hblank,                 // VTD horizontal blank
  output wire vtd_vsync,                  // VTD vertical sync
  output wire vtd_hsync,                  // VTD horizontal sync
  output wire vtd_field_id,               // VTD field-id
  
  // FIFO status signals
  output wire overflow,                   // FIFO overflow status
  output wire underflow,                  // FIFO underflow status

  // Video timing detector locked
  input  wire axis_enable                 // AXI4-Stream locked
);

  // Register and Wire Declarations
  wire                              vid_clk = vid_io_in_clk;
  wire                              vid_reset = vid_io_in_reset;
  wire   [26:0] idf_data;
  wire          idf_de;  
  wire   [26:0] rd_data;

  // Assignments
  assign  m_axis_video_tdata  = rd_data[15:0];
  assign  m_axis_video_tlast  = rd_data[16];   
  assign  m_axis_video_tuser  = rd_data[17];
  assign  fid                 = rd_data[18];

  // Module instances
  cmos_in_axi4s_formatter FORMATTER_INST (
    .VID_IN_CLK       (vid_clk),
    .VID_RESET        (vid_reset),
    .VID_CE           (vid_io_in_ce),

    .VID_ACTIVE_VIDEO (vid_active_video),
    .VID_VBLANK       (vid_vblank),
    .VID_HBLANK       (vid_hblank),
    .VID_VSYNC        (vid_vsync),
    .VID_HSYNC        (vid_hsync),
    .VID_FIELD_ID     (vid_field_id),
    .VID_DATA         (vid_data),
    
    .VTD_ACTIVE_VIDEO (vtd_active_video),
    .VTD_VBLANK       (vtd_vblank),
    .VTD_HBLANK       (vtd_hblank),
    .VTD_VSYNC        (vtd_vsync),
    .VTD_HSYNC        (vtd_hsync),
    .VTD_FIELD_ID     (vtd_field_id),
    .VTD_LOCKED       (axis_enable),

    .FIFO_WR_DATA     (idf_data),
    .FIFO_WR_EN       (idf_de)
  );

  cmos_in_axi4s_coupler COUPLER_INST (
    .VID_IN_CLK     (vid_clk),
    .VID_RESET      (vid_reset),
    .VID_CE         (vid_io_in_ce),

    .ACLK           (aclk),
    .ACLKEN         (aclken),
    .ARESETN        (aresetn),

    .FIFO_WR_DATA   (idf_data),
    .FIFO_WR_EN     (idf_de),

    .FIFO_RD_DATA   (rd_data),
    .FIFO_VALID     (m_axis_video_tvalid),
    .FIFO_READY     (m_axis_video_tready),

    .FIFO_OVERFLOW  (overflow),
    .FIFO_UNDERFLOW (underflow)
  );
  
endmodule

`default_nettype wire

