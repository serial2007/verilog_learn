module nnand2(
	input a,b,
	output y);
	
	supply0 Gnd;
	supply1 Vdd;
	wire im1;
	pmos g1(y, Vdd, a);
	pmos g2(y, Vdd, b);
	nmos g3(y, im1, a);
	nmos g4(im1, Gnd, b);
endmodule