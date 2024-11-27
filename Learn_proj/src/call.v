module logic(
    input  wire in1, in2,
    output wire q);
    and_2 U1(in1,in2,q);
endmodule 

module and_2(
    input  wire a,b,
    output wire c);
    assign c = a & b;
endmodule