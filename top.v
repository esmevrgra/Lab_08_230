module mux4(
    input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [3:0] D,
    input [1:0] Sel,
    input Enable,
    output [3:0] Y
);

    assign Y = (Enable == 0) ? 4'b0000 :
               (Sel == 2'b00) ? A :
               (Sel == 2'b01) ? B :
               (Sel == 2'b10) ? C :
                                D;

endmodule


module demux4(
    input [3:0] A,
    input [1:0] Sel,
    input Enable,
    output [3:0] Y0,
    output [3:0] Y1,
    output [3:0] Y2,
    output [3:0] Y3
);

    assign Y0 = (Enable == 1 && Sel == 2'b00) ? A : 4'b0000;
    assign Y1 = (Enable == 1 && Sel == 2'b01) ? A : 4'b0000;
    assign Y2 = (Enable == 1 && Sel == 2'b10) ? A : 4'b0000;
    assign Y3 = (Enable == 1 && Sel == 2'b11) ? A : 4'b0000;

endmodule


// Implement top level module
module top(
    input [15:0] sw,
    input btnL,
    input btnU,
    input btnD,
    input btnR,
    input btnC,
    output [15:0] led
);

wire [1:0] muxSel;
wire [1:0] demuxSel;
wire [3:0] Y;

    assign muxSel = {btnU, btnL};
    assign demuxSel = {btnR, btnD};

    mux4 One (
        .A(sw[3:0]),
        .B(sw[7:4]),
        .C(sw[11:8]),
        .D(sw[15:12]),
        .Sel(muxSel),
        .Enable(btnC),
        .Y(Y)
    );

    demux4 Two (
        .A(Y),
        .Sel(demuxSel),
        .Enable(btnC),
        .Y0(led[3:0]),
        .Y1(led[7:4]),
        .Y2(led[11:8]),
        .Y3(led[15:12])
    );

endmodule
