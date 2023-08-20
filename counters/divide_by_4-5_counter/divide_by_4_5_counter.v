module counter_4_5(
    input clk_in,
    input reset,
    // input enable,
    output clk_out
);

reg [3:0] pos_edge;
reg [3:0] neg_edge;
reg toggle;
reg toggle1;

always @ (posedge clk_in)
    if (reset ==1) begin
        pos_edge <= 0;
        neg_edge <= 0;
    end
    else begin
        pos_edge <=  pos_edge +1;
    end 

always @(negedge clk_in)
    if (reset ==1) begin
        pos_edge <= 0;
        neg_edge <= 0;
    end
    else if (neg_edge == 4)begin
        neg_edge <=0;
        pos_edge <=0;
    end else begin
        neg_edge <=  neg_edge +1;
    end 


assign clk_out  = neg_edge < 4  &&  pos_edge >= 1;
endmodule 

module tb();

reg clk_in;
reg reset;
wire clk_out;
counter_4_5 U(
    clk_in,
    reset,
    clk_out
);
initial begin
    clk_in = 0;
    reset = 0;
    $dumpfile("divide_45.vcd");
    $dumpvars();
    #2 reset = 1;
    #10 reset = 10;
    #100 $finish;
end

always  #1  clk_in =~ clk_in;
endmodule