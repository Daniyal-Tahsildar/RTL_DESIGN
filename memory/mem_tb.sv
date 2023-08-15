`timescale 1 ns / 100 ps;
module mem_tb;
    logic clk = 0;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [3:0] rd_addr;
    logic [3:0] wr_addr;
    logic [3:0] data_in;
    logic [3:0] data_out;
    logic [3:0] data_out_tb;

    logic [3:0] ram[0:15];

    mem DUT (.*);

    initial begin: gen_clk 
        while(1)
        #10 clk  = ~clk;
    end

    initial begin: run_test 
    $timeformat (-9, 0 ,"ns");
        rst = 1'b1;
        wr_en = 1'b0;
        rd_en = 1'b0;
        @(posedge clk)
        rst = 1'b0;
        wr_en = 1'b1;
        for (int i = 0; i < 16; i++) begin
            @(posedge clk);
            wr_addr = i;
            data_in = $random;
            ram[wr_addr] = data_in;
        end
        @(posedge clk);

        wr_en = 1'b0;
        rd_en = 1'b1;
        for (int i = 0; i < 16; i++) begin
            rd_addr = i;
            @(posedge clk);
            data_out_tb = ram[rd_addr];
        end
        @(posedge clk);

        wr_en = 1'b1;
        rd_en = 1'b1;
        for (int i = 0; i < 16; i++) begin
            //@(posedge clk);
            rd_addr = i-1;
            wr_addr = i;
            data_in = $random;
            @(posedge clk);
            ram[wr_addr] = data_in;
            //@(posedge clk);
            data_out_tb = ram[rd_addr];
        end
        @(negedge clk);
        if (data_out != data_out_tb)begin
                $display ("ERROR at (time %t), data %h instead of %h", $realtime, data_out, data_out_tb);
        end
        else begin
            $display (" SUCCESS");
        end
    disable gen_clk;
    end


endmodule