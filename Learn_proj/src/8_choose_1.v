module mux8lo1_2(
	output		dout,
	input[7:0]	din,
	input[2:0]	sel
);
	wire[3:0]	w1;
	wire[1:0]	w2;
	assign w1=sel[0] ? {din[7],din[5],din[3],din[1]} :
					   {din[6],din[4],din[2],din[0]};
	assign w2=sel[1] ? {w1[3],w1[1]} : {w1[2],w1[0]};
	assign dout = sel[2] ? w2[1] : w2[0];
endmodule