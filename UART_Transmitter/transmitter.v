// 4 bit transmitter with 1 start and 1 stop bit
module transmitter(
    input wire receiver_clk,
    
    input wire pin1,
    input wire pin2,
    input wire pin3, 
    input wire pin4,

    output reg transmitter

);
reg [2:0] transmitter_counter = 3'b0 ;
reg [5:0] transmitter_memory  = 6'b0; 

initial begin
    transmitter = 0;
    transmitter_counter = 0;
end 
always @(posedge receiver_clk) 
    if (transmitter_counter != 0) begin
        transmitter_counter <= transmitter_counter - 1; 
        transmitter = transmitter_memory[transmitter_counter -1];
        

    end else if (transmitter_counter == 0) begin 
        transmitter <= 0;
        transmitter_counter <= 6;
        transmitter_memory <= {1'b1, pin1, pin2, pin3, pin4, 1'b1};
    end 
endmodule 

// Just pretend like the clock I'm inputting here is synced up to the BaudRate_generator clock
module test_transmitter();
reg receiver_clk;
reg pin1, pin2, pin3, pin4; 
wire transmitter;
reg counter;
transmitter U(
    .receiver_clk(receiver_clk),
    .pin1(pin1),
    .pin2(pin2),
    .pin3(pin3),
    .pin4(pin4),
    .transmitter(transmitter)
);

initial begin
    $dumpfile("UART_Transmitter.vcd");
    $dumpvars();
    receiver_clk = 0;
    pin1 = 0;
    pin2 = 0;
    pin3 = 0;
    pin4 = 0;
    #1
    pin1 = 1;
    pin2 = 0;
    pin3 = 1;
    pin4 = 1;
    #1
    pin1 = 0;
    pin2 = 0;
    pin3 = 0;
    pin4 = 0;
    #13
    pin1 = 1;
    pin2 = 1;
    pin3 = 0;
    pin4 = 1;
    #1
    pin1 = 0;
    pin2 = 0;
    pin3 = 0;
    pin4 = 0;
    #13
    pin1 = 1;
    pin2 = 1;
    pin3 = 0;
    pin4 = 1;
    #1
    pin1 = 0;
    pin2 = 0;
    pin3 = 0;
    pin4 = 0;
    #13
    pin1 = 1;
    pin2 = 1;
    pin3 = 0;
    pin4 = 1;
    #1
    pin1 = 0;
    pin2 = 0;
    pin3 = 0;
    pin4 = 0;
    #13
    pin1 = 0;
    pin2 = 1;
    pin3 = 0;
    pin4 = 0;
    #1
    pin1 = 0;
    pin2 = 0;
    pin3 = 0;
    pin4 = 0;
    #40 $finish;

end 
always #1 receiver_clk = ~receiver_clk;
endmodule 



