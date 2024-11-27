module code_83(
    input  wire [7:0] din,
    output wire [2:0] dout);
    
    function[2:0] code;
        input[7:0] din;
        casex(din)
            8'b1xxx_xxxx: code = 3'h7;
            8'b01xx_xxxx: code = 3'h6;
            8'b001x_xxxx: code = 3'h5;
            8'b0001_xxxx: code = 3'h4;
            8'b0000_1xxx: code = 3'h3;
            8'b0000_01xx: code = 3'h2;
            8'b0000_001x: code = 3'h1;
            8'b0000_000x: code = 3'h0;
			default:      code = 3'hx;
		endcase
	endfunction

	assign dout = code(din);
endmodule

module func_t(
    input  wire        reset, clk,
    input  wire [3:0]  n,
    output reg  [31:0] result);
    always@(posedge clk) begin
        if(!reset) result <= 0;
        else begin
            result <= 2*factorial(n);
        end
    end
    
    function[31:0] factorial;
        input[3:0] opa; 
        reg [3:0] i;
        begin
            factorial = (opa>=4'b1)? 1:0;
            for(i=2; i<opa; i=i+1)
                factorial = i*factorial;
        end
    endfunction
endmodule