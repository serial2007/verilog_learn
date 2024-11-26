module mux2_1(
    input wire a,b,sel,
    output reg out);

    always@(a,b,sel)
    begin
        if(sel)     out = a;
        else        out = b;
    end
endmodule

// case     是全等的比较
// casex    只比较0和1,对X,Z不比较认为1
// casez    只比较0和1,对X不比较