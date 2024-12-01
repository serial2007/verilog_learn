`timescale 1ns/1ns
module D(
    input d, clk, rst,
    output reg q);
    always @ (posedge clk,posedge rst)
    begin
        if(rst)//异步复位信号，跟时钟沿无关，只要复位是高电平就会复位
            q <=0;
        else
            q <= d;//上升沿有效的时候，把d捕获到q
    end    
endmodule
module counter(
	output reg[3:0]	count,
	input			clk, rst
);
	always @(posedge clk) begin
		if (rst) count <= 4'b0000;
		else if(count == 4'b1010)
			count <= 4'b0000;
		else count <= count + 1;
	end
endmodule
