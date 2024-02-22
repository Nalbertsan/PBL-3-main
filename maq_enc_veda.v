module maq_enc_veda (
    input clk,       // Sinal de clock
    input reset,   // Sinal de reset ativo baixo
    input PG, CH, RO,
    output GC,        // Saída Garrafa completa
    output EV,        // Saída válvula de enchimento
    output VE,         // Saída válvula de vedação
	 output [2:0] tipo
);

// Parâmetros de estados
parameter SEM_GARRAFA = 3'b000;
parameter GARRAFA_VAZIA = 3'b001;
parameter GARRAFA_CHEIA = 3'b010;
parameter GARRAFA_CHEIA_VEDADA = 3'b011;

// Declaração de estados
reg [2:0] current_state, next_state;

// Lógica de estado

always @ ( posedge clk , posedge
reset ) begin
    if (reset) begin
        current_state <= SEM_GARRAFA; // Estado inicial
    end 
	 else begin
        current_state <= next_state; // Atualiza o estado atual
    end
end


// Próximo estado
always @* begin
    case (current_state)
        SEM_GARRAFA: begin
            if (PG && !CH) begin
                next_state = GARRAFA_VAZIA;
            end else begin
                next_state = SEM_GARRAFA;
            end
        end
        
        GARRAFA_VAZIA: begin
            if (!PG) begin
                next_state = SEM_GARRAFA;
            end else if (PG && CH) begin
                next_state = GARRAFA_CHEIA;
            end else begin
                next_state = GARRAFA_VAZIA;
            end
        end
        
        GARRAFA_CHEIA: begin
            if (!PG) begin
                next_state = SEM_GARRAFA;
            end else if (PG && RO ) begin
                next_state = GARRAFA_CHEIA_VEDADA;
            end else begin
                next_state = GARRAFA_CHEIA;
            end
        end
        
        GARRAFA_CHEIA_VEDADA: begin
            if (!PG) begin
                next_state = SEM_GARRAFA;
            end else begin
                next_state = GARRAFA_CHEIA_VEDADA;
            end
        end
		  default: next_state = SEM_GARRAFA;
    endcase
end

// Saídas GC, EV e VE
assign GC = (current_state == GARRAFA_CHEIA_VEDADA) ? 1 : 0;
assign EV = (current_state == GARRAFA_CHEIA) ? 1 : 0;
assign VE = (current_state == GARRAFA_CHEIA_VEDADA) ? 1 : 0;
assign tipo = current_state;

endmodule
