`timescale 1ns/1ns //Setting the timescale

module Full_AdderTB();

//Variable devlaration
reg [2:0] Inputs;
wire S;
wire Cout;
integer i;

//Instantiating the Device Under Test
Full_Adder DUT( 
.A(Inputs[0]),
.B(Inputs[1]),
.Cin(Inputs[2]),
.Cout(Cout),
.S(S)
);

//Begin Test Operation
initial begin
$display("Full Adder: Test Cases all possible 8 combinations with Initial Carry In=0");
$display("\tTime, \tA, \tB, \tCin, \tSum, \tCout");
$monitor("%t, \t%b, \t%b, \t%b, \t%b, \t%b,", $time, Inputs[0], Inputs[1], Inputs[2], S, Cout);


for(i=3'b000; i<=3'b111; i=i+3'b001) begin
Inputs =  i;
#20; //20ns time gap
end



$stop;
end

endmodule