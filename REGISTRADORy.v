module REGISTRADORy (acumulador,barramentodados,ty,tula,clock);//acumulador
    input wire clock;
    input wire [3:0] barramentodados,tula,ty;
    output reg [3:0] acumulador;

    parameter CLEAR = 4'd0;
    parameter LOAD = 4'd1;
    parameter HOLD = 4'd2;
    parameter SHIFTR = 4'd3;

    always@(posedge clock)begin
        case (ty)
            CLEAR: acumulador<=4'd0;
            LOAD: begin
                if(tula==4'd0) begin
                    acumulador<=acumulador+barramentodados;//y=y+x se tula = 0000
                end
            end
            SHIFTR:acumulador <= acumulador >> 1;
            endcase
    end

endmodule