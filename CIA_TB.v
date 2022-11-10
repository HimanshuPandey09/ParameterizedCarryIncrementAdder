`timescale 1ns / 1ps

module CIA_TB();

parameter N = 16;
reg [N:1] a,b;
reg cin;
wire cout;
wire [N:1] sum;


CIA_01 CIA01(sum,cout,a,b,cin);

initial begin
//    a = 8'b00001110;
//    b = 8'b00001011;
    a = 16'b1010110111000000;
    b = 16'b1111111010000000;
    cin = 1'b1;
//    a = 8'b01101001;
//    b = 8'b11010111;
//    a = 16'b0000000001101100;
//    b = 16'b0000001000110010;
//    cin = 1'b1;
//    #50 a = 16'h3A9A; b = 16'hE544; cin = 1'b0;
//    #50 a = 32'hD47856ED; b = 32'hDCBE1597 ; cin = 1'b1;
//    a = 4'b1010; b = 4'b0111; cin = 1'b1;
    #20 $finish;
end
endmodule

