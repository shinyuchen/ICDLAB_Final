`timescale 1ns / 1ps
module FullConnect_tb();
parameter input_size = 5;
parameter output_size = 3;
reg signed  [8*input_size-1:0]   data;
reg signed  [8*input_size*output_size-1:0] weight;
reg signed  [8*output_size-1:0]   bias;
wire signed [8*2*output_size-1:0]   result;

integer idx;
FullConnect# (8,input_size,output_size) u_fullConnect (data,weight,bias,result);
initial begin
    #5
    data = {8'd59,-8'd94,8'd48,-8'd50,-8'd62};
    weight = {-8'd119,8'd54,-8'd14,-8'd44,-8'd55,
              8'd19,8'd85,-8'd63,-8'd23,-8'd95,
              8'd6,-8'd68,8'd51,-8'd96,8'd23};
    bias = {8'd121,-8'd36,8'd90};
    #1
    $display("\nresult = data x weight + bias is:\n");
    for (idx = output_size-1; idx >= 0; idx = idx-1)
    begin
        $write("%d ", $signed(result[idx*16 +: 16]));
        // if (idx%3 == 2) $write("\n");
    end
    $write("\n");
    #10
    $finish;
end
endmodule