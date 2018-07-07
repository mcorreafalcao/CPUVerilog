module CONTROLE(Q,tx,ty,tz,tula,clock); //maquina de estado
  
  parameter CLEAR = 4'd0;
  parameter LOAD = 4'd1;
  parameter HOLD = 4'd2;
  parameter SHIFTR = 4'd3;

  input wire clock;
  output reg [3:0] Q,tx,ty,tz,tula;
  
  initial begin
	Q <= 4'd0;//estado inicial, só fará algo a partir do proximo estado
  end
  
  always @ (posedge clock) begin
    case(Q) 
    4'd0 : begin
              Q <= 4'd1;//1o estado util
              //TX=1 TY=0 TZ=0 TULA=0
              tx<=LOAD;
              ty<=CLEAR;
              tz<=CLEAR;
              
          end
    4'd1 : begin
              Q <= 4'd2;//2o estado util
              //TX=1 TY=1 TZ=0 TULA=0
              tx<=LOAD;
              ty<=LOAD;
              tz<=CLEAR;
              
          end 
    4'd2 : begin
              Q <= 4'd3;//3o estado util
              //TX=0 TY=1 TZ=0 TULA=0
              tx<=CLEAR;
              ty<=LOAD;
              tz<=CLEAR;
              
          end 
    4'd3 : begin
            Q <= 4'd4;//4o estado util
            //TX=0 TY=3 TZ=0 TULA=0
            tx<=CLEAR;
            ty<=SHIFTR;
            tz<=CLEAR;
            
          end 
    4'd4 : begin
            Q <= 4'd5;//5o estado util
            //TX=0 TY=0 TZ=1 TULA=0
            tx<=CLEAR;
            ty<=CLEAR;
            tz<=LOAD;
            
          end 
    4'd5 : begin
            Q <= 4'd1;//volta pro primeiro 1o estado util(recomeça tudo)
            //TX=1 TY=0 TZ=0 TULA=0
            tx<=LOAD;
            ty<=LOAD;
            tz<=CLEAR;
            
          end 
    endcase
    tula<=4'd0;//Ula sempre vai somar independente do estado de Q
  end//end always

endmodule

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

module CPU(Q,tx,ty,tz,tula,entrada,barramentodados,acumulador,saida,clock);
    input wire clock;
    input[3:0] entrada;
    output[3:0] saida;
    reg[3:0] Q,tx,ty,tz,tula,acumulador,barramentodados;

    CONTROLE controle(Q,tx,ty,tz,tula,clock);
    REGISTRADORx Rx(entrada,barramentodados,tx,clock);
    REGISTRADORy Ry(acumulador,barramentodados,ty,tula,clock);
    REGISTRADORz Rz(saida,acumulador,tz,clock);
endmodule