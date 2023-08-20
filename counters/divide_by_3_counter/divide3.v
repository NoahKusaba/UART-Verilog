module divide_3(
    input clk_in,
    input reset,
    output clk_out
);

reg [1:0] pos_cnt;
reg [1:0] neg_cnt;

// poesge counter
always @ (posedge clk_in)
    if (reset) begin
        pos_cnt <= 0;
    end else begin
        pos_cnt <= (pos_cnt ==2) ? 0:pos_cnt +1;
    end
// Neg edge counter
always @ (negedge clk_in)
    if (reset) begin
    neg_cnt <= 0;
    end else begin
        neg_cnt <= (neg_cnt == 2) ? 0: neg_cnt +1;
    end 
// assign continuously drives signal (Concurrent instantiation)
assign  clk_out =  ((pos_cnt != 2)) && (neg_cnt !=2);
endmodule 

//Testbench
module test();
reg reset, clk_in;
wire clk_out;
divide_3 U (
    .clk_in (clk_in),
    .reset (reset),
    .clk_out (clk_out)
);

initial begin
    $dumpfile("divide3.vcd");
    $dumpvars();
    clk_in = 0;
    reset =0;
    #2 reset = 1;
    #2 reset = 0;
    #100 $finish;
end
always #1 clk_in =~clk_in;
endmodule