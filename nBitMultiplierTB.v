`timescale 1ns/1ns

//testing the nbit adder using n=3
module nBitMultiplierTB();
reg [5:0] m;
reg [5:0] q;
wire[11:0] expectedValue;
wire [11:0] p;
integer i;
integer j;


nBitMultiplier #(
.WIDTH(6) //n=6

) DUT(
.q(q),
.m(m),
.p(p)
);

assign expectedValue = q*m;

//begin testing
initial begin
$display("N-Bit Multiplier test bench using automated verification: Test for all possible 2^6 *2^6  inputs");
$display("A\t\t*\t\tB\t\t=\t\tAnswer\t\tExpected Answerr");
$monitor("%b\t\t*\t\t%b\t\t=\t\t%b\t\t%b", q,m,p,expectedValue);

//use automated test bench to test all possible multiplications
for(i=6'b000000; i<=6'b111111; i=i+6'b000001)begin
m = i;
for(j=6'b000000; j<=6'b111111; j=j+6'b000001)begin
q=j;
#5;
if(p!==expectedValue)begin
$display("Error when I/P m=%b and q=%b\t\tResult Gotten=%b\t\tExpected Result=%b",m,q,p,expectedValue);
$stop;
end
#20;
end
end


end




endmodule