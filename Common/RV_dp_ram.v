`timescale 1ns / 1ps


module RV_dp_ram#(
    
    parameter DATAW     = 8,
    parameter SIZE      = 4,
    parameter BYTEENW   = 1,
    parameter OUT_REG   = 0,
    parameter ADDRW     = $clog2(SIZE)
    
)(
    
    input  wire                 clk,
    input  wire                 reset,
    input  wire [BYTEENW-1 : 0] wren,
    input  wire [ADDRW-1 : 0]   waddr,
    input  wire [DATAW-1 : 0]   wdata,
    input  wire [ADDRW-1 : 0]   raddr,
    output wire [DATAW-1 : 0]   rdata

);
    


    if(OUT_REG)
    begin
    
        reg [DATAW-1:0] rdata_r;
        if(BYTEENW > 1)
        begin
        
            reg [(BYTEENW * 8) - 1:0] ram [SIZE-1:0]; 
            always@(posedge clk) 
            begin : RAM_operations
                //Writing data to memory entry
                //The writing process is done through two loops
                //where the outer loop is used to iterate over 
                //the bytes through mempry entry , while the inner
                //loop is used to assign bits within the byte
                //Nested for loop is used instead of using bounding
                //expression like [((i+1)*8)-1 : i*8] as the bounding 
                //expression requires that that boundaries must be constanr
                integer i,j;
                if(reset)
                begin
                
                    for (i = 0; i < SIZE; i = i + 1) 
                    begin
                    
                        ram[i] <= 0;
                        
                    end
                
                end
                else begin
                
                    for(i = 0 ; i < BYTEENW; i = i + 1)
                    begin
                        
                        for(j = 0 ; j < 8 ; j = j + 1)
                        begin
                        
                            if (wren[i])
                                ram[waddr][(i*8)+j] <= wdata[i * 8  + j];
                                
                        end
                        
                    end//for end
                
                end
                
                
                rdata_r <= ram[raddr];
            
            end//always end  
            
        end//BYTEENW end
        else begin
        
            reg [DATAW-1:0] ram [SIZE-1:0];
            integer i;
            always @(posedge clk) 
            begin
                
                if(reset)
                begin
                    
                    for (i = 0; i < SIZE; i = i + 1) 
                    begin
                    
                        ram[i] <= 0;
                        
                    end   
                
                end
                else begin
                
                    if(wren)
                        ram[waddr] <= wdata;
                        
                end
                    
                rdata_r <= ram[raddr];
            
            end
        
        end
        
        assign rdata = rdata_r;
    
    end
    else begin
    
        if(BYTEENW > 1)
        begin
        
            reg [(BYTEENW * 8) - 1:0] ram [SIZE-1:0]; 
            always@(posedge clk)
            begin : RAM_Operations1
                //Writing data to memory entry
                //The writing process is done through two loops
                //where the outer loop is used to iterate over 
                //the bytes through mempry entry , while the inner
                //loop is used to assign bits within the byte
                //Nested for loop is used instead of using bounding
                //expression like [((i+1)*8)-1 : i*8] as the bounding 
                //expression requires that that boundaries must be constanr
                integer i,j;
                if(reset)
                begin
                
                    for (i = 0; i < SIZE; i = i + 1) 
                    begin
                    
                        ram[i] <= 0;
                        
                    end
                
                end
                else begin
                
                    for(i = 0 ; i < BYTEENW; i = i + 1)
                    begin
                        for(j = 0 ; j < 8 ; j = j + 1)
                        begin
                        
                            if (wren[i])
                                ram[waddr][(i*8)+j] <= wdata[i * 8  + j];
                                
                        end
                        
                    end//for end
                
                end
            
            end//always end  
            
            assign rdata  = ram[raddr];
            
        end//BYTEENW end
        else begin
        
            reg [DATAW-1:0] ram [SIZE-1:0];
            integer i;
            always @(posedge clk) 
            begin 
                if(reset)
                begin
                    
                    for (i = 0; i < SIZE; i = i + 1) 
                    begin
                    
                        ram[i] <= 0;
                        
                    end   
                
                end
                else begin
                
                    if(wren)
                        ram[waddr] <= wdata;
                        
                end
                                
            end
            
            assign rdata  = ram[raddr];
        
        end
        
    end


endmodule
