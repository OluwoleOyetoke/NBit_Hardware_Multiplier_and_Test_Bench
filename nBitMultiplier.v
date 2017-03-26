//module declaration
module nBitMultiplier #(
parameter WIDTH = 6,
parameter OUTPUTLENGTH = WIDTH*2,
parameter LASTSTAGENUMBER = WIDTH - 2
)

(
input [(WIDTH-1):0] q,
input [(WIDTH-1):0] m,
output [(OUTPUTLENGTH-1):0] p
);


wire [WIDTH:0] stagesModuleOutputs [(WIDTH-2):0]; //2D array declaration if WIDTH=4, itl be a 3by5 matix.//1 extra space where PPI bit is stored
wire [(WIDTH-1):0] stagesModuleMOutputs [(WIDTH-2):0]; //2D array declaration if WIDTH=4, itl be a 3by4 matix. //the diagonal outputs


wire [WIDTH:0] stagesCin [(WIDTH-2):0];

wire [(WIDTH-2):0] stagesFinalCarryOut;

wire [WIDTH:0] dummym;

assign dummym = {1'b0, m}; //concatenate to add the dummy MSB = 0;
assign p[0] = m[0] & q[0];
assign stagesCin[0][0] = 0; //make initial cin=0;


genvar i, j, k, l;

generate
for(i=0; i<WIDTH; i=i+1) begin:row1
Submodule_1 Inst( 
.inputMs({dummym[i+1],dummym[i]}),
.inputQs({q[1],q[0]}),
.moduleOutput(stagesModuleOutputs[0][i]),
.cin(stagesCin[0][i]),
.cout(stagesCin[0][i+1]),
.outputM(stagesModuleMOutputs[0][i])
);

end

assign stagesModuleOutputs[0][WIDTH] = stagesCin[0][WIDTH];
assign p[1] = stagesModuleOutputs[0][0];

//generate the remaining rows
for(j=1; j<(WIDTH-1); j=j+1) begin:allOtherRows
assign stagesCin[j][0] = 0; //set initial cin for all the stages to 0
for(k=0; k<WIDTH; k=k+1) begin:selectedRow
Submodule_2 Inst2( 
.inputM(stagesModuleMOutputs[j-1][k]),
.inputQ(q[j+1]),
.bitsOfPPI(stagesModuleOutputs[j-1][k+1]),
.cin(stagesCin[j][k]),
.moduleOutput(stagesModuleOutputs[j][k]),
.cout(stagesCin[j][k+1]),
.outputM(stagesModuleMOutputs[j][k])
);
end
assign stagesModuleOutputs[j][WIDTH] = stagesCin[j][WIDTH];
assign p[j+1] = stagesModuleOutputs[j][0];
end


//TO FILL IN THE REMAINING VALUES OF P FROM THE MODULE OUTPUT OF THE LAST ROW
for(l=1; l<=WIDTH; l = l+1) begin:fillP
assign p[LASTSTAGENUMBER+l+1] = stagesModuleOutputs[LASTSTAGENUMBER][l];
end
endgenerate

//assign p[OUTPUTLENGTH-1] = stagesCin[LASTSTAGENUMBER][WIDTH];


endmodule 