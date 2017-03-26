//Declare Module variables
module Full_Adder(
input A,      //Input A
input B,      //Input B
input Cin,    //Carry In
output S,     //Sum
output Cout  //Carry Out
);

//Using the behavioural model
assign S= ((A^B)^Cin);
assign Cout = ((A&B)|(Cin&(A^B)));


endmodule