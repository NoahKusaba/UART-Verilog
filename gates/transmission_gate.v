module transmission_gates();
// variables resistive bi-directional gates
//syntax:


reg data_low, in; 
wire data_bus, out1, out2;

//keyword name(inout, inout, control)
/*

bifif0
tristate buffer, active low energy
 Basically if data_low is on, data_bus has impedence (Z)
 and current can't pass through. 
 if data_low if off
 current from in, reaches data_bus

bufif1
If data_low is on, then "in " can turn data_bus on
*/
notif0 U1(data_bus, in, data_low);
//buff out1 is on, if in is on 
buf U2(out1, in);
// inverse of buff
not U3(out2, in);
initial begin 
    $dumpfile("transmission.vcd");
    $dumpvars();
    $monitor ("@%g in=%b data_enable_low=%b out1=%b out2= b data_bus=%b", 
        $time, in, data_low, out1, out2, data_bus);
    
    data_low =0;
    in=0;
    #4 data_low = 1;
    #4 data_low = 0;
    #8 $finish;


end 

always #2 in=~in;
endmodule 