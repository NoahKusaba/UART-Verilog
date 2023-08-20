/*
-------- These are my personal notes when studying ----------------

Purpose of Verilog
 - Used for conceptual design of IC 

 - Before Verilog
    - All hardware designed via schematics
    - Hard to verify / error-prone / tedious (verfication <-> design)

- What Verilog solved
    - Changed how to think about logic circuit
    - Development Path of Verilog
        - Specifications (specs)
        - High level design
        - Low level design (micro)
        - RTL coding
        - Verification
        - Synthesis

*/
/*
    - Definitions:
        - Module:
            - Black box IC
            - Reserved word to reqfer to Thing with inputs/outputs/internal-logic
            - Basically a function 
*/

/* 
Step 1: Specifications

    - Process:
        - Define restrictions
        - Define requirements 
        - What are we buidling?  

Two Agent Arbiter: 
    - Specifications: 
        - Selects between two agents for mastership
        - Activate high asynchronous reset
        - Fixed priority, agent 0 priority over agent 1
        - grant asserted if request asserted 

    - Draw Block Diagram
        - Some picture of black box
            - 4 Inputs:
                - Clock
                - Reset
                - request_1
                - request_2
            - 2 Outputs:
                - grant_1
                - grant_2
    - How to do without Verilog
        - Draw state machine 
        - Create Truth table: define all state transitions for each flip-flop
        - Draw Karnaugh Maps
        - Create optimized circuit
    - Critique of old method:
        - Ok for smal ldesigns
        - Too complicated for large designs

    
*/


// Arbiter Start
module arbiter (
    clock , 
    reset ,
    req_0 ,
    gnt_0 , 
    gnt_1 
);
// input ports

input clock ;
input reset ; 
input req_0 ;
input req_1 ;


// Output ports
output gnt_0;
output gnt_1;

// How to define vector signals 
    // SIGNALS componsed of sequence of more than 1 bit
inout [7:0] address ; // port 'address' is bidirectional (input/output, aka inout)
// 7:0 is little endian convention
// start at 0, then move LEFT to 7

// 0:7 would be big endian convention, starting at 0 going RIGHT to 7

// Endian decides which direction your data will read
// use consistent endians 


// Hardware has two kinds of drivers
/* Driver is a data type which can drive a load
    - In physical circuit, driver is anything that electrons can move through/into

    - Functions of drivers:
        - Drivers that store value: (flip-flop)
            - called a "reg" in verilog, or register
        - Drivers that connect two points (wire) -> can't store value


*/

/*
    - Verilog has control statements:
        - if, else, repeat, while, for , case
            - Need to make sure it translates to hardware
                - If not, design will not be implementable
*/
// Latch -> Error if not all conditional statments supported

// if-else:
// Note that 'begin', and 'end' act as curly braces
if (enable == 1'b1) begin
    date = 10; // decimal
    address = 16'hDEAD; //hexadecimal
    wr_enable = 1'b1; // binary
end else begin
    date = 32'b0;
    wr_enable = 1'b0 ; 
    address = address +1; 
end 

// case
// Basically a switch statement
case (address)
    0: $display ("It is 11:40 PM"); 
    1: $display ("I am Noah Kusaba"); 
    2: $display ("This actually isn't trash");
    default: $display ("Yo");
endcase

// while
// not normally used to model real life
// mostly usded in test benches
// Note that statements can execute in parallel
// ALL blocks marked "always" will run simultaneously, if conditioned fulfilled
    // can have many more always statements 
// Can disable code using "disable"
while (free_time) begin
    $display ("Whatup")
end

module counter (clk,rst,enable, count); 
input clk, rst, enable ;
output [3:0] count; 
reg [3:0] count;

// runs if clk, or rst reaches a positive edge (value from 0-> 1)
always @ (posedge clk or posedge rst)
if (rst) begin
    count <= 0;
end else begin : COUNT
    while (enable) begin
        count <= count +1;
        disable COUNT;
    end
end 
endmodule 

// For Loops
// ++ and -- not supported, use i = i+1
for (i=0; i <16; i = i+1) begin
    $display ("Current value of i is %d", i);
end

// Repeat 
// Rare to use in hardware implementation
repeat (16) begin 
    $display ("current value of i is %d", i)

/*
    - In Digital there are two types of elements:
        - Combinational
            - output changes, by changing input
        - Sequential
            - 
    - How to model in Verilog
        - Two ways to model Combinational
            - assign, always statements
        - One way to model Sequential
            - Always statement
        - Used in test benches only
            - Initial statement
*/
// Initial Block
// when time = 0
// Executes onec at the beginning of simulatio
initial begin
    clk = 0;
    reset = 0;
    req_0 = 0;
    req_1 = 0;
end

/*
    - Always block
        - Always executes
        - Can't drive wire data types
            - Can drive Reg, integer data types
        - Should have a delay or sensative list associated with it 
            - Sensative List
                - When to exeute code "@ ()"
                - Refers to the input variables
                - Types of sensative lists
                    - level Sensative
                        - Combinational circuits
                    - Edge Sensative
                        - flip-flops

*/ 
// Combinational Circuit
// 2:1 mux, where inputs are a and b
// sel, is the select input
// y is the mux output 
always @ (a or b or sel)
begin
    y=0;
    if(sel == 0) begin
        y=a ;
    end else begin
        y=b;
    end
end
// flip-flop circuit
// Note that = is blocking (synchronous execution inside a begin / end)
// Note that <= is non-blocking (parallel execution)
always @ (posedge clk)
if (reset == 0 ) begin
    y<=0
end else if (sel == 0) begin
    y <=a ; 
end else  begin
    y <=b
end 

// Always block without sensative list 
// the "#5" delays execution by 5 time units
always begin
    #5 clk = ~ clk ; 
end 

/*
    - Assign Statement
        - For Combinational Logic
        - Executed continuously 
        - No sensative list
*/ 
// Tri-state buffer
// if enable == 1
    // data is driven to out
assign out = (enable) ? data:1'bz

// Simple buffer
assign out = data

/*
    - Functions & Tasks
        - Has the same syntax
        - Functions:
            - Can return a value
            - Can't have delays
                - can be used for combinational logic
        - Tasks
            - Can't return a value
            - Can have delays 
*/
// Checks for even parity
function parity; 
input  [31:0] data;
integer i;
begin
    parity= 0; 
    for (i=0; i < 32; i= i+1) begin
        parity = parity ^ data[i];
    end
end
endfunction

 
/* 
    - Test Benches
        - test if code works according to specifications
            - Drive Inputs
            - Measure outputs against expected values
*/
// Arbiter code
module arbiter ( 
    clock, 
    reset,
    req_0,
    req_1, 
    gnt_0, 
    gnt_1
);
input clock, reset, req_0, req_1; 
output gnt_0, gnt_1;

reg gnt_0, gnt_1; 

always @ ( posedge clock or posedge reset)
if (reset) begin
    gnt_0 <= 0; 
    gnt_1 <= 0;
end else if (req_0) begin
    gnt_0 <=1;
    gnt_1 <=0;
end else if (req_1) begin 
    gnt_0 <= 0; 
    gnt_1 <=1;
end 
endmodule
// TestBench Code
module arbiter_tb; 
reg clock, reset ,req0, req1; 
wire gnt0, gnt1; 
initial begin
    $monitor ("req0=%b, req1=%b, gnt0=%b, gnt1=%b", req0 , req1, gnt0, gnt1);
    clock = 0;
    reset = 0; 
    req0= 0;
    req1 = 0;
    %5 reset = 1;
    %15 reset = 0;
    %10 req0 = 1;
    %10 req0 = 0 ;
    %10 req1 = 1;
    %10 req1 = 0;
    %10 {req0, req1} = 2'b11;
    %10 {req0, req1} = 2'b00;
    %10 $finish;
end 
always begin
    #5 clock =! clock ;
end
arbiter U0 (
.clock (clock) , 
.reset (reset), 
.req_0 (req0), 
.req_1 (req1), 
.gnt_0 (gnt0),
.gnt_1 (gnt1)
);
endmodule


    

