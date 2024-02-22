module div_clock (
  input clk, 
  input reset,
  output reg [14:0] count 
);

  reg [14:0] next_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
     
      count <= 15'b000000000000000;
    end else begin
      
      count <= next_count;
    end
  end

  always @* begin
    
    if (count == 15'b111111111111111) begin
      next_count = 15'b000000000000000; 
    end else begin
      next_count = count + 1; 
    end
  end

endmodule