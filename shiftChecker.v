module shiftChecker( 
input [3:0]  units, 
input [3:0]  tens,
input [3:0] hundreds,
output reg [11:0] takeBack
);

wire [11:0] returns;

always begin
takeBack = returns;
end
//wire [11:0] returns;
threeAdder adderUnits( 
.intake(units),
.returns(returns[3:0])
);

threeAdder adderTens( 
.intake(tens),
.returns(returns[7:4])
);
threeAdder adderHundreds( 
.intake(hundreds),
.returns(returns[11:8])
);


endmodule
