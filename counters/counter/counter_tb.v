`include "counter.v"
module counter_tb(); 
counter U_counter (
    clock,
    reset,
    enable,
    counter_out
);

// "counter" needs to match up with included filename

// declare inputs as regs, and OUTPUTs as wires
reg clock, reset, enable;
wire [3:0] counter_out;

//built in delays 
// buf #(5) (reset, enable, counter_out)
// or 
// buf #(5, 3) (reset, enable) // you get it
/*
buf #(1,0)U_rise (rise_delay,in); 
 buf #(0,1)U_fall (fall_delay,in); 
 buf  #1  U_all (all_delay,in); 
*/
initial begin 
    $dumpfile("counter.vcd");
    $dumpvars(0,counter_tb);
    $monitor ("%g\t %b   %b     %b      %b",  $time, clock, reset, enable, counter_out);
    $display("Test complete yo");
    clock = 1;
    reset = 0;
    enable = 0;
    #5 reset = 1;
    #10 reset = 0;
    #10 enable = 1;
    #10 enable =0;
    #10 enable = 1;
    #10 enable =0;
    #10 enable = 1;
    #10 enable =0;
    #5 $finish;


end 

//toggle every 5 ticks
always begin
    #5 clock =~ clock;
end
// Connect DUT to test bench

endmodule