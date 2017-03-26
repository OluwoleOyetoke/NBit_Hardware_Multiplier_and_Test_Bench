`timescale 1ns/1ns
module Submodule_2TB();

//0 - BitsofPPI, 1 - M AND 
//2 - Q, 3 - Cin
reg [3:0] Inputs;
wire moduleOutput;
wire mOutput;
wire cOut;

integer i;

Submodule_2 DUT( 
.bitsOfPPI(Inputs[0]),
.inputM(Inputs[1]),
.inputQ(Inputs[2]),
.cin(Inputs[3]),
.cout(cOut),
.outputM(mOutput),
.moduleOutput(moduleOutput)
);

//Begin test operation
initial begin

//Print out output values
$display("Submodule_2/B test bench: Test for all possible 2^4 inputs");
$display("PPI, \tM, \tQ, \tc(in), \t\t\tc(out), \tm(out), \tModuleOutput");
$monitor("%b, \t%b, \t%b, \t%b, \t\t\t%b, \t%b, \t%b",Inputs[0],Inputs[1],Inputs[2],Inputs[3], cOut, mOutput, moduleOutput);


//tes for all possible 2^4 inputs
for(i=4'b0000; i<=4'b1111; i = i+4'b0001) begin
#20 //delay by 20 nanoseconds
Inputs = i; 
end


end

endmodule