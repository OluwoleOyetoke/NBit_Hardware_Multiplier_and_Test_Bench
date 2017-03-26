`timescale 1ns/1ns

module fourByFourMultiplierTB();
reg [3:0] m;
reg [3:0] q;
wire[7:0] expectedValue;
wire [6:0] SevenSegValue0;
wire [6:0] SevenSegValue1;
wire [6:0] SevenSegValue2;
wire [7:0] p;
integer i;
integer j;


fourByFourMultiplier DUT(
.q(q),
.m(m),
.p(p),
.HEX0(SevenSegValue0), //BCD Output
.HEX1(SevenSegValue1), //BCD Output
.HEX2(SevenSegValue2) //BCD Output
);

assign expectedValue = q*m;

//begin testing
initial begin
$display("Four By Four Multiplier test bench: Test for all possible 2^4 * 2^4 inputs using auto verification");
$display("A\t\t*\t\tB\t\t=\t\tAnswer\t\tExpected Answer");
$monitor("%b\t\t*\t\t%b\t\t=\t\t%b\t\t%b", q,m,p,expectedValue);



//use automated test bench to test all possible multiplications
for(i=4'b0000; i<=4'b1111; i=i+4'b0001)begin
m = i;
for(j=4'b0000; j<=4'b1111; j=j+4'b0001)begin
q=j;
#5;
if(p!==expectedValue)begin
$display("Error when I/P m=%b and q=%b\t\tResult Gotten=%b\t\tExpected Result=%b",m,q,p,expectedValue);
$stop;
end
#20;
end
end

$stop;
end

endmodule
