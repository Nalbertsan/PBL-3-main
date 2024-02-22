module maq_esteira(
	input clk,
   input reset,
	input ST, PG,
	output M
);

// Parâmetros para os estados
parameter STOPPED = 2'b00;
parameter MOVING = 2'b01;

// Registrador de estado
reg [1:0] current_state, next_state;

// Atualização do estado
always @ ( posedge clk , posedge
reset ) begin
    if ( reset ) current_state <= STOPPED ;
    else current_state <= next_state ;
end

// Lógica do próximo estado
always @(posedge clk) begin
	case(current_state)
    	STOPPED: begin
			if (ST && !PG)
            	next_state = MOVING;
        	else
            	next_state = STOPPED;
    	end
    	MOVING: begin

   		if (ST && !PG)
            	next_state = MOVING;
        	else
            	next_state = STOPPED;
    	end
    	default: next_state = STOPPED;
	endcase
end



// Lógica de saída
assign M = (current_state == MOVING);

endmodule
