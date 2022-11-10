`timescale 1ns / 1ps

module grayCell(output out,
                input a,
                input b,
                input c);
                
assign out = a | b & c;               
endmodule
