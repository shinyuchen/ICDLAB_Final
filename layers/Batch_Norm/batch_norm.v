`timescale 1ns / 1ps

module BN#(
    parameter BITWIDTH = 32,
    parameter SECTOR_WIDTH = 8,
    parameter HEIGHT = 1,
    parameter WIDTH = 5
    )
    (
    // input signed [BITWIDTH - 1:0] data_1,
    // input signed [BITWIDTH - 1:0] data_2,
    // output signed [BITWIDTH - 1:0] result
    input signed [BITWIDTH - 1:0] data_1,
    input signed [BITWIDTH - 1:0] data_2,
    output signed [BITWIDTH - 1:0] result
    );

    wire [SECTOR_WIDTH-1 : 0] pre_VAR, pre_MEAN, cal_data, cal_weight, cal_bias;
    reg signed [BITWIDTH - 1:0] result_r;
    assign pre_VAR = data_2[15:8];
    assign pre_MEAN = data_2[7:0];
    assign cal_bias = data_1[23:16];
    assign cal_weight = data_1[15:8];
    assign cal_data = data_1[7:0];
    
    assign result = result_r;
    always @(*) begin
        
        result_r = ((cal_data - pre_MEAN) * cal_weight) / pre_VAR + cal_bias;
        // $display("data1  %d", data_1);
        // $display("data2  %d", data_2);
        // $display("var  %d", pre_VAR);
        // $display("mean %d", pre_MEAN);
        // $display("bias %d", cal_bias);
        // $display("weig %d", cal_weight);
        // $display("data %d", cal_data);
        // $display("result %d", result_r);
    end

endmodule