interface bus #(
   // data width
   parameter int unsigned DW = 8
)(
   input logic clk,
   input logic rst
);
   logic [DW-1:0] dat;  // counter
   modport i (input  dat);
   modport o (output dat);
endinterface

module tb ();
   localparam DW = 4;
   logic clk = 1'b1;
   logic rst;
   int cnt;
   // clock
   always #5 clk <= ~clk;
   // reset
   assign rst = cnt < 4;
   // time counter
   always @ (posedge clk)
   cnt <= cnt + 1;
   // test end
   always @ (posedge clk)
   if (cnt > 10)  $stop();
   // RTL instance
   top #(DW) top (
      .clk    (clk),
      .rst    (rst),
      .cnt_i  (cnt[DW-1:0]),
      .cnt_o  ()
   );
endmodule

module top #(
   // data width
   parameter int unsigned DW = 8
)(
   // system signals
   input  logic          clk,
   input  logic          rst,
   // IO
   input  logic [DW-1:0] cnt_i,
   output logic [DW-1:0] cnt_o
);
   // interface
   bus #(DW) bus_i (clk, rst);
   bus #(DW) bus_o (clk, rst);
   // IO
   assign bus_i.dat = cnt_i;
   assign cnt_o = bus_o.dat;
   // buffer instance
   buffer buffer (
      .clk  (clk),
      .rst  (rst),
      .i    (bus_i),
      .o    (bus_o)
   );
endmodule

module buffer (
   input logic clk,
   input logic rst,
   bus.i i,
   bus.o o
);
   localparam DW = i.DW;
   logic [DW-1:0] mem;
   always @ (posedge clk, posedge rst)
   if (rst)  mem <= {DW{1'b1}};
   else      mem <= i.dat;
   assign o.dat = mem;
endmodule
