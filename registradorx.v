module REGISTRADORx(entrada,barramentodados,tx,clock);//barramento de dados
    input wire clock;
    input wire [3:0] entrada,tx;
    output reg [3:0] barramentodados;
    
    parameter CLEAR = 4'd0;
    parameter LOAD = 4'd1;
    parameter HOLD = 4'd2;
    parameter SHIFTR = 4'd3;
    
    always @(posedge clock) begin
        case(tx)
            CLEAR: barramentodados<=4'd0;
            LOAD: barramentodados<=entrada;
            //hold n faz nada
        endcase
    end
endmodule


