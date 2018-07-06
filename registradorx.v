module REGISTRADORx(entrada,barramentodados,tx,clock);//barramento de dados
    input wire clock;
    input wire [3:0] entrada,tx;
    output reg [3:0] barramentodados;
    
    parameter CLEAR = 4'd0;
    parameter LOAD = 4'd1;
    parameter HOLD = 4'd2;
    parameter SHIFTR = 4'd3;
    
    always @(tx,posedge clock) begin
        case(tx)
            CLEAR: barramentodados<=4'd0;
            LOAD: barramentodados<=entrada;
            //hold n faz nada
        endcase
    end



endmodule

module REGISTRADORy (barramentodados,ty,tula,clock);//acumulador
    input wire clock;
    input wire [3:0] barramentodados,tula,ty;
    output reg [3:0] acumulador;

    parameter CLEAR = 4'd0;
    parameter LOAD = 4'd1;
    parameter HOLD = 4'd2;
    parameter SHIFTR = 4'd3;

    always@(ty,posedge clock)begin
        case (ty)
            CLEAR: acumulador<=4'd0;
            LOAD: begin
                if(tula==4'd0) begin
                    acumulador<=acumulador+barramentodados;//y=y+x se tula = 0000
                end
            end
            SHIFTR:acumulador >> 1;
            endcase
    end

endmodule

module REGISTRADORz(acumulador,tz,clock);
    input wire clock;
    input wire [3:0] acumulador,tz;
    output reg [3:0] saida;

    parameter CLEAR = 4'd0;
    parameter LOAD = 4'd1;
    parameter HOLD = 4'd2;


    always @(tx,posedge clock) begin
        case(tx)
            CLEAR: saida<=4'd0;
            LOAD: saida<=acumulador;
            //hold n faz nada
        endcase
    end
endmodule