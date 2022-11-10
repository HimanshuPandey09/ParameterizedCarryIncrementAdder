`timescale 1ns / 1ps

module CIA_01#(parameter N = 16,
               parameter GS = 8)(output [N:1] sum,
                                output cout,
                                input [N:1] a,
                                input [N:1] b,
                                input cin);
              
wire [N:0] g, p;  // bit P & G Signals.
wire [N-1:0] G;   // Group G Signals.

wire[N-1:1] gn;  //Intermediate Group P&G signals.
wire[N-1:1] pn;  //Intermediate Group P&G signals.

assign g[0] = cin,
       p[0] = 1'b0;

assign G[0] = g[0];
       
assign gn[GS-1:1] = 1'b0;      
assign pn[GS-1:1] = 1'b0;  

// Bit PG Implementation.
genvar i;                       
generate for(i = 1; i <= N; i = i + 1) begin: bitPG
    assign g[i] = a[i] & b[i],
           p[i] = a[i] ^ b[i];
    end
endgenerate

// Group PG Implementation
genvar m;
generate for(m = 1; m <= GS-1; m = m + 1) begin: GroupGenerateSignal
     grayCell gc01(G[m], g[m], p[m], G[m-1]);
    end
endgenerate   
  
    
genvar k,n,q;
generate for(k = GS+1; k <= N-1 ; k = k + GS) begin: GroupGPSignal
     assign gn[k-1] = g[k-1];
     assign pn[k-1] = p[k-1];
        
     for(n = k; n <= k+GS-2; n = n + 1 ) begin: IntermediateGPSignal
        blackCell bc01(gn[n], pn[n], g[n], p[n], gn[n-1], p[n], pn[n-1]);
     end
     
     for(q = k-1; q<=k+GS-2; q = q+1) begin: GroupGSignal
        if (q == k-1)
            grayCell gc02(G[q], g[q], p[q], G[q-1]);
        else
        grayCell gc03(G[q], gn[q], pn[q], G[k-2]);
     end
    end
endgenerate 

// Sum Logic Implementation
genvar o;
generate for (o = 1; o <= N; o = o+1) begin: sumLogic
    assign sum[o] = p[o] ^ G[o-1];
    if (o == N)
        grayCell gc04(cout, g[N], p[N], G[N-1]); 
end
endgenerate

endmodule
