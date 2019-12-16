module control (enter, speed, stop, clk, state, enter_out, speed_out, speed_enable);
	//clk = 1Mhz
	input stop, clk;
	input [2:0] enter, speed;
	output reg speed_enable;
	output reg [2:0] enter_out, speed_out;
	output reg [1:0] state;
	
	//Enter Button
	reg[2:0] prev_enter;
	integer holded;
	parameter _hold_thresh = 30000; //hold enter for 50ms will trigger enter_out

	initial
	begin
		holded = 0;	
		prev_enter = 3'b000;
		speed_enable = 0;
		enter_out  = 0;
		speed_out = 0;
		state = 0;
	end

	always@(posedge clk) begin
		//Button Trigger
		if(prev_enter != enter)
		begin
			holded <= 0;
			prev_enter <= enter;
		end
		else
		begin				
			if(holded >= _hold_thresh)
			begin
			enter_out <= enter;
			holded <= 0;
			end
			else begin
				holded <= holded + 1;
			end
			
		end

		
		
		case(state)
			0:
			begin
				speed_enable <= 0;
				speed_out <= speed;
				
				if(enter_out == 3'b111)
					state <= 1;
			end
			1:
			begin
				speed_enable <= 1;				
				if(stop) state <= 2;
			end
			
			2:
			begin
				speed_enable <= 1;
				
				if(~stop)
					state <= 1;
				else if(enter_out[0])
					state <= 0;
			end
			
			default:
				state <= 0;
		endcase
	end
endmodule