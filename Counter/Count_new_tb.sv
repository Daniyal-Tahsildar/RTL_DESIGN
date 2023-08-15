//timescale
`timescale 1 ns / 100 ps; 
//module
module count_new_tb;    
//signal assingment
logic clk = 0;
logic rst, en, up_down, load;
logic [3:0] cin;
logic [3:0] cout;

//logic [3:0] correct_out;
//connect DUT
count_new DUT (.*);
// gen clk
initial begin: generate_clk
    while (1)
        #10 clk = ~ clk;
end

initial begin: run_test 
$timeformat (-9, 0, "ns");
//initialize signals
    rst = 1'b1;
    en = 1'b0;
    load = 1'b0;
    up_down = 1'b0;
    cin = 4'b0000;

    for (int i = 0; i<3; i++) begin
        @(posedge clk);
    end

    rst = 1'b0;
    en = 1'b1;
    @(posedge clk);

// run tests
    for (int i = 0; i<5; i++) begin
        @(posedge clk);
        up_down = ~up_down;
    end

    for (int i = 0; i<2; i++) begin
        en = 1'b0;
        @(posedge clk);
        
    end

    
    en = 1'b1;
    load = 1'b1;
    //up_down = 1'b1;
    cin = 4'b1011;
    @(posedge clk)
    //load =1'b0;
    //@(posedge clk);
    for (int i = 0; i<4; i++) begin
        load = $random;
        @(posedge clk);
    end

    
    //en = 1'b1;
    up_down = 1'b0;
    cin = 4'b0011;
    load = 1'b0;
    //@(posedge clk);
    for (int i = 0; i<5; i++) begin
        @(posedge clk);
    end

// check outputs
   /* @(negedge clk)
    if (cout)
        $display("ERROR! (time %t): out = %h instead of %h", $realtime, cout, correct_out);
    else
        $display("Test completed");*/
// print message
// disable clk   
    disable generate_clk;
end
endmodule