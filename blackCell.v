`timescale 1ns / 1ps

module blackCell(output out1,
                 output out2,
                 input a,
                 input b,
                 input c,
                 input d,
                 input e);
                 
assign out1 = a | b & c;
assign out2 = d & e;
endmodule
