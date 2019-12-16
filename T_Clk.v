module T_Clk(in_clk, out_clk);
	input in_clk;
	output reg out_clk;
	reg counter;
	parameter counter_max = 250;
	
	always@(posedge in_clk) begin
		if (counter == 0) begin
			counter <= counter_max;
			out_clk <= ~out_clk;
		end
		else
			counter <= counter - 1;
	end
endmodule