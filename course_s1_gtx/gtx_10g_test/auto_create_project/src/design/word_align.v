module word_align(
	input rst,
	input rx_clk,
	input[31:0] gt_rx_data,
	input[3:0] gt_rx_ctrl,
	output reg[31:0] rx_data_align,
	output reg[3:0] rx_ctrl_align
);
reg[31:0] gt_rx_data_d0;
reg[31:0] gt_rx_data_d1;
reg[3:0] align_bit;
reg[3:0] gt_rx_ctrl_d0;
reg[3:0] gt_rx_ctrl_d1;

//ila_0 u0(
//    .clk	(rx_clk),
//    .probe0	(rx_data_align),
//    .probe1	(rx_ctrl_align),
//    .probe2	(gt_rx_data_d0),
//    .probe3	(gt_rx_ctrl),
//    .probe4	(gt_rx_data),
//    .probe5	(gt_rx_ctrl_d0),
//    .probe6	(align_bit)
//);   


always@(posedge rx_clk)
begin
	if(gt_rx_ctrl != 4'b0000)
		align_bit <= gt_rx_ctrl;
end

always@(posedge rx_clk)
begin
	gt_rx_data_d0 <= gt_rx_data;
	gt_rx_data_d1 <= gt_rx_data_d0;
	gt_rx_ctrl_d0 <= gt_rx_ctrl;
	gt_rx_ctrl_d1 <= gt_rx_ctrl_d0;
end

always@(posedge rx_clk)
begin
	case(align_bit)
		4'b0001:
			rx_data_align <= gt_rx_data_d0;
		4'b0100:
			rx_data_align <= {gt_rx_data_d0[15:0],gt_rx_data_d1[31:16]};
		default:
			rx_data_align <= 32'd0;
	endcase
end

always@(posedge rx_clk)
begin
	case(align_bit)
		4'b0001:
			rx_ctrl_align <= gt_rx_ctrl_d0;
		4'b0100:
			rx_ctrl_align <= {gt_rx_ctrl_d0[1:0],gt_rx_ctrl_d1[3:2]};
		default:
			rx_ctrl_align <= 4'd0;
	endcase
end

endmodule