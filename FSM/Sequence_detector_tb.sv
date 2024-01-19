`timescale 1ns /10ps
`define delay 10

`include "Sequence_detector.v"

module fsm_tb;

    logic clk, rst;
    logic in, out;

  fsm DUT (.*);

    initial begin: gen_clk
        clk = 1'b0;
        while(1) #5 clk = ~clk;
    end

    initial begin: drive
        rst = 1'b1;
        in = 0;
        @(posedge clk);

        @(negedge clk);
        rst = 1'b0;
      	@(posedge clk)
        in = 1'b1;
      @(posedge clk); 
        in = 1'b0;
            @(posedge clk); 

        in = 1'b1;
            @(posedge clk); 

        in = 1'b1;
            @(posedge clk); 

        in = 1'b0;
            @(posedge clk); 

        in = 1'b1;
            @(posedge clk); 

      	
      for(int i = 0; i < 10; i++) begin
        in = $random;
        @(posedge clk);
      end

        disable gen_clk;
    end
  
  assert property (@(posedge clk) disable iff(rst) DUT.state == $past(DUT.next_state));
	assert property (@(posedge clk) disable iff(rst) (DUT.state == 3'b101) |-> out == 1'b1);


    initial begin
      $monitor("[time: %t]in = %d, out = %d", $realtime, in, out);
        $dumpfile("fsm.vcd");
        $dumpvars();
    end

endmodule