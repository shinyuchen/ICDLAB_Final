`include "../layers/ReLU/relu.v"
`include "../layers/MaxPooling/MaxPool.v"
`include "../layers/MaxPooling/Max.v"
module ALU #(parameter BITWIDTH = 32, parameter MP_BITWIDTH = 8) 
(data1_i, data2_i, ALUCtrl_i, data_o, Zero_o);
// Is it reasonable to make data1_i = weight, data2_i = input, data_o = output? 
// Need an additional data3_i = bias?
input [31:0] data1_i, data2_i;
input [3:0] ALUCtrl_i;
output reg[31:0] data_o;
output reg Zero_o;
wire [   BITWIDTH-1: 0] data_Relu_o;
wire [MP_BITWIDTH-1: 0] data_MAX_pool_o;

parameter SUM       = 4'b0001;
parameter SUB       = 4'b0010;
parameter AND       = 4'b0011;
parameter OR        = 4'b0100;
parameter XOR       = 4'b0101;
parameter MUL       = 4'b0110;
parameter RELU      = 4'b0111;
parameter MaxPool   = 4'b1000;

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
  default : begin
    data_o = data1_i;
  end

endcase

end

endmodule
