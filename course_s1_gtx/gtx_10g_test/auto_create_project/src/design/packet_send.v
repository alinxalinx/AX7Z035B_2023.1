module packet_send(
	input rst,
	input tx_clk,
	input tx_packet_req,
	input[15:0] tx_packet_len,
	output tx_packet_done,
	input[7:0] tx_packet_type,
	input[31:0] tx_packet_data,
	output reg tx_packet_data_rd,
	
	output reg[31:0] gt_tx_data,
	output reg[3:0] gt_tx_ctrl
);
localparam IDLE         	= 0;
localparam SEND_IDLE    	= 1;
localparam SEND_CORRECTION  = 2;
localparam SEND_DUMMY  		= 3;
localparam SEND_HEADER  	= 4;
localparam SEND_SEQ_NUM 	= 5;
localparam SEND_CTRL    	= 6;
localparam SEND_DATA    	= 7;
localparam SEND_CHECK   	= 8;
localparam SEND_DATA_END	= 9;
reg[3:0] state;
reg[31:0] sequence_number;
reg[15:0] data_cnt;
reg[31:0] check_sum;
reg sys_rst_d1;
reg sys_rst_d2;
reg sys_rst_d3;
reg sys_rst;
assign tx_packet_done = (state == SEND_DATA_END);
always@(posedge tx_clk or posedge rst)
begin
	if(rst)
	begin
		state <= IDLE;
		gt_tx_data <= 32'd0;
		gt_tx_ctrl <= 4'd0;
		sequence_number <= 32'd0;
		data_cnt <= 16'd0;
		tx_packet_data_rd <= 1'b0;
		check_sum <= 32'd0;
	end
	else
		case(state)
			IDLE:
			begin
				if(tx_packet_req)
					state <= SEND_CORRECTION;
				else
					state <= IDLE;
			end
			SEND_CORRECTION:
			begin
				gt_tx_data <= 32'hf7_f7_f7_f7;
				gt_tx_ctrl <= 4'b1111;
				state <= SEND_DUMMY;
			end
			SEND_DUMMY:
			begin
				gt_tx_data <= 32'hff_00_00_55;
				gt_tx_ctrl <= 4'b0000;
				state <= SEND_HEADER;
			end
			SEND_HEADER:
			begin
				gt_tx_data <= 32'hff_00_00_bc;
				gt_tx_ctrl <= 4'b0001;
				state <= SEND_SEQ_NUM;
				check_sum <= 32'd0;
			end
			SEND_SEQ_NUM:
			begin
				gt_tx_data <= sequence_number;
				gt_tx_ctrl <= 4'b0000;
				state <= SEND_CTRL;
				data_cnt <= 16'd1;
				tx_packet_data_rd <= 1'b1;
			end
			SEND_CTRL:
			begin
				gt_tx_data <= {tx_packet_len,8'd0,tx_packet_type};
				gt_tx_ctrl <= 4'b0000;
				if(data_cnt == tx_packet_len)
				begin
					data_cnt <= 16'd0;
					tx_packet_data_rd <= 1'b0;
					state <= SEND_DATA_END;
				end
				else
				begin
					state <= SEND_DATA;
					data_cnt <= data_cnt + 1;
				end
			end
			SEND_DATA:
			begin
				gt_tx_data <= tx_packet_data;
				gt_tx_ctrl <= 4'b0000;
				check_sum <= check_sum + tx_packet_data;
				if(data_cnt == tx_packet_len)
				begin
					state <= SEND_DATA_END;
					tx_packet_data_rd <= 1'b0;
					data_cnt <= 0;
				end
				else
				begin
					data_cnt <= data_cnt + 1;
				end
			end
			SEND_DATA_END:
			begin
				gt_tx_data <= tx_packet_data;
				gt_tx_ctrl <= 4'b0000;
				check_sum <= check_sum + tx_packet_data;
				state <= SEND_CHECK;
				sequence_number <= sequence_number + 32'd1;
			end
			SEND_CHECK:
			begin
				gt_tx_data <= check_sum;
				gt_tx_ctrl <= 4'b0000;	
				state <= IDLE;
			end
			default:
				state <= IDLE;
		endcase
end
endmodule 