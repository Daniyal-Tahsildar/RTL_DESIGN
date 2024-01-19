`timescale 1ns /10ps

`include "freq_div.v"

module freq_div_tb;

    parameter N = 7; 
    logic clk, rst;
    logic new_clk;

  freq_div #(.N(N)) DUT (.*);

    initial begin: gen_clk
        clk = '0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        rst = 1'b1;
        @(posedge clk);
        rst = 1'b0;
      for(int i = 0; i< 25; i++)begin
        @(posedge clk);
        end
      $monitor ("clk:=%d, new_clk= %d", clk, new_clk);
      $display("Width: %d", DUT.WIDTH);
      disable gen_clk;
    end

    initial begin
        $dumpfile("freq_div.vcd");
      $dumpvars();

    end
endmodule