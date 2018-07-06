module registrador(in, clock, S, out);

	input wire [3:0] in;
	input wire clock;
	input wire [3:0] S;
	output reg [3:0] out;

	parameter

	HOLD = 4'b0000, LOAD = 4'b0001, CLEAR = 4'b0010, SHIFT = 4'b0011;

	always @ (posedge clock)

	begin
		case(S)
		LOAD: out <= in;
		CLR: out <= 4'b0000;
		SHIFT: out <= out >> 1;
		endcase
	end
endmodule
