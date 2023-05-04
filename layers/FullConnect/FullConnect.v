// `timescale 1ns / 1ps
// `include "../layers/FullConnect/Mult.v"
module FullConnect#(
    parameter BITWIDTH = 8, 
    parameter INPUT_SIZE = 7, 
    parameter OUTPUT_SIZE = 5
    )
    (
    input [BITWIDTH * INPUT_SIZE - 1 : 0] data,
    input [BITWIDTH * INPUT_SIZE * OUTPUT_SIZE - 1 : 0] weight,
    input [BITWIDTH * OUTPUT_SIZE - 1 : 0] bias,
    output [BITWIDTH * 2 * OUTPUT_SIZE - 1 : 0] result
    );
    
    wire [BITWIDTH * 2 - 1:0] out [0:OUTPUT_SIZE - 1][0:INPUT_SIZE - 1];
    wire signed [BITWIDTH - 1:0] biasArray[0:OUTPUT_SIZE - 1];
    reg signed [BITWIDTH * 2 - 1:0] resultArray [0:OUTPUT_SIZE - 1];
    
    
    genvar i, j;
    generate
        for(i = 0; i < OUTPUT_SIZE; i = i + 1) begin
            assign biasArray[i] = bias[(i + 1) * BITWIDTH - 1 -:BITWIDTH];
            assign result[(i + 1) * BITWIDTH * 2 - 1 -: BITWIDTH * 2] = resultArray[i];
        end
    endgenerate
    
    generate 
        for(i = 0; i < OUTPUT_SIZE; i = i + 1) begin
            for(j = 0; j < INPUT_SIZE; j = j + 1) begin
                Mult#(BITWIDTH) mult(data[(j + 1) * BITWIDTH - 1 -:BITWIDTH], weight[(i * INPUT_SIZE + j) * BITWIDTH + BITWIDTH - 1 -: BITWIDTH], out[i][j]);
            end
        end
    endgenerate
    
    integer sum, m, n;
    always @(*) begin
        for(m = 0; m < OUTPUT_SIZE; m = m + 1) begin
            sum = 0;
            for(n = 0; n < INPUT_SIZE; n = n + 1) begin
                sum = sum + out[m][n];
            end
            sum = sum + biasArray[m];
            resultArray[m] = sum;
        end
    end

endmodule