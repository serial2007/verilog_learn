// 时钟信号的产生
module forever_tb(output reg clock);
    initial
    fork
        begin
        clock = 0;
        forever #50 clock=~clock;
        end
        #300 $finish;
    join
endmodule 

