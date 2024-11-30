module halfadder(a,b,s,c);
	input a, b;
	output c, s;
	parameter xor_delay=2, and_delay=3;
	assign #xor_delay s=a^b;
	assign #and_delay c=a&b;
endmodule

module fulladder(p,q,ci,co,sum);
	input p, q, ci;
	output co, sum;
	parameter or_delay=1;
	wire w1,w2,w3;
	halfadder U1(p,q,w1,w2);
	halfadder U2(ci,w1,sum,w3);
	or #or_delay U3(co,w2,w3);
endmodule

module top1(top1a, top1b, top1s, top1c);
	input top1a,top1b;
	output top1s,top1c;
	defparam U1.U1.xor_delay = 4,
	         U1.U1.and_delay = 5;
	halfadder U1(top1a, top1b, top1s, top1c);
endmodule