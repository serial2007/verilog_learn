module shift_regist2(Q,D,rst,clk);
    output reg [7:0]    Q;
    input  wire         D, rst, clk;
    integer i;
    always@(posedge clk)
        begin
            for(i=7; i>0; i=i-1)
                Q[i] <= Q[i-1];
            Q[0] <= D;
        end      
    initial begin
        Q[7:0] <= 8'b01010101;
        #10 $finish;
    end
endmodule

module shift_regist1(Q,D,rst,clk);
    output reg [7:0]    Q;
    input  wire         D, rst, clk;
    always@(posedge clk)
        if(!rst)    Q <= 8'b00000000;
        else        Q <= {Q[6:0],D};
endmodule