module full_adder(A, B, Cin, Cout, S);
	input A, B, Cin;
	output Cout, S;
	wire C1, C2, S1;
	half_adder adder_1(.A(A), .B(B), .C(C1), .S(S1));
	half_adder adder_2(.A(Cin), .B(S1), .C(C2), .S(S));
	assign Cout = C1 | C2;
endmodule

module multiplier_AND_gate #(parameter n = 16)(A, B, X);
	input [n - 1:0] A;
	input B;
	output reg [n - 1:0] X;
	integer i;	
	always @(A or B)
	begin
		for (i = 0; i < n; i = i + 1)
		begin
			X[i] <= A[i] & B;
		end
	end
endmodule

module half_adder(A, B, C, S);
	input A, B;
	output C, S;
	assign C = A & B; 
	assign S = A ^ B;
endmodule



module array_multiplier #(parameter n = 16) (A, B, P);
  input [n - 1: 0] A;
  input [n - 1: 0] B;
  output reg [2 * n - 1: 0] P;
  genvar i, j;
  integer k;
  wire [n - 1: 0] AND_result_vectors [n - 1: 0];
  wire [n - 2: 0] carry_out_vectors [n - 1: 0];
  wire [n - 2: 0] sum_vectors[n - 1: 0];

  for (i = 0; i < n; i = i + 1)
  begin
    multiplier_AND_gate #(.n(n)) and_gate (
                          .A(A),
                          .B(B[i]),
                          .X(AND_result_vectors[i])
                        );
  end

  for (i = 0; i < n - 1; i = i + 1)
  begin
    half_adder ha (
                 .A(AND_result_vectors[0][i + 1]),
                 .B(AND_result_vectors[1][i]),
                 .C(carry_out_vectors[0][i]),
                 .S(sum_vectors[0][i])
               );
  end

  for (j = 0; j < n - 2; j = j + 1)
  begin
    for (i = 0; i < n - 2; i = i + 1)
    begin
      full_adder fa (
                   .A(AND_result_vectors[j + 2][i]),
                   .B(sum_vectors[j][i + 1]),
                   .Cin(carry_out_vectors[j][i]),
                   .Cout(carry_out_vectors[j + 1][i]),
                   .S(sum_vectors[j + 1][i])
                 );
    end
    full_adder sfa (
                 .A(AND_result_vectors[j + 2][n - 2]),
                 .B(AND_result_vectors[j + 1][n - 1]),
                 .Cin(carry_out_vectors[j][n - 2]),
                 .Cout(carry_out_vectors[j + 1][n - 2]),
                 .S(sum_vectors[j + 1][n - 2])
               );
  end

  half_adder sha (
               .A(carry_out_vectors[n - 2][0]),
               .B(sum_vectors[n - 2][1]),
               .C(carry_out_vectors[n - 1][0]),
               .S(sum_vectors[n - 1][0])
             );

  for (i = 1; i < n - 2; i = i + 1)
  begin
    full_adder lfa (
                 .A(carry_out_vectors[n - 2][1]),
                 .B(sum_vectors[n - 2][i + 1]),
                 .Cin(carry_out_vectors[n - 1][i]),
                 .Cout(carry_out_vectors[n - 1][i]),
                 .S(sum_vectors[n - 1][i])
               );
  end

  full_adder xfa (
               .A(carry_out_vectors[n - 2][n - 2]),
               .B(AND_result_vectors[n - 1][n - 1]),
               .Cin(carry_out_vectors[n - 1][n - 3]),
               .Cout(carry_out_vectors[n - 1][n - 2]),
               .S(sum_vectors[n - 1][n - 2])
             );


  always @*
  begin
    P[0] <= AND_result_vectors[0][0];
    P[2 * n - 1] <= carry_out_vectors[n - 1][n - 2];
    P[2 * n - 2: n] <= sum_vectors[n - 1][n - 2: 0];
    for (k = 1; k <= n - 1; k = k + 1)
    begin
      P[k] <= sum_vectors[k - 1][0];
    end
  end

endmodule
