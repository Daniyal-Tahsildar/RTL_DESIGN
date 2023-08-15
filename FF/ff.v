module flop (
    input clk,
    input rst,
    input en,
    input [3:0] in,
    output reg [3:0] out
);

always @(posedge clk or posedge rst) begin
    if (rst)begin
        out <= 4'b0000;
    end
    else begin
        if (en)
            out <= in;
        else
            out <= out;
    end
end
endmodule