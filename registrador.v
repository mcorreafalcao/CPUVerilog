module registrador(in, clock, S, out);

	input wire [3:0] in;
	input wire clock;
	input wire [3:0] S;
	output reg [3:0] out;

	parameter

	HOLD = 4'd1, LOAD = 4'd2, CLEAR = 4'd3, SHIFT = 4'd4;

	always @ (posedge clock)

	begin
		case(S)
		LOAD: out <= in;
		CLR: out <= 4'b0000;
		SHIFT: out <= out >> 1;
		endcase
	end
endmodule
