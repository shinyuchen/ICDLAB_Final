`include "../layers/ReLU/relu.v"
`include "../layers/MaxPooling/MaxPool.v"
`include "../layers/MaxPooling/Max.v"
`include "../layers/FullConnect/FullConnect.v"
`include "../layers/FullConnect/Mult.v"
`include "../layers/Conv2d/Conv2d.v"
`include "../layers/Conv2d/ConvKernel.v"
module ALU #(
    parameter BITWIDTH        = 32, 
    parameter MP_BITWIDTH     = 8, 
    parameter FC_INPUT_SIZE   = 4, 
    parameter FC_OUTPUT_SIZE  = 2,
    parameter CONV_DATA_SIZE  = 2,
    parameter CONV_FILTER_SIZE = 3,
    parameter CONV_OUTPUT_SIZE = 2,
    parameter WEIGHT_SIZE      = 4
)  (weight_matrix, data1_i, data2_i, ALUCtrl_i, data_o, Zero_o);
// Is it reasonable to make data1_i = bias, data2_i = input, data_o = output? 
// And We designate 4 additional registers (or reserved 4 registers as weight)
input [MP_BITWIDTH * WEIGHT_SIZE * WEIGHT_SIZE - 1 : 0] weight_matrix;
input [31:0] data1_i, data2_i;
input [3:0] ALUCtrl_i;
output reg[31:0] data_o;
output reg Zero_o;
wire [   BITWIDTH-1: 0] data_Relu_o;
wire [MP_BITWIDTH-1: 0] data_MAX_pool_o;
wire [MP_BITWIDTH * 2 * FC_OUTPUT_SIZE - 1 : 0] data_FC_o;
wire [MP_BITWIDTH * FC_INPUT_SIZE * FC_OUTPUT_SIZE - 1 : 0] data_FC_weight;
wire [MP_BITWIDTH * 2 * CONV_OUTPUT_SIZE * CONV_OUTPUT_SIZE - 1 : 0] data_conv_o;
wire [MP_BITWIDTH * CONV_FILTER_SIZE * CONV_FILTER_SIZE - 1 : 0] data_conv_filter;
// wire  signed [8*CONV_DATA_SIZE*CONV_DATA_SIZE*1-1:0]   data;
// wire  signed  [8*CONV_FILTER_SIZE*CONV_FILTER_SIZE*1-1:0] weight1;
// wire  signed  [8*1-1:0]   bias1;
parameter SUM       = 4'b0001;
parameter SUB       = 4'b0010;
parameter AND       = 4'b0011;
parameter OR        = 4'b0100;
parameter XOR       = 4'b0101;
parameter MUL       = 4'b0110;
parameter RELU      = 4'b0111;
parameter MaxPool   = 4'b1000;
parameter FC        = 4'b1001;
parameter Conv2d    = 4'b1010;
integer   i;
// assign data = {8'd1,8'd1,
//               8'd1,8'd1};
// assign weight1 = {8'd1,8'd1,8'd1,
//                   8'd1,8'd1,8'd1,
//                   8'd1,8'd1,8'd1};
// assign bias1 = {8'd1};
assign data_FC_weight   = weight_matrix[MP_BITWIDTH * WEIGHT_SIZE * WEIGHT_SIZE - 1 -: MP_BITWIDTH * FC_INPUT_SIZE * FC_OUTPUT_SIZE];
assign data_conv_filter = weight_matrix[MP_BITWIDTH * WEIGHT_SIZE * WEIGHT_SIZE - 1 -: MP_BITWIDTH * CONV_FILTER_SIZE * CONV_FILTER_SIZE];
Relu #(.BITWIDTH(BITWIDTH), .THRESHOLD(0)) ALU_Relu(
  .data   ($signed(data1_i[BITWIDTH-1:0])),
  .result (data_Relu_o)
);

Max_pool #(
  .BITWIDTH    (MP_BITWIDTH), 
  .DATAWIDTH   (2'd2), 
  .DATAHEIGHT  (2'd2), 
  .DATACHANNEL (1'd1), 
  .KWIDTH      (2'd2), 
  .KHEIGHT     (2'd2)
  )  ALU_MaxPool ( 
  .data   (data1_i),
  .result (data_MAX_pool_o)
);

FullConnect #(
  .BITWIDTH     (MP_BITWIDTH), 
  .INPUT_SIZE   (FC_INPUT_SIZE), 
  .OUTPUT_SIZE  (FC_OUTPUT_SIZE)
  ) ALU_FC  (
  .data   (data1_i), // rs1 = input
  .weight (data_FC_weight),
  .bias   (data2_i[31 -: MP_BITWIDTH * FC_OUTPUT_SIZE]), // rs2 = bias
  .result (data_FC_o)
);

Conv2d #(
  .BITWIDTH(MP_BITWIDTH),
  .DATAWIDTH(CONV_DATA_SIZE),
  .DATAHEIGH(CONV_DATA_SIZE),
  .DATACHANNEL(1),
  .FILTERHEIGHT(CONV_FILTER_SIZE),
  .FILTERWIDTH(CONV_FILTER_SIZE),
  .FILTERBATCH(1),
  .STRIDEHEIGHT(1),
  .STRIDEWIDTH(1),
  .PADDINGENABLE(1)
) ALU_Conv (
  .data(data1_i),
  .filterWeight(data_conv_filter),
  .filterBias(data2_i[31 -:MP_BITWIDTH]),
  .result(data_conv_o)
);
/* implement here */
always@(*)begin
Zero_o   = (data1_i - data2_i) ? 0 : 1;
case(ALUCtrl_i)
  
  SUM : begin
    data_o = data1_i + data2_i;
  end
  SUB : begin
    data_o = data1_i - data2_i;
  end
  AND : begin
    data_o = data1_i & data2_i;
  end
  OR : begin
    data_o = data1_i | data2_i;
  end
  XOR : begin
    data_o = data1_i ^ data2_i;
  end
  MUL : begin
    data_o = data1_i * data2_i;
  end
  RELU: begin
    data_o = data_Relu_o;
  end
  MaxPool: begin
    data_o = data_MAX_pool_o;
  end
  FC: begin
    data_o = data_FC_o;
    // $display("FC output data : %h", data_o);
  end
  Conv2d: begin
    //  $display("CONV data matrix: %h", data1_i);
    //  $display("CONV filter : %h", data_conv_filter);
    //  $display("bias : %h", data2_i[31 -:MP_BITWIDTH]);
    for(i = 0; i < 4; i = i+1) begin
      data_o[8*(i+1) -1 -:8] =  data_conv_o[16*(i+1) - 8-1-: 8]; 
    end
    // $display("CONV output data : %h", data_conv_o);
  end
  default : begin
    data_o = data1_i;
  end

endcase

end

endmodule
