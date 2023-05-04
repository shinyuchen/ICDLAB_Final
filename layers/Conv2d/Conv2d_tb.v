`timescale 1ns / 1ps
module Conv2d_tb();
parameter data_width = 2;
parameter data_height = 2;
parameter in_channel = 1;
parameter out_channel = 1;
parameter kernel_size = 3;
parameter output_size = 2;

reg signed  [8*data_width*data_height*in_channel-1:0]   data;
reg signed  [8*kernel_size*kernel_size*out_channel-1:0] weight1;
reg signed  [8*out_channel-1:0]   bias1;
wire signed [16*output_size*output_size*in_channel-1:0]   cov_result1;

Conv2d#(8, data_width, data_height, in_channel, kernel_size, kernel_size, out_channel, 1, 1, 1) conv2d_1(data, weight1, bias1, cov_result1);

integer idx;
initial begin
    #5
    // data = {8'd2,8'd0,8'd0,8'd0,8'd0,
    //         8'd3,8'd4,8'd6,8'd4,8'd6,
    //         8'd7,8'd8,8'd8,8'd8,8'd8,
    //         8'd3,8'd4,8'd6,8'd4,8'd6,
    //         8'd10,8'd16,8'd15,8'd24,8'd18};
    data = {8'd1,8'd1,
            8'd1,8'd1};
    weight1 = {8'd1,8'd1,8'd1,
               8'd1,8'd1,8'd1,
               8'd1,8'd1,8'd1};
    bias1 = {8'd1};
    // cov_result1 = {8'd10,8'd16,8'd15,8'd24,8'd18,
    //                8'd25,8'd39,8'd36,8'd45,8'd31,
    //                8'd37,8'd55,8'd47,8'd49,8'd31,
    //                8'd44,8'd65,8'd59,8'd57,8'd36,
    //                8'd29,8'd42,8'd38,8'd36,8'd23};
    #1
    $display("\nInput Matrix:\n");
    for (idx = data_width*data_height-1; idx >= 0; idx = idx-1)
    begin
        $write("%d ", $signed(data[idx*8 +: 8]));
        if (idx%data_width == 0) $write("\n");
    end
    $write("\n");
    #1
    $display("\nWeight Kernel:\n");
    for (idx = kernel_size*kernel_size-1; idx >= 0; idx = idx-1)
    begin
        $write("%d ", $signed(weight1[idx*8 +: 8]));
        if (idx%kernel_size == 0) $write("\n");
    end
    #1
    $display("\nBias:\n");
    for (idx = 1*1-1; idx >= 0; idx = idx-1)
    begin
        $write("%d ", $signed(bias1[idx*8 +: 8]));
        if (idx%1 == 0) $write("\n");
    end
    #1

    $display("\nConvolution Result:\n");
     for (idx = output_size*output_size-1; idx >= 0; idx = idx-1)
    begin
        $write("%d ", $signed(cov_result1[idx*16 +: 16]));
        if (idx%output_size == 0) $write("\n");
    end
    $write("\n");
    #10
    $finish;
end
endmodule