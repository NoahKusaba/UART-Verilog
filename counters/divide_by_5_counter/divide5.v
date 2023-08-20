module divide_5(
    input clk_in,
    input reset,
    output clk_out
);

wire clk_in, reset, clk_out;

reg [2:0] pos_cnt;
reg [2:0] neg_cnt;

always @(posedge clk_in)
    begin
        if (reset) begin 
            pos_cnt <=0;
        end 
        else begin
            pos_cnt = pos_cnt == 5 ? 0: pos_cnt +1;
        end 
        
    end 

always @(negedge clk_in)
    begin
        if (reset) begin 
            neg_cnt <=0;
        end 
        else begin
        neg_cnt = neg_cnt==5 ? 0 : neg_cnt +1;
        end 
    end 


assign clk_out =  pos_cnt != 5; // && neg_cnt != 5;
endmodule

module test();
wire clk_out;
reg  reset, clk_in;
divide_5 U(
    clk_in,
    reset,
    clk_out
);
initial begin
    $dumpfile("divide5_tb.vcd");
    $dumpvars();
    clk_in = 0;
    #1 reset = 1;
    
    #5 reset = 0;
    #100 $finish;

end
always #1 clk_in =~clk_in;

endmodule
