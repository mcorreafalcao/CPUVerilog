
initial begin
  assign Q = 4'd0;//estado inicial, só fará algo a partir do proximo estado
end

module CONTROLE(Q,tx,ty,tz,tula,clock); //maquina de estado
  parameter CLEAR = 4'd0;
  parameter LOAD = 4'd1;
  parameter HOLD = 4'd2;
  parameter SHIFTR = 4'd3;
  input clock;
  input reg [3:0] Q;
  output reg [3:0] tx,ty,tz,tula;
  
  always @ (posedge clock) begin
    case(Q) 
    4'd0 : begin
              Q <= 4'd1;//1o estado util
              //TX=1 TY=0 TZ=0 TULA=0
              tx<=LOAD;
              ty<=CLEAR;
              tz<=CLEAR;
              tula<=4'd0;
          end
    4'd1 : begin
              Q <= 4'd2;//2o estado util
              //TX=1 TY=1 TZ=0 TULA=0
              tx<=LOAD;
              ty<=LOAD;
              tz<=CLEAR;
              tula<=4'd0;
          end 
    4'd2 : begin
              Q <= 4'd3;//3o estado util
              //TX=0 TY=1 TZ=0 TULA=0
              tx<=CLEAR;
              ty<=LOAD;
              tz<=CLEAR;
              tula<=4'd0;
          end 
    4'd3 : begin
            Q <= 4'd4;//4o estado util
            //TX=0 TY=3 TZ=0 TULA=0
            tx<=CLEAR;
            ty<=SHIFTR;
            tz<=CLEAR;
            tula<=4'd0;
          end 
    4'd4 : begin
            Q <= 4'd5;//5o estado util
            //TX=0 TY=0 TZ=1 TULA=0
            tx<=CLEAR;
            ty<=CLEAR;
            tz<=LOAD;
            tula<=4'd0;
          end 
    4'd5 : begin
            Q <= 4'd1;//volta pro primeiro 1o estado util(recomeça tudo)
            //TX=1 TY=0 TZ=0 TULA=0
            tx<=LOAD;
            ty<=LOAD;
            tz<=CLEAR;
            tula<=4'd0;
          end 
    

endmodule