module FC_Registers #
(
    parameter BITWIDTH = 8, 
    parameter INPUT_SIZE = 7, 
    parameter OUTPUT_SIZE = 5
)
(
    clk_i,
    reset,
    addr, 
    data_i,
    RegWrite_i
);
integer i;
// Ports
input               clk_i;
input               reset;
input   [4:0]       addr_i;
input   [31:0]      data_i;
input               RegWrite_i;

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
        for(i=0;i<32;i=i+1)register[i] <= 0;
        for(i=0;i<32;i=i+1)pos[i]      <= 0;
    end  

    else  begin
        if(RegWrite_i)begin
            register[RDaddr_i] <= RDdata_i;
            pos[RDaddr_i]      <= is_pos_i;
        end
    end      
end
   
endmodule 
