module full_adder(A, B, Cin, Cout, S);
	input A, B, Cin;
	output Cout, S;
	wire C1, C2, S1;
	half_adder adder_1(.A(A), .B(B), .C(C1), .S(S1));
	half_adder adder_2(.A(Cin), .B(S1), .C(C2), .S(S));
	assign Cout = C1 | C2;
endmodule
