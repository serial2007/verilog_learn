module pre_1_adder(
    input       ain, bin, cin,
    output      SO, Gi, Pi
);
    assign Gi = ain & bin;
    assign Pi = ain | bin;
    assign SO = ain ^ bin ^ cin;
endmodule

module CLA_x
#(parameter x = 4)
(
    input   [x-1:0]  P,
    input   [x-1:0]  G,
    output  [x:0]    c,
    output           Gm,
    output           Pm
);
    // Corrected the expression for c[x:1]
    assign c[x:1] = G[x-1:0] | (P[x-1:0] & c[x-1:0]);
    
    wire [x-1:0] t;
    genvar i;
    generate
        for (i = 0; i < x-1; i = i + 1) begin : gen_loop
            assign t[i] = &{G[i], P[x-1:i+1]};
        end
    endgenerate
    assign t[x-1] = G[x-1];
    assign Gm = |t;
    assign Pm = &P;
endmodule

module pre_x_adder
#(parameter x = 8)
(
    input       [x-1:0] a, b,
    input               cin,
    output      [x-1:0] s,
    output  wire        co
);
    wire [x-1:0] G, P; 
    wire [x:0] c;
    
    // Use always block to assign c[0] = cin
    assign c[0] = cin;

    // Generate pre_1_adder instances
    genvar i;
    generate
        for (i = 0; i < x; i = i + 1) begin : gen_pre_1_adder
            pre_1_adder U(
                .ain(a[i]),
                .bin(b[i]),
                .cin(c[i]),
                .SO(s[i]),
                .Gi(G[i]),
                .Pi(P[i])
            );
        end
    endgenerate

    // Instantiate CLA_x for carry propagation logic
    wire Pm, Gm;
    CLA_x #(.x(x)) uut (
        .P(P),
        .G(G),
        .c(c),
        .Gm(Gm),
        .Pm(Pm)
    );

    // Assign the final carry-out (co)
    assign co = c[x]; // Carry-out is the last carry bit
endmodule

module pre_x_adder_tb;
	parameter x = 8;
	wire [x-1:0] a, b;
	wire[x-1:0] s;
	wire vss;
	assign vss = 0;
	pre_x_adder #(.x(x)) U(
		.a 		(a),
		.b 		(b),
		.s 		(s),
		.cin 	(vss)
	);
	assign a=4'b1010;
	assign b=4'b0011;
	initial
	begin
		#10
		$finish;
	end
endmodule