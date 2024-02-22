module debouncer(B, clk, rstn, out);
	input clk, rstn, B; 
	output out;
	
	wire 	T0, T1, T2, T3;

	d_ff d0 ( .d(B), // SAIDA 25MHZ
		.rstn(rstn),
		.clk(clk),
		.q(T0)
	);
	
	
	d_ff d1 ( .d(T0), //SAIDA 12,5MHZ
		.rstn(rstn),
		.clk(clk),
		.q(T1)
	);
	
	
	d_ff d2 ( .d(T1), //SAIDA 6,25MHZ
		.rstn(rstn),
		.clk(clk),
		.q(T2)
	);
	
	
	and (T3, T0 ,T1);
	and (out, T2, T3);

endmodule