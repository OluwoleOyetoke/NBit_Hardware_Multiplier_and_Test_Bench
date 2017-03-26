//Module declaration
module Submodule_2(
input inputM,
input inputQ,
input bitsOfPPI,
input cin,

output moduleOutput,
output cout,
output outputM
 );
 
 
 wire andOutput;
 assign andOutput = inputM & inputQ;
 assign outputM = inputM;
 
 
 //Instatntiate full adder.
//Attach full adder to the necessary module components
Full_Adder FA( 
.A(bitsOfPPI),
.B(andOutput),
.Cin(cin),
.S(moduleOutput),
.Cout(cout)  
);
 
 
 endmodule