module memoria(clock, address, In, Out, S);

	input S, clock;
	input [3:0] In;
	input [3:0] address;
	output reg [3:0] Out;
    
    reg [7:0] memoria [28:0];
    
    initial
		begin
			memoria[0] = FALTAVERQUALÉEPOR;
			memoria[1] = FALTAVERQUALÉEPOR;
			memoria[2] = FALTAVERQUALÉEPOR;
			memoria[3] = FALTAVERQUALÉEPOR;
			memoria[4] = FALTAVERQUALÉEPOR;
			memoria[5] = FALTAVERQUALÉEPOR;
		end

    always @(posedge clock) begin
       if (S) begin
           memoria[address] <= In;
       end
       Out <= memoria[address];
    end
endmodule
