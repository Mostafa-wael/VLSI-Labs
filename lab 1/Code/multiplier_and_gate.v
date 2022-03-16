module multiplier_and_gate(A, B, X);
	input [3:0] A;
	input B;
	output reg [3:0] X;
	integer i;	
	always @(A or B)
	begin
		for (i = 0; i < 4; i = i + 1)
		begin
			X[i] <= A[i] & B;
		end
	end
endmodule
