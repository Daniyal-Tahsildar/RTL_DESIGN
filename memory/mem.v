module mem (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [3:0] rd_addr,
    input [3:0] wr_addr,
    input [3:0] data_in,
    output wire [3:0] data_out
);

reg [3:0] ram [0:15];
reg [3:0] out_r;

assign data_out = out_r;

always @ (posedge clk or posedge rst) begin
    if (rst)begin
        out_r = 4'b0000;
    end
    else begin
        if (wr_en && !rd_en) begin
            ram[wr_addr] <= data_in;
        end
        else if (rd_en && !wr_en)begin
            out_r <= ram[rd_addr];
        end
        else if (rd_en && wr_en) begin
            ram[wr_addr] <= data_in;
            out_r <= ram[rd_addr];
        end
        else 
        out_r <= out_r;
    end
end
endmodule