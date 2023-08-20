`timescale 1ns/1ns 
`include "hello.v"

module hello_tb;

reg A;
wire B;

// defines unit test
hello uut(A, B);
initial begin
    // Define file to hold output wave file
    $dumpfile("hello_tb.vcd");
    $dumpvars(0, hello_tb);

    A= 0; 
    #20 ; // waits 20 ns
    A=1;
    #20;
    A=0;

    $display("Test complete");
end

endmodule