`timescale 1ns / 1ps

module Mult#(
    parameter BITWIDTH = 8
    )
    (
    input signed [BITWIDTH-1:0] a,
    input signed [BITWIDTH-1:0] b,
    output signed [BITWIDTH * 2 - 1:0] c
    );
    
    assign c = a * b;
    
endmodule