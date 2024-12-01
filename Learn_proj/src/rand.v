// clk：时钟信号，触发寄存器更新。
// load_n：负逻辑使能信号，用来控制是否将输入 D_load 加载到寄存器 Q。
// D_load：一个 4 位的输入数据，用来加载到寄存器 Q 中。

module signal15(
    output out,           // 输出序列的当前值
    input clk,            // 时钟信号
    input load_n,         // 负逻辑使能信号，用来控制是否将输入数据加载到寄存器
    input [3:0] D_load,   // 4 位输入数据，用来加载到寄存器
    output reg [3:0] Q    // 4 位寄存器 Q
);
    wire feedback;        // 反馈信号
    reg [3:0] shift_reg;  // 4 位移位寄存器

    always @(posedge clk) begin
        if (~load_n)       // 如果负使能信号有效，则加载 D_load 数据到寄存器
            shift_reg <= D_load;
        else
            shift_reg <= {shift_reg[2:0], feedback};  // 向左移位并将反馈信号作为最低位
    end

    // 反馈信号根据某些位的异或和反馈生成
    // 这里假设使用 Q[3] 和 Q[0] 的异或作为反馈信号
    assign feedback = shift_reg[3] ^ shift_reg[0];

    assign out = shift_reg[3]; // 输出最高位作为序列的当前位

    always @(posedge clk) begin
        Q <= shift_reg;  // 将移位寄存器的值赋给输出寄存器 Q
    end
endmodule

module signal15_tb(
	output out,
	output wire [3:0] Q
);
	reg clk, load_n;
	reg [3:0] D_load; 
	signal15 U1(
		.out 		(out),
		.clk 		(clk),
		.load_n 	(load_n),
		.D_load 	(D_load),
		.Q			(Q)
	);
	initial begin
		clk 	<= 0;
		load_n 	<= 0;
		D_load 	<= 4'b0001;
		#20
		load_n = 1;
		#1000		$finish;
	end
	always #10 clk = ~clk;
endmodule


// C runtime library random number generator
//
// uses 32 logic cells for DFF/ADD and 8 DSP blocks for the
// 32x18=>32 multiply
 
// module c_rand (clk,rst,reseed,seed_val,out);
// input clk,rst,reseed;
// input [31:0] seed_val;
// output [15:0] out;
// wire [15:0] out;
 
// reg [31:0] state;
 
// always @(posedge clk or posedge rst) begin
// 	if (rst) state <= 0;
// 	else begin
// 		if (reseed) state <= seed_val;
// 		else begin
// 			state <= state * 32'h343fd + 32'h269EC3;
// 		end
// 	end
// end
 
// assign out = (state >> 16) & 16'h7fff;
// endmodule
