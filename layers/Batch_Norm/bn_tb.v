`timescale 1ns/10ps
`define CYCLE    30           	         // Modify your clock period here
//`define SDFFILE  "./alu.sdf"	         // Modify your sdf file name
`define INPUT     "./input.dat"         // Modify your test image file
`define OUTPUT     "./output.dat"    // Modify your output golden file

module ALU_test;

parameter DATA_LENGTH   = 5;
parameter OUT_LENGTH    = 5;

reg           clk;
reg           reset;

reg signed  [15:0]   inputs  [0:DATA_LENGTH-1];
reg  signed [15:0]   outputs  [0:DATA_LENGTH-1];
reg  signed [15:0]   temp_outputs  [0:DATA_LENGTH-1];

reg signed [15:0] data_in;
reg signed [15:0] weight_in;
reg signed [15:0] bias_in;
wire signed [15:0] result_out;
wire finish_flag;

reg   [15:0]  out_mem   [0:OUT_LENGTH-1];

BN2d bn2d_0(.clk(clk), .rst(reset), .data(data_in), .weight(weight_in), .bias(bias_in), .result(result_out), .finish_flag(finish_flag));

//initial $sdf_annotate(`SDFFILE, top);
initial	$readmemb (`INPUT,  inputs);
initial	$readmemb (`OUTPUT,  outputs);
// initial	$readmemh (`CMD,    cmd_mem);
// initial	$readmemh (`EXPECT, out_mem);

integer i, j, error;
initial begin
    clk         = 1'b1;
    i = 0;
    j = 0;
    error = 0;
    weight_in = 2540;
    bias_in = 8422;
end

initial begin
    reset       = 1'b1;
    #(`CYCLE/4)
    reset       = 1'b0;
end

always begin #(`CYCLE/2) clk = ~clk; end


always @(negedge clk) begin
    data_in = inputs[i];
end

always @(posedge clk) begin
    if(finish_flag) begin
        temp_outputs[i] = result_out;
        i = i+1;
    end
end

always @(*) begin
    if(i == DATA_LENGTH) begin
        $display("---------------------------------------------\n");
        while (j < DATA_LENGTH) begin
            if(outputs[j] !== temp_outputs[j]) begin
                // $display("error %d %b %b", j, temp_outputs[j], outputs[j]);
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









