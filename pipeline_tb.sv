module pipeline (
	input logic clk, reset, enable, 
	input logic [7:0] data_in,
	output logic [7:0] stage1, stage2
); 
	always_ff @(posedge clk) begin 
		if (reset) begin 
			stage1 <= 0; 
			stage2 <= 0; 
		end
		else if (enable) begin
			stage1 <= data_in; 
			stage2 <= stage1; 
		end
	end
endmodule

module pipeline_tb; 
	timeunit 1ns; 
	timeprecision 1ps; 

	logic clk = 0; 
	logic reset = 1; 
	logic enable = 0; 
	logic [7:0] data_in = 0;
	logic [7:0] stage1, stage2; 

	pipeline dut (
		.clk(clk), .reset(reset), .enable(enable), .data_in(data_in), .stage1(stage1), .stage2(stage2)
	); 

	always #5 clk = ~clk; 
	initial begin 
		#10; 
		if (stage1 !== 0 || stage2 !== 0) 
			$fatal(1, "Reset failed"); 
		
		reset = 0; enable = 1; data_in = 20; 
		#10; 
		if (stage1 !== 20 || stage2 !== 0)
			$fatal(1, "First transfer failed"); 

		data_in = 40; 
		#10; 
		if (stage1 !== 40 || stage2 !== 20) 
			$fatal(1, "Second transfer failed"); 

		enable = 0; data_in = 99; 
		#10;
		if (stage1 !== 40 || stage2 !== 20) 
			$fatal(1, "Hold failed"); 
	
		$display("PASS: reset, transfer, hold"); 
		$finish; 

	end
endmodule
