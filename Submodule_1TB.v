`timescale 1ns/1ns
module Submodule_1TB();


//0 - m0, 1 - m1 AND 
//2 - q0, 3 - q1 AND
//4 - cin 
reg [4:0] Inputs;
wire moduleOutput;
wire mOutput;
wire cOut;

integer i;

Submodule_1 DUT( 
.inputMs({Inputs[1],Inputs[0]}),
.inputQs({Inputs[3],Inputs[2]}),
.moduleOutput(moduleOutput),
.cin(Inputs[4]),
.cout(cOut),
.outputM(mOutput)
);

//Begin test operation
initial begin

//Print out output values
$display("Submodule_1/A test bench: Test for all possible 2^5 inputs");
$display("m(k), \tm(k+1), \tq(0), \tq(1), \tc(in), \t\t\tc(out), \tm(out), \tModuleOutput");
$monitor("%b, \t%b, \t%b, \t%b, \t%b, \t\t\t%b, \t%b, \t%b",Inputs[0],Inputs[1],Inputs[2],Inputs[3],Inputs[4], cOut, mOutput, moduleOutput );


//tes for all possible 2^5 inputs
for(i=5'b00000; i<=5'b11111; i = i+5'b00001) begin
#20 //delay by 20 nanoseconds
Inputs = i; 
end


end

endmodule