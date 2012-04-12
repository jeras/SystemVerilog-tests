interface bus #(
   // data width
   parameter int unsigned DW = 8
)(
   input logic clk
);
   logic [DW-1:0] dat;  // counter
   modport i (input  dat);
   modport o (output dat);
endinterface

module top ();
   logic clk = 1'b1;
   bus #(4) bus (clk);
   always #5 clk <= ~clk;
   buffer buffer (.clk (clk), .i (bus), .o (bus));
endmodule

module buffer (
   input logic clk,
   bus.i i,
   bus.o o
);
   localparam DW = i.DW;
   logic [DW-1:0] mem;
   always @ (posedge clk)
   mem <= i.dat;
   assign o.dat = mem;
endmodule
