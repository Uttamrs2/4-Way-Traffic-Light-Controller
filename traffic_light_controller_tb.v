
`timescale 1ns / 1ps

module traffic_light_controller_tb;
    reg clk;                    
    reg reset;                  
    wire [2:0] ns_light;       
    wire [2:0] ew_light;       

    
    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .ns_light(ns_light),
        .ew_light(ew_light)
    );

    
    always #5 clk = ~clk;

    
    initial begin
        
        clk = 0;
        reset = 1; 
        #10 reset = 0; 

        
        
        
        
        #2400 $finish; 
    end

    
    initial begin
        $monitor("Time=%0dns, NS Light=%b, EW Light=%b", $time, ns_light, ew_light);
    end
endmodule
