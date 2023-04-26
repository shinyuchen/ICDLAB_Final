module Max#(
    parameter BITWIDTH = 8,
    parameter LENGTH   = 4
)(
    input [BITWIDTH * LENGTH - 1: 0]    i_data,
    output reg signed [BITWIDTH-1 : 0]   o_max
);
wire signed [BITWIDTH-1:0] dataArray [0:LENGTH - 1];
genvar i;
generate
   for(i = 0; i < LENGTH; i = i+1) begin
        assign dataArray[i] = i_data[(i+1)*BITWIDTH -1 -:BITWIDTH];
   end 
endgenerate
integer j;
always @(*) begin
    o_max = dataArray[0];
    for(j=1;j<LENGTH;j=j+1) begin
        if(dataArray[j] > o_max)
            o_max = dataArray[j];
    end
end
endmodule