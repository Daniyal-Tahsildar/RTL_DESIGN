module count_new (
    input clk,
    input rst,
    input en,
    input load,
    input up_down,
    input [3:0] cin,
    output  wire [3:0] cout
);

reg [3:0] out;

assign cout = out;

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        out <= 4'b0000;
        
    end
    else begin
        
        if (en) begin
            if (load) begin
                out <= cin;
            end
            else if (up_down) begin // count up
                        if (out == 4'd1111) begin
                            out <= 4'b0000;
                        end
                        else begin
                            
                                out <= out + 1'b1;
                            end
            end
                //end
            else begin //count down
                   
                        if (out == 4'b0000) begin
                            out <= 4'b1111;
                        end
                        else begin
                                out <= out - 1'b1;  
                            
                            end
            end
        end
                //end
        else begin
            out <= out;
        end
    end
end

endmodule