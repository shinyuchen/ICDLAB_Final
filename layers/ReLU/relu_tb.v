`timescale 1ns/10ps
`define CYCLE    10           	         // Modify your clock period here
//`define SDFFILE  "./alu.sdf"	         // Modify your sdf file name
`define INPUT     "./input.dat"         // Modify your test image file
`define OUTPUT     "./output.dat"    // Modify your output golden file

module ALU_test;

parameter DATA_LENGTH   = 20;
parameter OUT_LENGTH    = 20;

reg           clk;
reg           reset;
wire  [15:0]  dataout;

reg signed  [7:0]   inputs  [0:DATA_LENGTH-1];
reg   [7:0]   outputs  [0:DATA_LENGTH-1];
reg   [7:0]   temp_outputs  [0:DATA_LENGTH-1];

reg signed [7:0] data_in;
wire signed [7:0] result_out;

reg   [15:0]  out_mem   [0:OUT_LENGTH-1];

Relu relu_0(.clk(clk), .data(data_in), .result(result_out) );

//initial $sdf_annotate(`SDFFILE, top);
initial	$readmemb (`INPUT,  inputs);
initial	$readmemb (`OUTPUT,  outputs);
// initial	$readmemh (`CMD,    cmd_mem);
// initial	$readmemh (`EXPECT, out_mem);

integer i, j, error;
initial begin
   clk         = 1'b1;
   reset       = 1'b1;
   i = 0;
   j = 0;
    error = 0;
end

always begin #(`CYCLE/2) clk = ~clk; end



always @(negedge clk) begin
    data_in = inputs[i];
end

always @(posedge clk) begin
    temp_outputs[i] = result_out;
    i = i+1;
end

always @(*) begin
    if(i == DATA_LENGTH) begin
        $display("---------------------------------------------\n");
        while (j < DATA_LENGTH) begin
            if(outputs[j] !== temp_outputs[j]) begin
                $display("error %d %d %d", j, temp_outputs[j], outputs[j]);
                error = error+1;
            end
            else begin
                $display("correct %d %d", inputs[j], outputs[j]);
            end
            j = j+1;
        end
        if(error == 0)
            $display("------------------- ALL PASS-------------------\n");
        $finish;
    end
end

endmodule









