module Registers
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
    pos_o
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
output  [31:0]       reg_o;
output  [3:0]       pos_o;
// Register File
reg     [31:0]      register        [0:31];
reg     [3:0]       pos             [0:31];
// Read Data      
assign  RSdata_o = register[RSaddr_i];
assign  RTdata_o = register[RTaddr_i];
assign  reg_o    = register[op_address];
assign  pos_o    = pos[op_address];
// Write Data

always@(negedge clk_i or posedge reset)begin
    if(reset) begin
        // for(i=0;i<32;i=i+1)register[i] <= 0;
        // for(i=0;i<32;i=i+1)pos[i]      <= 0;

        `ifdef MP
            register[2] <= 32'hff_ee_11_00;
            register[3] <= 32'h00_00_00_00;
            register[4] <= 32'h7f_ff_e3_11;
            for(i=0;i< 2;i=i+1)register[i] <= 0;
            for(i=5;i<32;i=i+1)register[i] <= 0;
            for(i=0;i<32;i=i+1)pos[i]      <= 0;
        `else
            for(i=0;i<32;i=i+1)register[i] <= 0;
            for(i=0;i<32;i=i+1)pos[i]      <= 0;
        `endif
    end  

    else  begin
        if(RegWrite_i)begin
            register[RDaddr_i] <= RDdata_i;
            pos[RDaddr_i]      <= is_pos_i;
        end
    end      
end
   
endmodule 
