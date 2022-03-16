module shift_and_add_multiplier
  #(parameter n = 16) (A, B, ,P);
  input [n - 1: 0] A;
  input [n - 1: 0] B;
  reg [2 * n - 1: 0] X;
  reg [2 * n - 1: 0] Y;
  output [2 * n - 1: 0] P;
  integer i;

  always @ (*)
  begin
    X = 0;
    for (i = 0; i < n; i = i + 1)
    begin
      Y = 0;
      if (B[i] == 1)
        Y = A;
      else
        Y = 0;

      Y = Y << i;
      X = X + Y;
    end
  end
  assign P = X;
endmodule



/*
another implementation
module shift_and_add_multiplier
  #(parameter n = 16) (A, B, control, clk,P);
  input [n - 1: 0] A;
  input [n - 1: 0] B;
  reg [n - 1: 0] X;
  reg [2 * n - 1: 0] Y;
  output reg [2 * n - 1: 0] P;
  input control, clk;
 
  always @ (posedge clk)
  begin
    case (control)
      1'b0:
      begin
        X = A;
        Y[2 * n - 1: n] = 0;
        Y[n - 1: 0] = B;
      end
      1'b1:
      begin
        if (Y[0] == 1)
        begin
          Y[2 * n - 1: n] = Y[2 * n - 1: n] + X;
        end
        Y = Y >> 1;
 
      end
    endcase
    P = Y;
  end
endmodule
 
*/
