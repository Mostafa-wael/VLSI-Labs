module multiplier(A, B, P);
	input [3:0] A, B;
	output [7:0] P;
	wire [3:0] S_a1, S_a2, S_a3, A_a1, B_a1, B_a2, B_a3;
	wire Cout_a1, Cout_a2, Cout_a3;


	multiplier_and_gate g1(.A(A), .B(B[0]), .X(A_a1)); 
	multiplier_and_gate g2(.A(A), .B(B[1]), .X(B_a1));
	multiplier_and_gate g3(.A(A), .B(B[2]), .X(B_a2)); 
	multiplier_and_gate g4(.A(A), .B(B[3]), .X(B_a3)); 

	four_bit_adder a1(.A({1'b0, A_a1[3:1]}), .B(B_a1), .Cin(1'b0), .Cout(Cout_a1), .S(S_a1));
	four_bit_adder a2(.A({Cout_a1, S_a1[3:1]}), .B(B_a2), .Cin(1'b0), .Cout(Cout_a2), .S(S_a2));
	four_bit_adder a3(.A({Cout_a2, S_a2[3:1]}), .B(B_a3), .Cin(1'b0), .Cout(Cout_a3), .S(S_a3));

	assign P[0] = A_a1[0];
	assign P[1] = S_a1[0];
	assign P[2] = S_a2[0];
	assign P[6:3] = S_a3;
	assign P[7] = Cout_a3;
endmodule