module Registers #(
    parameter FC_BITWIDTH   = 8, 
    parameter WEIGHT_SIZE   = 4,
    parameter DATA_SIZE   = 4,
    parameter FILE_SIZE     = 16
)
(
    clk_i,
    reset,
    op_address,
    RSaddr_i,
    RTaddr_i,
    RDaddr_i, 
    RDdata_i,
    RegWrite_i,
    is_pos_i, 
    RSdata_o, 
    RTdata_o,
    reg_o,
    pos_o,
    data_matrix_o,
    weight_matrix_o
);
integer i;
// Ports
input               clk_i;
input               reset;
input   [4:0]       op_address;
input   [4:0]       RSaddr_i;
input   [4:0]       RTaddr_i;
input   [4:0]       RDaddr_i;
input   [31:0]      RDdata_i;
input               RegWrite_i;
input   [3:0]       is_pos_i;
output  [31:0]      RSdata_o; 
output  [31:0]      RTdata_o;
output  [31:0]      reg_o;
output  [3:0]       pos_o;
output  reg [FC_BITWIDTH * DATA_SIZE * DATA_SIZE - 1 : 0] data_matrix_o;
output  reg [FC_BITWIDTH * WEIGHT_SIZE * WEIGHT_SIZE - 1 : 0] weight_matrix_o;
// Register File
reg     [31:0]      register        [0:FILE_SIZE-1];
reg     [3:0]       pos             [0:FILE_SIZE-1];
// Read Data      
assign  RSdata_o        = register[RSaddr_i];
assign  RTdata_o        = register[RTaddr_i];
assign  reg_o           = register[op_address];
assign  pos_o           = pos[op_address];

always @(*) begin
    for(i = WEIGHT_SIZE-1; i >= 0; i = i - 1) begin
        weight_matrix_o[32*(i+1) -1-: 32] = register[FILE_SIZE-1-i];
    end
end
always @(*) begin
    for(i = 0; i < DATA_SIZE; i = i + 1) begin
        data_matrix_o[32*(i+1) -1-: 32] = register[5+i];
    end
end
// assign  weight_matrix_o = {register[25], register[26]};
// Write Data

always@(negedge clk_i or posedge reset)begin
    if(reset) begin
        // for(i=0;i<32;i=i+1)register[i] <= 0;
        // for(i=0;i<32;i=i+1)pos[i]      <= 0;

        // `ifdef MP
        //     register[2] <= 32'hff_ee_11_00;
        //     register[3] <= 32'h00_00_00_00;
        //     register[4] <= 32'h7f_ff_e3_11;
        //     for(i=0;i< 2;i=i+1)register[i] <= 0;
        //     for(i=5;i<FILE_SIZE;i=i+1)register[i] <= 0;
        //     for(i=0;i<FILE_SIZE;i=i+1)pos[i]      <= 0;
        // `elsif FC
            register[ 4] <= 32'h01_01_01_01; // input
            register[ 3] <= 32'h01_01_01_01; // bias (only the first two quarters will be read)
            for (i = FILE_SIZE-1; i> FILE_SIZE-1-WEIGHT_SIZE; i = i-1) 
                register[i] <= 32'h01_01_01_01; 
            for(i= 0;i< 3;i=i+1)register[i] <= 0;
            for(i= 5;i<9;i=i+1)register[i] <= 32'h01_01_01_01;
            for(i= 10;i<12;i=i+1)register[i] <= 0;
            for(i= 0;i<FILE_SIZE;i=i+1)pos[i]      <= 0;
        // `elsif Conv
        //     register[ 3] <= 32'h01_00_00_00; // bias
        //     register[ 4] <= 32'h01_02_03_04; // input
        //     register[ 5] <= 32'h01_01_01_01; // input 
        //     for (i = FILE_SIZE-1; i> FILE_SIZE-1-WEIGHT_SIZE; i = i-1) 
        //         register[i] <= 32'h01_01_01_01; 
        //     for(i= 0;i< 3;i=i+1)
        //         register[i] <= 0;
        //     for(i= 6;i<= FILE_SIZE-1-WEIGHT_SIZE;i=i+1)
        //         register[i] <= 0;
        //     for(i= 0;i<16;i=i+1)pos[i]      <= 0;
        // `else
        //     for(i=0;i<16;i=i+1)register[i] <= 0;
        //     for(i=0;i<16;i=i+1)pos[i]      <= 0;
        // `endif
    end  

    else  begin
        if(RegWrite_i)begin
            register[RDaddr_i] <= RDdata_i;
            pos[RDaddr_i]      <= is_pos_i;
        end
    end      
end
   
endmodule 
