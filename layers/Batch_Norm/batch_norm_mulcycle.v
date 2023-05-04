`timescale 1ns / 1ps

module BN2d#(
    parameter BITWIDTH = 32,
    parameter THRESSHOLD = 0,
    parameter HEIGHT = 1,
    parameter WIDTH = 5
    )
    (
    input clk,
    input rst,
    input signed [BITWIDTH - 1:0] data,
    input signed [BITWIDTH - 1:0] weight,
    input signed [BITWIDTH - 1:0] bias,
    output signed [BITWIDTH - 1:0] result,
    output finish_flag
    );

    parameter IDLE = 3'd0;
    parameter EXEC = 3'd1;
    parameter REST = 3'd2;
    parameter RECV = 3'd3;

    reg signed [BITWIDTH - 1:0] result_r, result_w;
    reg [3:0] count_r, count_w;
    reg [2:0] state_r, state_w;
    assign result = result_r;

    reg signed [BITWIDTH - 1:0] data_square_r [0 : HEIGHT-1] [0 : WIDTH-1];
    reg signed [BITWIDTH - 1:0] data_square_w [0 : HEIGHT-1] [0 : WIDTH-1];

    reg finish_flag_r, finish_flag_w;
    assign finish_flag = finish_flag_r;

    wire signed [31:0] pre_VAR, pre_MEAN;
    assign pre_VAR = 7716;
    assign pre_MEAN = -9017;

    always @(*) begin
        result_w = result_r;
        finish_flag_w = finish_flag_r;
        case (state_r)
            EXEC: begin
                result_w = ((data - pre_MEAN) * weight) / pre_VAR + bias;
                finish_flag_w = 1;
            end 
            IDLE: begin
                finish_flag_w = 0;
            end
            REST: begin
                finish_flag_w = 0;
            end
        endcase
    end

    always @(*) begin
        state_w = state_r;
        case (state_r)
            IDLE: state_w = EXEC; 
            EXEC: begin
                if(count_r < WIDTH) state_w = REST;
                else state_w = IDLE;
            end
            REST : state_w = EXEC;
            default: state_w = IDLE; 
        endcase
    end

    always @(*) begin
        count_w = count_r;
        if(state_r == EXEC) count_w = count_r + 1;
        else count_w = 0;
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state_r <= IDLE;
            count_r <= 0;
            result_r <= 0;
            finish_flag_r <= 0;
        end
        else begin
            state_r <= state_w;
            count_r <= count_w;
            result_r <= result_w;
            finish_flag_r <= finish_flag_w;
            if(state_r == EXEC) begin
                $display("   data %d", data_in);
                $display("   weight %d", weight);
                $display("   bias %d", bias);
                $display(" ==result %d", result_r);
            end
        end
    end
endmodule