/*
transistor models:
    - nmos
    - pmos
    - cmos
    - Resistive versions:
        - rnmos
        - rpmos
        -rcmos
    */


module switch_primitives();
wire  net1, net2, net3;
wire  net4, net5, net6;
 
// gates are on permanently, with no control
// keyword name (drain, source, gate)
tranif0 my_gate1 (net1, net2, net3);
rtranif1 my_gate2 (net4, net5, net6);

initial begin
    $dumpfile("switch.vcd");
    $dumpvars();
    #10;
end
endmodule