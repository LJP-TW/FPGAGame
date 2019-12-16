module output_Clk(in_clk, out_clk);
	input in_clk;
	output reg out_clk;
	reg [31:0] counter;
	parameter counter_max = 5_000_000;
	
	initial
	begin
		out_clk = 0;
	end
	
	always@(posedge in_clk) begin
		if (counter == 0) begin
			counter <= counter_max;
			out_clk <= !out_clk;
		end
		else
			counter <= counter - 1;
	end
endmodule