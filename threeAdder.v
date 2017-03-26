module threeAdder(
input [3:0] intake,
output reg [3:0] returns
//reg [3:0] return
);
always begin
	case (intake)
	4'b0000: returns = 4'b0000;
	4'b0001: returns = 4'b0001;
	4'b0010: returns = 4'b0010;
	4'b0011: returns = 4'b0011;
	4'b0100: returns = 4'b0100;
	4'b0101: returns = 4'b1000; //0011 added
	4'b0110: returns = 4'b1001; //0011 added
	4'b0111: returns = 4'b1010; //0011 added
	4'b1000: returns = 4'b1011; //0011 added
	4'b1001: returns = 4'b1100; //0011 added
	default: returns = 4'b0000; //0011 added
	endcase
	end
endmodule