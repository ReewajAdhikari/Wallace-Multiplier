`timescale 1ns/1ps
// full adder struct model
module full_adder (
    output S, Cout,
    input A, B, Cin
);
    wire w1, w2, w3;
    //XOR gates for Sum
    xor (w1, A, B);
    xor (S, w1, Cin);
    //AND gates for Carry
    and (w2, A, B);
    and (w3, w1, Cin);
    //OR gate for final Carry
    or (Cout, w2, w3);
endmodule

module half_adder(
    output S, Cout,
    input A, B

);
    xor(S, A, B);
    and (Cout, A, B);
endmodule

module wallace_8x8(
    input [7:0] a,b,
    output [15:0] prod
);
    wire p[7:0][7:0];
    genvar i, j;
    generate
    for (i = 0; i < 8; i = i + 1) begin : gen_i
        for (j = 0; j < 8; j = j + 1) begin : gen_j
            and and_gates ((p[i][j]),(a[i]),(b[j]));
        end
    end
    endgenerate
    // Half adders
    wire h0s,h0c,h1s,h1c,h2s,h2c,h3s,h3c,h4s,h4c,
         h5s,h5c,h6s,h6c,h7s,h7c,h8s,h8c,h9s,h9c,
         h10s,h10c,h11s,h11c,h12s,h12c,h13s,h13c,
         h14s,h14c,h15s,h15c,h16s,h16c;

    // Full adders
    wire f0s,f0c,f1s,f1c,f2s,f2c,f3s,f3c,f4s,f4c,
         f5s,f5c,f6s,f6c,f7s,f7c,f8s,f8c,f9s,f9c,
         f10s,f10c,f11s,f11c,f12s,f12c,f13s,f13c,
         f14s,f14c,f15s,f15c,f16s,f16c,f17s,f17c,
         f18s,f18c,f19s,f19c,f20s,f20c,f21s,f21c,
         f22s,f22c,f23s,f23c,f24s,f24c,f25s,f25c,
         f26s,f26c,f27s,f27c,f28s,f28c,f29s,f29c,
         f30s,f30c,f31s,f31c,f32s,f32c,f33s,f33c,
         f34s,f34c,f35s,f35c,f36s,f36c,f37s,f37c,
         f38s,f38c,f39s,f39c,f40s,f40c,f41s,f41c,
         f42s,f42c,f43s,f43c,f44s,f44c,f45s,f45c,
         f46s,f46c; 
    
    //first level
    half_adder ha0(h0s,h0c,p[1][0],p[0][1]);
    full_adder fa0(f0s,f0c,p[2][0],p[1][1],p[0][2]);
    full_adder fa1(f1s,f1c,p[3][0],p[2][1],p[1][2]);
    full_adder fa2(f2s,f2c,p[4][0],p[3][1],p[2][2]);
    full_adder fa3(f3s,f3c,p[5][0],p[4][1],p[3][2]);
    full_adder fa4(f4s,f4c,p[6][0],p[5][1],p[4][2]);
    full_adder fa5(f5s,f5c,p[7][0],p[6][1],p[5][2]);
    half_adder ha1(h1s,h1c,p[7][1],p[6][2]);
    
    half_adder ha2(h2s,h2c,p[1][3],p[0][4]);
    full_adder fa6(f6s,f6c,p[2][3],p[1][4],p[0][5]);
    full_adder fa7(f7s,f7c,p[3][3],p[2][4],p[1][5]);
    full_adder fa8(f8s,f8c,p[4][3],p[3][4],p[2][5]);
    full_adder fa9(f9s,f9c,p[5][3],p[4][4],p[3][5]);
    full_adder fa10(f10s,f10c,p[6][3],p[5][4],p[4][5]);
    full_adder fa11(f11s,f11c,p[7][3],p[6][4],p[5][5]);
    half_adder ha3(h3s,h3c,p[7][4],p[6][5]);
    
    //second level
    half_adder ha4(h4s,h4c,h0c,f0s);
    full_adder fa12(f12s,f12c,p[0][3],f0c,f1s);
    full_adder fa13(f13s,f13c,f1c,f2s,h2s);
    full_adder fa14(f14s,f14c,h2c,f2c,f3s);
    full_adder fa15(f15s,f15c,p[0][6],f3c,f6c);
    full_adder fa16(f16s,f16c,p[1][6],p[0][7],f5s);
    full_adder fa17(f17s,f17c,p[2][6],p[1][7],f5c);
    full_adder fa18(f18s,f18c,p[3][6],p[2][7],p[7][2]);
    
    half_adder ha5(h5s,h5c,f4s,f7s);
    full_adder fa19(f19s,f19c,f8s,f4c,f7c);
    full_adder fa20(f20s,f20c,f8c,h1s,f9s);
    full_adder fa21(f21s,f21c,f10s,h1c,f9c);
    full_adder fa22(f22s,f22c,p[3][7],f10c,f11s);
    full_adder fa23(f23s,f23c,p[4][7],f11c,h3s);
    full_adder fa24(f24s,f24c,p[5][7],p[7][5],h3c);
    half_adder ha6(h6s,h6c,p[7][6],p[6][7]);
    
    //third level
    half_adder ha7(h7s,h7c,h4c,f12s);
    half_adder ha8(h8s,h8c,f12c,f13s);
    full_adder fa25(f25s,f25c,f13c,f14s,f6s);
    full_adder fa26(f26s,f26c,f14c,f15s,h5s);
    full_adder fa27(f27s,f27c,h5c,f15c,f16s);
    full_adder fa28(f28s,f28c,f19c,f16c,f17s);
    full_adder fa29(f29s,f29c,f17c,f20c,f18s);
    full_adder fa30(f30s,f30c,f18c,f21c,f22s);
    half_adder ha9(h9s,h9c,f22c,f23s);
    half_adder ha10(h10s,h10c,f23c,f24s);
    
    //fourth level
    half_adder ha11(h11s,h11c,h7c,h8s);
    half_adder ha12(h12s,h12c,h8c,f25s);
    half_adder ha13(h13s,h13c,f25c,f26s);
    full_adder fa31(f31s,f31c,f26c,f27s,f19s);
    full_adder fa32(f32s,f32c,f27c,f28s,f20s);
    full_adder fa33(f33s,f33c,f28c,f29s,f21s);
    full_adder fa34(f34s,f34c,f29c,f30s,p[4][6]);
    full_adder fa35(f35s,f35c,f30c,h9s,p[5][6]);
    full_adder fa36(f36s,f36c,h9c,h10s,p[6][6]);
    full_adder fa37(f37s,f37c,h10c,f24c,h6s);
    half_adder ha14(h14s,h14c,h6c,p[7][7]);
    
    //fifth level
    half_adder ha15(h15s,h15c,h11c,h12s);
    full_adder fa38(f38s,f38c,h15c,h12c,h13s);
    full_adder fa39(f39s,f39c,f38c,h13c,f31s);
    full_adder fa40(f40s,f40c,f39c,f31c,f32s);
    full_adder fa41(f41s,f41c,f40c,f32c,f33s);
    full_adder fa42(f42s,f42c,f41c,f33c,f34s);
    full_adder fa43(f43s,f43c,f42c,f34c,f35s);
    full_adder fa44(f44s,f44c,f43c,f35c,f36s);
    full_adder fa45(f45s,f45c,f44c,f36c,f37s);
    full_adder fa46(f46s,f46c,f45c,f37c,h14s);
    half_adder ha16(h16s,h16c,f46c,h14c);

    //Assign
    buf (prod[0],p[0][0]);
    buf (prod[1],h0s);
    buf (prod[2],h4s);
    buf (prod[3],h7s);
    buf (prod[4],h11s);
    buf (prod[5],h15s);
    buf (prod[6],f38s);
    buf (prod[7],f39s);
    buf (prod[8],f40s);
    buf (prod[9],f41s);
    buf (prod[10],f42s);
    buf (prod[11],f43s);
    buf (prod[12],f44s);
    buf (prod[13],f45s);
    buf (prod[14],f46s);
    buf (prod[15],h16s);
    
endmodule

module wallace_8x8_tb;
    reg [7:0] a, b;
    wire [15:0] P;
    wallace_8x8 dut(a, b, P);
    
    initial
    begin
        // 1) Zero case
        a = 8'd0; b = 8'd0; 
        #10 $display("Test 1: %d × %d = %d (expected: %d)", a, b, P, a*b);
        
        // 2) Basic single bit multiplication
        a = 8'd1; b = 8'd1; 
        #10 $display("Test 2: %d × %d = %d (expected: %d)", a, b, P, a*b);
        
        // 3) Small multiplications
        a = 8'd3; b = 8'd5; 
        #10 $display("Test 3: %d × %d = %d (expected: %d)", a, b, P, a*b);
        
        // 4) Medium values
        a = 8'd15; b = 8'd15; 
        #10 $display("Test 5: %d × %d = %d (expected: %d)", a, b, P, a*b);
        
        // 5) High bit set case
        a = 8'd128; b = 8'd5; 
        #10 $display("Test 6: %d × %d = %d (expected: %d)", a, b, P, a*b);
        
        // 6) Large values
        a = 8'd100; b = 8'd200; 
        #10 $display("Test 7: %d × %d = %d (expected: %d)", a, b, P, a*b);
        
        // 7) Maximum case
        a = 8'd255; b = 8'd255; 
        #10 $display("Test 8: %d × %d = %d (expected: %d)", a, b, P, a*b);
    
    $finish;
    end
endmodule
