module packet_rec(
	input rst,
	input rx_clk,
	input[31:0] gt_rx_data,
	input[3:0] gt_rx_ctrl,
	output[31:0] packet_cnt_o,
	output[31:0] error_packet_cnt_o
);
localparam IDLE         = 0;
localparam WAIT_HEADER  = 1;
localparam SEQ_NUM = 3;
localparam CTRL    = 4;
localparam DATA    = 5;
localparam CHECK   = 6;
reg[2:0] state;
reg[31:0] sequence_number;
reg[31:0] last_sequence_number;
reg[15:0] packet_len;
reg[7:0] packet_type;
reg[31:0] check_sum;
reg[15:0] data_cnt;
reg[31:0] packet_cnt;
reg[31:0] error_packet_cnt;
assign packet_cnt_o = packet_cnt;
assign error_packet_cnt_o = error_packet_cnt;
always@(posedge rx_clk or posedge rst)
begin
	if(rst)
	begin
		packet_cnt <= 32'd0;
		error_packet_cnt <= 32'd0;
	end
	else if(state == CHECK)
	begin
		packet_cnt <= packet_cnt + 1;
		if(check_sum != gt_rx_data || sequence_number != (last_sequence_number + 1))
			error_packet_cnt <= error_packet_cnt + 1;
	end
end
always@(posedge rx_clk or posedge rst)
begin
	if(rst)
	begin
		state <= IDLE;
		sequence_number <= 32'hffff_ffff;
		last_sequence_number <= 32'd0;
		data_cnt <= 16'd0;
		check_sum <= 32'd0;
		packet_type <= 8'd0;
		packet_len <= 16'd0;
	end
	else
		case(state)
			IDLE:
			begin
				state <= WAIT_HEADER;
			end
			WAIT_HEADER:
			begin
				check_sum <= 32'd0;
				if(gt_rx_ctrl[0] == 1'b1 && gt_rx_data[7:0] == 8'hbc)
					state <= SEQ_NUM;
			end
			SEQ_NUM:
			begin
				last_sequence_number <= sequence_number;
				sequence_number <= gt_rx_data;
				state <= CTRL;
			end
			CTRL:
			begin
				packet_len <= gt_rx_data[31:16];
				packet_type <= gt_rx_data[7:0];
				state <= DATA;
				data_cnt <= 16'd1;
			end
			DATA:
			begin
				if(data_cnt == packet_len)
				begin
					state <= CHECK;
				end
				else if(gt_rx_ctrl[0] == 1'b1)
				begin
					state <= WAIT_HEADER;
				end
				data_cnt <= data_cnt + 1;
				check_sum <= check_sum + gt_rx_data;
			end
			CHECK:
			begin
				state <= WAIT_HEADER;
			end
			default:
				state <= IDLE;
		endcase
end
endmodule 