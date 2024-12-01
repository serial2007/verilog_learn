`timescale 1ns/1ns

module counter(
    output reg [3:0] count,
    input            clk, rst
);
    always @(posedge clk) begin
        if (rst) 
            count <= 4'b0000;
        else if (count == 4'b1010)
            count <= 4'b0000;
        else 
            count <= count + 1;
    end
endmodule

module counter_tb();
    reg clk, rst;
    wire [3:0] count; // count 是 wire 类型，由 counter 模块驱动

    // 初始化信号
    initial begin
        clk = 0;       // 初始时钟信号为 0
        rst = 1;       // 初始化复位信号为 1
        #20 rst = 0;   // 20ns 后释放复位信号
    end

    // 时钟生成器
    always #15 clk = ~clk; // 每 15ns 翻转一次时钟

    // 实例化待测模块
    counter U1(
        .count(count), // 模块输出 count 驱动 wire 信号
        .clk(clk), 
        .rst(rst)
    );

    // 仿真监控
    initial begin
        $monitor("Time = %0dns, rst = %b, count = %b", $time, rst, count);
        #500 $finish; // 仿真持续 500ns
    end
endmodule
