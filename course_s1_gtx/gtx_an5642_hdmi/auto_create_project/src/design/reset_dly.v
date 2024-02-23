
module reset_dly(
input           clk,
input           rst_n,
output reg      rst_n_dly
    );
reg[31:0] dly_cnt;
always@(posedge clk or negedge rst_n)
begin
if(~rst_n)
    begin
    rst_n_dly<=1'b0;
    dly_cnt<=32'd0;
    end
else
    begin
    if(dly_cnt>32'hffffff)
     rst_n_dly<=1'b1;
    else dly_cnt<=dly_cnt+1'b1;
    end
end    
endmodule

