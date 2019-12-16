module sysClk(in_clk, out_clk);
	input in_clk;
	output reg out_clk;
	reg [4:0]counter;
	parameter counter_max = 25;
	initial 
	begin
		out_clk = 0;
		counter = counter_max;
	end

	always@(posedge in_clk) begin
		if (counter == 1) begin
			counter <= counter_max;
			out_clk <= !out_clk;
		end
		else begin
			counter <= counter - 1;
		end
	end
endmodule