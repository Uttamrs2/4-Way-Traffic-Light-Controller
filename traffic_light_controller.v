`timescale 1ns / 1ps
module traffic_light_controller(
    input wire clk,         
    input wire reset,       
    output reg [2:0] ns_light, 
    output reg [2:0] ew_light  
);

    
    parameter RED    = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN  = 3'b001;

    
    parameter NS_GREEN = 2'b00,    
              NS_YELLOW = 2'b01,   
              EW_GREEN = 2'b10,    
              EW_YELLOW = 2'b11;   

    
    parameter GREEN_TIME = 50;  
    parameter YELLOW_TIME = 10; 

    reg [1:0] state;            
    reg [6:0] timer;            

    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            
            state <= NS_GREEN;
            timer <= 0;
        end else begin
            
            case (state)
                NS_GREEN: begin
                    if (timer < GREEN_TIME) begin
                        timer <= timer + 1;
                    end else begin
                        state <= NS_YELLOW; 
                        timer <= 0;
                    end
                end
                
                NS_YELLOW: begin
                    if (timer < YELLOW_TIME) begin
                        timer <= timer + 1;
                    end else begin
                        state <= EW_GREEN; 
                        timer <= 0;
                    end
                end
                
                EW_GREEN: begin
                    if (timer < GREEN_TIME) begin
                        timer <= timer + 1;
                    end else begin
                        state <= EW_YELLOW; 
                        timer <= 0;
                    end
                end
                
                EW_YELLOW: begin
                    if (timer < YELLOW_TIME) begin
                        timer <= timer + 1;
                    end else begin
                        state <= NS_GREEN; 
                        timer <= 0;
                    end
                end
                
                default: begin
                    state <= NS_GREEN; 
                end
            endcase
        end
    end

    
    always @(*) begin
        case (state)
            NS_GREEN: begin
                ns_light = GREEN;
                ew_light = RED;
            end
            
            NS_YELLOW: begin
                ns_light = YELLOW;
                ew_light = RED;
            end
            
            EW_GREEN: begin
                ns_light = RED;
                ew_light = GREEN;
            end
            
            EW_YELLOW: begin
                ns_light = RED;
                ew_light = YELLOW;
            end
            
            default: begin
                ns_light = RED;
                ew_light = RED;
            end
        endcase
    end
endmodule

