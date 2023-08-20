module Baud #(
    parameter Clock_Rate = 100000000,
    parameter Baud_Rate = 9600
    )(
    input wire clk_in,
    output reg receiver_clk
);


parameter receiver_rate = Clock_Rate /(2*Baud_Rate * 16);
parameter register_width = $clog2(receiver_rate);
reg [register_width -1 :0] receiver_counter = 0;
initial begin
    receiver_clk = 1'b0;
end 

always @(posedge clk_in)
    if (receiver_counter == receiver_rate[register_width -1:0] ) begin
        receiver_counter <= 0;
        receiver_clk <= ~receiver_clk;
    end else begin
        receiver_counter <= receiver_counter + 1;
    end 

endmodule

module test_baud();
reg clk_in;
wire receiver_clk;
Baud U(
    .clk_in (clk_in),
    .receiver_clk(receiver_clk)
);

initial begin
    $dumpfile("baudRate.vcd");
    $dumpvars();
    clk_in = 0;

    #2000 $finish;
end
always #1 clk_in = ~clk_in;
endmodule 