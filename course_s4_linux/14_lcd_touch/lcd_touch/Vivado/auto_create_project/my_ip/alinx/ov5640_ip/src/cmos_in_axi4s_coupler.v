`timescale 1ps/1ps
module cmos_in_axi4s_coupler  (
  // System signals
  input  wire VID_IN_CLK,                 // Native video clock
  input  wire VID_RESET,                  // Native video reset
  input  wire VID_CE,                     // Native video clock enable

  input  wire ACLK,                       // AXI4-Stream clock
  input  wire ACLKEN,                     // AXI4-Stream clock enable
  input  wire ARESETN,                    // AXI4-Stream reset, active low

  // FIFO write signals
  input  wire [FIFO_WIDTH - 1:0] FIFO_WR_DATA, // FIFO write data
  input  wire FIFO_WR_EN,                 // FIFO write enable

  // FIFO read signals
  output wire [FIFO_WIDTH - 1:0] FIFO_RD_DATA, // FIFO read data
  output wire FIFO_VALID,                 // FIFO valid
  input  wire FIFO_READY,                 // FIFO ready

  // FIFO status signals
  output wire FIFO_OVERFLOW,              // AXI4-Stream FIFO overflow
  output wire FIFO_UNDERFLOW              // Native video FIFO underflow
);
localparam FIFO_WIDTH	 = 19;
wire empty;
assign FIFO_VALID = FIFO_READY & ~empty;
cmos_in_buf cmos_in_buf_inst
(
	.rst(VID_RESET | ~ARESETN),
	.wr_clk(VID_IN_CLK),
	.rd_clk(ACLK),
	.din(FIFO_WR_DATA),
	.wr_en(FIFO_WR_EN),
	.rd_en(FIFO_READY),
	.dout(FIFO_RD_DATA),
	.full(),
	.overflow(FIFO_OVERFLOW),
	.empty(empty),
	.underflow(FIFO_UNDERFLOW)
 );
endmodule


