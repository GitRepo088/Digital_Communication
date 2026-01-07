`timescale 1 ps/ 1 ps
module test_ASK();
	reg clk_50, reset,data;
	reg [31:0] index;
	wire signed [15:0]  sine;
	wire signed [15:0]  ASK;
	reg [7:0] phase;
	
initial
	begin
	//clock initialization
		clk_50 = 1'b0;
		data = 1'b0;
		index  = 32'd0;
	$display("Running testbench");                       
	end                    
always begin
	#10
	clk_50 = !clk_50;
	end
always begin 
	#2000 data = 1;
	#2000 data = 1;
	#2000 data = 0;
	#2000 data = 0;
	end

initial begin
	reset = 1'b0; #10
	reset = 1'b1; #30
	reset = 1'b0;
	end
//increment index
always @(posedge clk_50) begin
	index <= index + 32'd1;
end

ASK_on_FPGA i1(
.clock(clk_50),
.data(data),
.increment({18'h02000, 14'b0}),
.phase(8'd0),
.reset(reset),
.ASK(ASK),
.sine(sine)
);
endmodule
