module shift(
	input  rst, clk,
	output reg[3:0] out
);
	reg tmp;
	always @(posedge clk) begin
		if(!rst) out <= 4'b0000;
		else begin
			tmp = out[3];
			out = out << 1;
			out[0] = tmp;
		end
	end
endmodule