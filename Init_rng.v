module Init_rng(input clk, output reg reset, output reg loadseed_o, output reg [31:0] seed_o);
reg [2:0] InitState;

initial
begin
	InitState = 3'b0;
	reset = 1;
	loadseed_o = 0;
	seed_o = 32'h12345678;
end

always@(posedge clk)
begin
	case(InitState)
		3'b000:
		begin
			reset <= 0;
			InitState <= InitState + 1'b1;
		end
		3'b010:
		begin
			reset <= 1;
			InitState <= InitState + 1'b1;
		end
		3'b100:
		begin
			loadseed_o <= 1;
			InitState <= InitState + 1'b1;
		end
		3'b110:;
		default:
		begin
			loadseed_o <= 0;
			InitState <= InitState + 1'b1;
		end
	endcase
end
endmodule