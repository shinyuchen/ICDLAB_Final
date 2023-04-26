module Max_pool#(
    parameter integer BITWIDTH = 8,
    
    parameter integer DATAWIDTH = 28,
    parameter integer DATAHEIGHT = 28,
    parameter integer DATACHANNEL = 3,
    
    parameter integer KWIDTH = 2,
    parameter integer KHEIGHT = 2
    )
    (
    input [BITWIDTH * DATAWIDTH * DATAHEIGHT * DATACHANNEL - 1 : 0]data,
    output [BITWIDTH * DATAWIDTH / KWIDTH * DATAHEIGHT / KHEIGHT * DATACHANNEL - 1 : 0] result
    );
    
    wire [BITWIDTH - 1 : 0] dataArray[0 : DATACHANNEL - 1][0 : DATAHEIGHT-1][0 : DATAWIDTH - 1];
    wire [BITWIDTH * KHEIGHT * KWIDTH - 1 : 0]paramArray [0: DATACHANNEL - 1][0: DATAHEIGHT / KHEIGHT - 1][0: DATAWIDTH / KWIDTH - 1];
    
    //wire [BITWIDTH * DATAWIDTH / KWIDTH * DATAHEIGHT / KHEIGHT * DATACHANNEL - 1 : 0] out;
    
    genvar i, j, k, m, n;
    generate       
        for(i = 0; i < DATACHANNEL; i = i + 1) begin
            for(j = 0; j < DATAHEIGHT; j = j + 1) begin
                for(k = 0; k < DATAWIDTH; k = k + 1) begin
                    assign dataArray[i][j][k] = data[(i * DATAHEIGHT * DATAWIDTH + j * DATAHEIGHT + k) * BITWIDTH + BITWIDTH - 1 -:BITWIDTH];
                end
            end
        end      
    endgenerate
    
    // generate
    //     for(k = 0; k < DATACHANNEL; k = k + 1) begin
    //         for(i = 0; i < DATAHEIGHT; i = i + KHEIGHT) begin
    //             for(j = 0; j < DATAWIDTH; j = j + KWIDTH) begin
    //                 assign paramArray[k][i][j] = dataArray[k][i +:KHEIGHT][j +:KWIDTH];
    //             end
    //         end
    //     end   
    // endgenerate

    generate 
        for(i = 0; i < DATACHANNEL; i = i + 1) begin
            for(j = 0; j < DATAHEIGHT / KHEIGHT; j = j + 1) begin
                for(k = 0; k < DATAWIDTH / KWIDTH; k = k + 1) begin
                    for(m = j * 2; m < j * 2 + KHEIGHT; m = m + 1) begin
                        for(n = k * 2; n < k * 2 + KWIDTH; n = n + 1) begin
                            assign paramArray[i][j][k][((m - j * 2) * KWIDTH + n - k * 2) * BITWIDTH + BITWIDTH - 1 -: BITWIDTH] = dataArray[i][m][n];
                        end
                    end                   
                end
            end
        end
    endgenerate
    
    generate
        for(i = 0; i < DATACHANNEL; i = i + 1) begin
            for(j = 0; j < DATAHEIGHT / KHEIGHT; j = j + 1) begin
                for(k = 0; k < DATAWIDTH / KWIDTH; k = k + 1) begin
                    Max#(BITWIDTH, KHEIGHT * KWIDTH) max(paramArray[i][j][k], result[(i * DATAHEIGHT / KHEIGHT * DATAWIDTH / KWIDTH + j * DATAWIDTH / KWIDTH + k) * BITWIDTH + BITWIDTH - 1 -: BITWIDTH]);
                end
            end
        end
    endgenerate
    
    // always @(posedge clk) begin
    //     if(clken == 1) begin
    //         result = out;
    //     end
    // end
    
endmodule