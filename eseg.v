module binaryToESeg
    (
     input  A,B,C,D,
    output eSeg);

    nand #1
	g1(p1,C,~D),
	g2(p2,A,B),
	g3(p3,~B,~D),
	g4(p4,A,C),
	g5(eSeg,p1,p2,p3,p4);
endmodule

module m16
    (output reg[3:0] ctr=1,
     input           clock);

     always @(posedge clock)
	ctr <= ctr+1;
endmodule

module m555
    (output reg clock);

    initial
	#5 clock=1;

    always
	#50 clock= ~ clock;
endmodule

module board;
    wire [3:0]	count;
    wire	clock,eSeg;

    m16		    counter  (count,clock);
    m555	    clockGen (clock);
    binaryToESeg    disp     (count[3],count[2],count[1],count[0],eSeg);

    initial begin
	$dumpfile("board.vcd");
	$dumpvars(0,board);
	#1000 $finish;
    end
endmodule
