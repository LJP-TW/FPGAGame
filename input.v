module Input(enter, speed, stop, enter_out, speed_out, stop_out, clk);

	input [2:0]enter, speed;
	input stop, clk;
	output [2:0]enter_out, speed_out;
	output stop_out;
	
	assign stop_out = stop;
	assign speed_out = speed;
	
	button_debouncer bd_enter0(clk, 1, ~enter[0], enter_out[0]);
	button_debouncer bd_enter1(clk, 1, ~enter[1], enter_out[1]);
	button_debouncer bd_enter2(clk, 1, ~enter[2], enter_out[2]);

endmodule