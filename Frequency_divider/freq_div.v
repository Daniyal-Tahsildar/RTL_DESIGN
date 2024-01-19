module freq_div#(
    parameter N,
    parameter WIDTH = $clog2(N)
)
(
    input clk, rst,
    output new_clk

);

reg out_c, out;

reg [WIDTH-1:0] count;

assign new_clk = out_c | out;

always @(posedge clk) begin
    if(rst) begin
        out_c <= '0;
        count <= '0;
    end
    else begin
        out_c <= count[WIDTH-1];
      if (count == '1 -1'b1) begin
            count <= '0;
        end
        else begin
            count <= count + 1'b1; 
        end
    end
end

always @(negedge clk) begin
    if (rst) begin
        out <= 0;
    end

    else begin
        out <= out_c;
    end
end

endmodule