//create submodule 1 and declare its input and output variables
module Submodule_1( 
input [1:0] inputMs,
input [1:0] inputQs,
output moduleOutput,
input cin,
output cout,
output outputM
);

wire andLeftOut;
wire andRightOut;

//Exploit behavioural characteristics in designing the module
assign outputM = inputMs[0];
assign andLeftOut =  inputMs[1] & inputQs[0];
assign andRightOut =  inputMs[0] & inputQs[1];


//Instatntiate full adder.
//Attach full adder to the necessary module components
Full_Adder FA( 
.A(andLeftOut),
.B(andRightOut),
.Cin(cin),
.S(moduleOutput),
.Cout(cout)  
);


endmodule