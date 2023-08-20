module gates();

reg i_1, i_2;
wire o_1;

// verilog gate primitive syntax:
    // Gate_type uniqueName(output, input,input,etc)
and U1(o_1, i_1, i_2);
// nand, or, nor, xor, xnor
initial begin
    // always need a monitor to view results
    $monitor(
        "o_1=%b i_1=%b i_2=%b",
        o_1, i_1, i_2
    );
    $dumpfile("gates.vcd");
    $dumpvars();
    i_1 =0;
    i_2 = 0;
    #1 i_1 = 1;
    #1 i_2 = 1;
    #1 $finish;
end

endmodule
