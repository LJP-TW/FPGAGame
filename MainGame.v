`timescale 10ns/1ns
module MainGame(input [1:0] state,
					 input [2:0] enter,
					 input gameClock,
					 input sysClock,
					 input [31:0] random,
					 output reg [31:0] number,
					 output reg [11:0] cord,
					 output reg [11:0] Combo);
		//sysClock =>1Mhz
		parameter _timer_thresh = 1000000 - 1;

		integer score;
		integer timer;
		integer _timer; // _timer_accumulator;
		
		reg _display; // 1 -> score  , 0 -> time;
		reg [2:0] enterPrev;
		reg detector;
		reg detectorPrev;
		reg wrong;
		
		initial 
		begin
		//Initialize Variables
			score = 0;
			timer = 0;
			_timer = 0;
			_display = 1'b1;
			enterPrev = 3'b000;
			detector = 1'b0;
			detectorPrev = 1'b0;
			wrong = 0;

		//Initialize Output
			number = 0;
			cord = 0;
			Combo = 0;
		end
		

		always@(posedge sysClock)
		begin
			case(state)
			0:
			begin				
			//GameReset
					//Initialize Variables
					score <= 0;
					timer <= 0;
					_timer <= 0;
					_display <= 1'b1;
					enterPrev <= 3'b000;
					detectorPrev = 1'b0;
					wrong <= 0;

					//Initialize Output
					number <= 0;
					Combo <= 0;
					cord <= 0 ;
			end
			1:
			begin
			if(timer < 60)
			begin
				//Game HIT
             if (enterPrev != enter && wrong == 1'b0) begin
                 enterPrev <= enter;
                 if(enter[0] != cord[0] || 
                     enter[1] != cord[1] ||
                      enter[2] != cord[2])
                 begin
                     wrong <= 1;
                 end
                 else begin
                     cord[0] = 0;
                     cord[1] = 0;
                     cord[2] = 0;
                 end
             end

				if(detectorPrev != detector)
				begin
					if(wrong == 0 && cord[0] == 0 && cord[1] == 0 && cord[2] == 0) begin
						score <= score + 1;
						Combo <= Combo + 1;	
					end
					else begin
						Combo <= 0;
					end
					cord[8:0] = cord[11:3];
					cord[11:9] = random[15:13];
					wrong <= 0;
					detectorPrev <= detector;
				end			
					
					
				//GameTime
				if(_timer == _timer_thresh)begin					
					timer = timer + 1;
					_timer = 0;
				end
				else begin
					_timer <= _timer + 1;						
				end

			end
			end
			2:
			begin
				//GameToggle
				if(enterPrev != enter && enter[2]==1)
				begin
					_display <= !_display;
				end
				
				
				if(_display)number <= score;
				else number <= timer;
			end
			default:;
			endcase
			enterPrev <= enter;
		end
		
		always @(posedge gameClock) begin
			case(state)
			1:
			begin
			detector <= !detector;
			end
			default:;
			endcase
		end
endmodule