module GameClock(speed, enable, in_clk, out_clk);
	input enable, in_clk;
	input [2:0] speed;
	reg [31:0] counter;
	output reg out_clk;
	parameter counter_max_level1 = 10_000_000;
	parameter counter_max_level2 = 15_000_000;
	parameter counter_max_level3 = 20_000_000;
	parameter counter_max_level4 = 25_000_000;
	integer counter_max_now;
	
	always@(posedge in_clk) begin
		if(~enable) begin
			if(speed[0]) begin
				counter_max_now <= counter_max_level1;
				counter <= counter_max_level1;
			end
			else if(speed[1]) begin
				counter_max_now <= counter_max_level2;
				counter <= counter_max_level2;
			end
			else if(speed[2]) begin
				counter_max_now <= counter_max_level3;
				counter <= counter_max_level3;
			end
			else begin
				counter_max_now <= counter_max_level4;
				counter <= counter_max_level4;
			end
		end
		else begin
			if (counter == 0) begin
				counter <= counter_max_now;
				out_clk <= !out_clk;
			end
			else
				counter <= counter - 1;
		end
	end
endmodule