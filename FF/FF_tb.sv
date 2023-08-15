//timescale
`timescale 1 ns / 100 ps;

module ff_tb;
//signal assignment
logic clk = 0;
logic rst;
logic en;
logic [3:0] in;
logic [3:0] out;
// create DUT instance
flop DUT (.*);

//generate clk
initial begin: generate_clk
    while(1)
    #10 clk = ~clk;
end
// start tests
initial begin: run_ff
//give timeformat
    $timeformat (-9, 0, "ns");

// signal intialization    
    rst = 1'b1;
    en = 1'b0;
    in = 4'b0000;
    for (int i = 0; i< 2; i++)
        @ (posedge clk);

    rst = 1'b0;
    en = 1'b1;
    @(posedge clk);

//start tests
    for (int i = 0; i<5; i++) begin
        @(posedge clk);
        in = $random;
        
    end

    en = 1'b0;
    //for (int i = 0; i< 3; i++)
        @ (posedge clk);

    en = 1'b1;
    @(posedge clk);    

    in = 4'b1110;
    @(posedge clk);

//check correct  output
    @(negedge clk)
    if (out != in) 
        $display("ERROR (time %0t) out = %h instead of %h", $realtime, out, in );
    else
        $display("Correct output");

//disable clk
    disable generate_clk;        

end

endmodule