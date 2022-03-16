module four_bit_adder(A, B, Cin, Cout, S);
	input [3:0] A, B;
	input Cin;	
	output Cout;
	output [3:0] S;
	wire [2:0] C;
	full_adder FA1(.A(A[0]), .B(B[0]), .Cin(Cin),  .Cout(C[0]), .S(S[0]));
	full_adder FA2(.A(A[1]), .B(B[1]), .Cin(C[0]), .Cout(C[1]), .S(S[1]));
	full_adder FA3(.A(A[2]), .B(B[2]), .Cin(C[1]), .Cout(C[2]), .S(S[2]));
	full_adder FA4(.A(A[3]), .B(B[3]), .Cin(C[2]), .Cout(Cout), .S(S[3]));
endmodule
