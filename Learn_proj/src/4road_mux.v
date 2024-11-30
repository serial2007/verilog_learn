// 采用结构性描述
module mux(
	output out,
	input[3:0] data,
	input[1:0] sel
);
wire w1,w2,w3,w4;
not		U1(w1, sel[1]),
		U2(w2, sel[0]);
and		U3(w3, w1, w2, data[0]),
		U4(w4, w1, sel[0], data[1]),
		U5(w5, sel[1], w2, data[2]),
		U6(w6, sel[1], sel[0], data[3]);
or		U7(out, w3, w4, w5, w6);
endmodule

module desingn(
	input a, b, c,
	output reg out
);
	wire[1:0] w;
	assign w=a+b+c;
	always@(w)
		if(w > 1)
			out <= 1;
		else out <= 0;
endmodule

module one_bit_fulladder(
	input  a, b, cin,
	output sum, cout
);
	// assign sum = a^b^cin;
	// assign cout = (a&b) | (a|b)&cin;
	assign {cout,sum} = a+b+cin;
endmodule

