`timescale 1ns / 1ps
module MaxPool_tb();
    parameter integer BITWIDTH = 8;
        
    parameter integer DATACHANNEL = 1;
    parameter integer DATAHEIGHT = 4;
    parameter integer DATAWIDTH = 4;
        
    parameter integer POOLSIZE = 2;
    reg [BITWIDTH * DATAWIDTH * DATAHEIGHT * DATACHANNEL - 1 : 0] i_data;
    wire signed [BITWIDTH * DATAWIDTH / POOLSIZE * DATAHEIGHT / POOLSIZE * DATACHANNEL - 1 : 0] o_max_pool;
    Max_pool#(8, 4, 4, 1, 2, 2) u_max_pool(i_data,o_max_pool);
    integer idx;
    initial begin
        #1 
        i_data = {8'd10, -8'd12, 8'd8, 8'd7,
                   8'd4, 8'd11, 8'd5, -8'd9,
                  -8'd18, 8'd13, -8'd7, -8'd7,
                   8'd3,  8'd15, 8'd2, 8'd2};
        $display("\nInput Matrix:\n");
        for(idx = 15; idx >=0 ;idx = idx - 1) begin
          $write("%d ", $signed(i_data[idx*8 +: 8]));
          if (idx%4 == 0) $write("\n");
        end
        #1
        $display("\nMax Pooling Result:\n");
        for (idx = 3; idx >= 0; idx = idx-1)
        begin
            $write("%d ", $signed(o_max_pool[idx*8 +: 8]));
            if (idx%2 == 0) $write("\n");
        end
        $write("\n");
        #10
        $finish;
    end
endmodule