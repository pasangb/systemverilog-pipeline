module pipeline (
	input logic clk, 
	input logic reset, 
	input logic enable, 
	input logic [7:0] data_in, 
	output logic [7:0] stage1,
	output logic [7:0] stage2
); 

	always_ff @(posedge clk) begin 
		if (reset) begin
			stage1 <= 8'b0; 
			stage2 <= 8'b0; 
		end
		else if (enable) begin 
			stage1 <= data_in; 
			stage2 <= stage1; 
		end 
	end
endmodule

