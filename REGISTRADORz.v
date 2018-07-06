module REGISTRADORz(saida,acumulador,tz,clock);
    input wire clock;
    input wire [3:0] acumulador,tz;
    output reg [3:0] saida;

    parameter CLEAR = 4'd0;
    parameter LOAD = 4'd1;
    parameter HOLD = 4'd2;


    always @(posedge clock) begin
        case(tx)
            CLEAR: saida<=4'd0;
            LOAD: saida<=acumulador;
            //hold n faz nada
        endcase
    end
endmodule