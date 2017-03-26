`timescale 1ns/1ns
module sevenSegmentDriver( 
input [3:0] intake,
output reg [6:0] sevenSegmentValue
);


always begin
sevenSegmentValue =~7'b0000000;
if(intake==4'b0000) begin //0
sevenSegmentValue =~7'b0111111;
end else if(intake==4'b0001) begin //1
sevenSegmentValue =~7'b0000110;
end else if(intake==4'b0010) begin //2
sevenSegmentValue =~7'b1011011;
end else if(intake==4'b0011) begin //3
sevenSegmentValue =~7'b1001111;
end else if(intake==4'b0100) begin //4
sevenSegmentValue =~7'b1100110;
end else if(intake==4'b0101) begin //5
sevenSegmentValue =~7'b1101101;
end else if(intake==4'b0110) begin //6
sevenSegmentValue =~7'b1111101;
end else if(intake==4'b0111) begin //7
sevenSegmentValue =~7'b0100111;
end else if(intake==4'b1000) begin //8
sevenSegmentValue =~7'b1111111;
end else if(intake==4'b1001) begin //9
sevenSegmentValue =~7'b1101111;
end else begin
sevenSegmentValue =~7'b0111111;
end
#20; //time delay
end //end for the always block

endmodule
