// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Wed May 31 11:04:06 2017
// Host        : LUO running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               Y:/project/AX/AX7010/vivado_project_B/ov5640_ip/alinx_ov5640.srcs/sources_1/ip/cmos_in_buf/cmos_in_buf_stub.v
// Design      : cmos_in_buf
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_0_1,Vivado 2015.4" *)
module cmos_in_buf(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, overflow, empty, underflow)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[26:0],wr_en,rd_en,dout[26:0],full,overflow,empty,underflow" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [26:0]din;
  input wr_en;
  input rd_en;
  output [26:0]dout;
  output full;
  output overflow;
  output empty;
  output underflow;
endmodule
