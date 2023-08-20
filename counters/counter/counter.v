module counter(
    clock,
    reset,
    enable,
    counter_out
);
input reset, clock, enable;
// by rule all input ports are wires
wire clock;
wire reset;
wire enable;

// output can be storage element (reg) or wire
// 4 bit output: meaning it is 4 binary position value
output [3:0] counter_out;
reg [3:0] counter_out ; 

always @ (posedge clock)
begin: COUNTER // blockname 

    // `b1 designates binary, and number of bits 
    if (reset == 1'b1) begin
        counter_out <=  #1  4'b0000; 
        /* can't set a value for enable, as 
        wire values can only bet set in the test bench.
        Also on the DUT, the reset wire has no bearing on
        if the enable wire is ON or OFF
        */
        // enable <= 0;

    end 
    else if (enable == 1'b1 ) begin
        counter_out <= #1 counter_out + 1;
    end
end 
endmodule