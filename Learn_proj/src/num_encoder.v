module mux8to3_p(
	output reg[2:0]		dout,
	output		reg 	Ys, Yex,
	input[7:0]			din,
	input				sel // 低电平有效
);
	always @(din, sel) begin
		if(sel) {dout,Ys,Yex}={3'b111,1'b1,1'b1};
		else begin
			casex (din)
				8'b0xxxxxxx: {dout,Ys,Yex}={3'b000,1'b1,1'b0};
				8'b10xxxxxx: {dout,Ys,Yex}={3'b001,1'b1,1'b0};
				8'b110xxxxx: {dout,Ys,Yex}={3'b010,1'b1,1'b0};
				8'b1110xxxx: {dout,Ys,Yex}={3'b011,1'b1,1'b0};
				8'b11110xxx: {dout,Ys,Yex}={3'b100,1'b1,1'b0};
				8'b111110xx: {dout,Ys,Yex}={3'b101,1'b1,1'b0};
				8'b1111110x: {dout,Ys,Yex}={3'b110,1'b1,1'b0};
				8'b11111111: {dout,Ys,Yex}={3'b111,1'b0,1'b1};
			endcase
		end
	end
endmodule