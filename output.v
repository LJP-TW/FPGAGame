module outputs(input [31:0] time_or_score, 
					input [11:0] chord, 
					input [1:0] state,
					input clk,
					input blinClock,
					input [31:0] random,
					output reg [31:0] seg7
					);
	wire [31:0]wseg7;
	reg [3:0] n0, n1, n2, n3;
	wire [3:0] w0,w1,w2,w3;
	assign w0 = n0;
	assign w1 = n1;
	assign w2 = n2;
	assign w3 = n3;
	reg [31:0] blin;
	
	initial
	begin
		seg7 = 32'hffffffff;
	end
	
	Seg7Decode s0(w0, wseg7[7:0]);
	Seg7Decode s1(w1, wseg7[15:8]);
	Seg7Decode s2(w2, wseg7[23:16]);
	Seg7Decode s3(w3, wseg7[31:24]);
	
	always@ (posedge blinClock)
	begin
		blin <= random;
	end
	
	always@ (posedge clk)
	begin
			if(state == 0) begin
				seg7 <= blin;
			end
			else if(state == 1) begin
				seg7 <= 32'hffffffff;
				seg7[0] <= ~chord[2];
				seg7[6] <= ~chord[1];
				seg7[3] <= ~chord[0];
				seg7[8] <= ~chord[5];
				seg7[14] <= ~chord[4];
				seg7[11] <= ~chord[3];
				seg7[16] <= ~chord[8];
				seg7[22] <= ~chord[7];
				seg7[19] <= ~chord[6];
				seg7[24] <= ~chord[11];
				seg7[30] <= ~chord[10];
				seg7[27] <= ~chord[9];
			end
			else if(state == 2) begin 
				 //t0 = time_or_score%10;
				 n0 <= time_or_score%10;
				 n1 <= (time_or_score%100)/10;
				 n2 <= (time_or_score%1000)/100;
				 n3 <= (time_or_score/1000);
				 seg7 <= wseg7;
			end
	end 
endmodule
