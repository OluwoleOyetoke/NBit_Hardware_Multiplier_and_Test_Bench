`timescale 1ns/1ns
//module declaration
module fourByFourMultiplier(
input [3:0] q,
input [3:0] m,
output [7:0] p,
//should be filled with all zeros initally
//Double Dabble used for the Binary to BCD Conversion

output [6:0] HEX0,
output [6:0] HEX1,
output [6:0] HEX2
);

reg [11:0] doubleDabble;
reg [11:0] temporaryDoubleDabbleValue2;
wire [7:0] pReg; //temporary register for output p values

wire [4:0] row1ModuleOutputs; //1 additional output added and will be equated to carrout
wire [3:0] row1ModuleMOutputs; //the diagonal outputs

wire [4:0] row2ModuleOutputs; //1 extra space where PPI bit is stored
wire [3:0] row2ModuleMOutputs; //the diagonal outputs

wire [4:0] row3ModuleOutputs; //1 extra space where PPI bit is stored
wire [3:0] row3ModuleMOutputs; //the diagonal outputs

wire [4:0] row1Cin;
wire [4:0] row2Cin;
wire [4:0] row3Cin;

wire [4:0] dummym;

assign dummym = {1'b0, m}; //concatenate to add the dummy MSB = 0;
assign p[0] = m[0] & q[0];
assign row1Cin[0] = 0; //make initial cin=0;
assign row2Cin[0] = 0; //make initial cin=0;
assign row3Cin[0] = 0; //make initial cin=0;

integer t; //for Binary to BCD Conversion For Loop

genvar i, j, k;

generate
for(i=0; i<4; i=i+1) begin:row1
Submodule_1 Inst( 
.inputMs({dummym[i+1],dummym[i]}),
.inputQs({q[1],q[0]}),
.moduleOutput(row1ModuleOutputs[i]),
.cin(row1Cin[i]),
.cout(row1Cin[i+1]),
.outputM(row1ModuleMOutputs[i])
);
end

assign row1ModuleOutputs[4] = row1Cin[4];

for(j=0; j<4; j=j+1) begin:row2
Submodule_2 Inst2( 
.inputM(row1ModuleMOutputs[j]),
.inputQ(q[2]),
.bitsOfPPI(row1ModuleOutputs[j+1]),
.cin(row2Cin[j]),
.moduleOutput(row2ModuleOutputs[j]),
.cout(row2Cin[j+1]),
.outputM(row2ModuleMOutputs[j])
);
end

assign row2ModuleOutputs[4] = row2Cin[4];

for(k=0; k<4; k=k+1) begin:row3
Submodule_2 Inst3( 
.inputM(row2ModuleMOutputs[k]),
.inputQ(q[3]),
.bitsOfPPI(row2ModuleOutputs[k+1]),
.cin(row3Cin[k]),
.moduleOutput(row3ModuleOutputs[k]),
.cout(row3Cin[k+1]),
.outputM(row3ModuleMOutputs[k])
);
end

assign row3ModuleOutputs[4] = row3Cin[4];

endgenerate

assign p[1] = row1ModuleOutputs[0];
assign p[2] = row2ModuleOutputs[0];
assign p[3] = row3ModuleOutputs[0];
assign p[4] = row3ModuleOutputs[1];
assign p[5] = row3ModuleOutputs[2];
assign p[6] = row3ModuleOutputs[3];
assign p[7] = row3Cin[4]; //cin[4] serves as carryout

assign pReg = p; //Assign p output values to the temporary register

//Drive multiplication result to show on HEX
sevenSegmentDriver HEXZero( 
.intake(doubleDabble[3:0]),
.sevenSegmentValue(HEX0)
);
sevenSegmentDriver HEXOne( 
.intake(doubleDabble[7:4]),
.sevenSegmentValue(HEX1)
);
sevenSegmentDriver HEXTwo( 
.intake(doubleDabble[11:8]),
.sevenSegmentValue(HEX2)
);

//BCD to Binary Happens here 
reg [3:0] units;
reg [3:0] tens;
reg [3:0] hundreds;
always @ (m or q) begin

temporaryDoubleDabbleValue2 = 12'b000000000000; //fill double dable bits with initial zeros
#5;
for(t=4'b0000; t<=4'b0111; t=t+4'b0001) begin
temporaryDoubleDabbleValue2 = temporaryDoubleDabbleValue2<<1; //shift leftwards once
#5;
temporaryDoubleDabbleValue2[0] = pReg[4'b0111-t]; //bring in the next MSB from p
units = temporaryDoubleDabbleValue2[3:0];
tens = temporaryDoubleDabbleValue2[7:4];
hundreds = temporaryDoubleDabbleValue2[11:8];
#20;
temporaryDoubleDabbleValue2 = {hundreds, tens, units};
end
doubleDabble = temporaryDoubleDabbleValue2;
end

always begin
	case (units)
	4'b0000: units <= 4'b0000;
	4'b0001: units <= 4'b0001;
	4'b0010: units <= 4'b0010;
	4'b0011: units <= 4'b0011;
	4'b0100: units <= 4'b0100;
	4'b0101: units <= 4'b1000; //0011 added
	4'b0110: units <= 4'b1001; //0011 added
	4'b0111: units <= 4'b1010; //0011 added
	4'b1000: units <= 4'b1011; //0011 added
	4'b1001: units <= 4'b1100; //0011 added
	default: units <= 4'b0000; //0011 added
	endcase
	#20;
	end
	
	always begin
	case (tens)
	4'b0000: tens <= 4'b0000;
	4'b0001: tens <= 4'b0001;
	4'b0010: tens <= 4'b0010;
	4'b0011: tens <= 4'b0011;
	4'b0100: tens <= 4'b0100;
	4'b0101: tens <= 4'b1000; //0011 added
	4'b0110: tens <= 4'b1001; //0011 added
	4'b0111: tens <= 4'b1010; //0011 added
	4'b1000: tens <= 4'b1011; //0011 added
	4'b1001: tens <= 4'b1100; //0011 added
	default: tens <= 4'b0000; //0011 added
	endcase
	#20;
	end

	always begin
	case (hundreds)
	4'b0000: hundreds <= 4'b0000;
	4'b0001: hundreds <= 4'b0001;
	4'b0010: hundreds <= 4'b0010;
	4'b0011: hundreds <= 4'b0011;
	4'b0100: hundreds <= 4'b0100;
	4'b0101: hundreds <= 4'b1000; //0011 added
	4'b0110: hundreds <= 4'b1001; //0011 added
	4'b0111: hundreds <= 4'b1010; //0011 added
	4'b1000: hundreds <= 4'b1011; //0011 added
	4'b1001: hundreds <= 4'b1100; //0011 added
	default: hundreds <= 4'b0000; //0011 added
	endcase
	#20;
	end
endmodule 