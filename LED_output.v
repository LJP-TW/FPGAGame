module LED_output(input clk, 
						input blinClock,
						input [1:0] state,
						input [11:0] combo, 
						input [31:0] random,
						output reg [9:0] LED);
	reg [9:0] blin;
		
	always@ (posedge blinClock)
	begin
		blin <= random[20:11];
	end
						
	always@(posedge clk) begin
		if(state == 0) begin
				LED <= blin;
		end
		else if (state == 1) begin
			case(combo)
				0:
				begin
					LED[9:0] <= 10'b0000000000;
				end
				1:
				begin
					LED[0] <= 1'b1;
					LED[9:1] <= 9'b000000000;
				end
				2:
				begin
					LED[1:0] <= 2'b11;
					LED[9:2] <= 8'b00000000;
				end
				3:
				begin
					LED[2:0] <= 3'b111;
					LED[9:3] <= 7'b0000000;
				end
				4:
				begin
					LED[3:0] <= 4'b1111;
					LED[9:4] <= 6'b000000;
				end
				5:
				begin
					LED[4:0] <= 5'b11111;
					LED[9:5] <= 5'b00000;
				end
				6:
				begin
					LED[5:0] <= 6'b111111;
					LED[9:6] <= 4'b0000;
				end
				7:
				begin
					LED[6:0] <= 7'b1111111;
					LED[9:7] <= 3'b000;
				end
				8:
				begin
					LED[7:0] <= 8'b11111111;
					LED[9:8] <= 2'b00;
				end
				9:
				begin
					LED[8:0] <= 9'b111111111;
					LED[9] <= 1'b0;
				end
				10:
				begin
					LED[9:0] <= 10'b1111111111;
				end
				default:
				begin
					LED <= blin;
				end
			endcase
		end
		else begin
			// STOP
			LED[9:0] <= LED[9:0];
		end
	end
endmodule