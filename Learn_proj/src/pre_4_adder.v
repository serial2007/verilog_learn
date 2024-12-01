module d_latch(d,clk,q);
    input d;
    input clk;
    output q;

    reg q;

    always @ (d,clk) // clk上升沿有效
        if(clk)
            q <= d;
endmodule
// TestBench
module d_latch_tb;
    reg clk,d;
    wire q;

    d_latch u1(.d(d),.clk(clk),.q(q));

    initial
    begin
        clk = 1;
        d <= 0;
        forever
        begin
            #60 d <= 1;//人为生成毛刺 
            #22 d <= 0;
            #2  d <= 1;
            #2  d <= 0;
            #16 d <= 0;//维持16ns的低电平，然后让它做周期性的循环
        end
    end
    always #20 clk <= ~clk;//半周期为20ns,全周期为40ns的一个信号
endmodule