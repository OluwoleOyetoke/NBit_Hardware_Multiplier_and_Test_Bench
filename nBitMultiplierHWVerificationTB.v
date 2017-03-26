`timescale 1ns/1ns

//testing the nbit adder using n=6
module nBitMultiplierHWVerificationTB();
reg [3:0] m;
reg [3:0] q;
wire[11:0] expectedValue;
wire [7:0] p;
wire [11:0] BDCValue;
integer i;
integer j;


nBitMultiplierWithHWConnection #(
.WIDTH(4) //n=4

) DUT(
.q(q),
.m(m),
.p(p), //binary input to BCD
.dummyDoubleDabble(BDCValue) //BCD Output
);

assign expectedValue = 12'b000110000000;
//begin testing
initial begin
$display("Binary Input\t\tBCD Output\t\tExpected Output");
$monitor("%b\t\t%b\t\t%b", p,BDCValue, expectedValue);

//use automated test bench to test all possible multiplications
//for(i=6'b000000; i<=6'b000011; i=i+6'b000001)begin
m = 4'b1111;
//for(j=6'b000000; j<=6'b111111; j=j+6'b000001)begin
q=4'b1100;
#5;
//if(p!==expectedValue)begin
//$display("Error when I/P m=%b and q=%b\t\tResult Gotten=%b\t\tExpected Result=%b",m,q,p,expectedValue);
//$stop;
//end
//#20;
//end
end





endmodule