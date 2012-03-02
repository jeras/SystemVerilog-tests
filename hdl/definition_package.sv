////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

package package_ipv6;
  typedef struct packed {
    logic [  3:0] Version;
    logic [  7:0] TrafficClass;
    logic [ 19:0] FlowLabel;
    logic [ 15:0] PayloadLength;
    logic [  7:0] NextHeader;
    logic [  7:0] HopLimit;
    logic [127:0] SourceAddress;
    logic [127:0] DestinationAddress;
  } t_ipv6_header;
endpackage : package_ipv6


package package_arrays;
  typedef logic [3:0][7:0] t_data32;
endpackage : package_arrays


import package_ipv6::*;
import package_arrays::*;


module test_package (
  // system signals
  input  wire          clk,
  input  wire          rst,
  // input data bus
  input  t_data32      i_data,
  output t_ipv6_header o_head
);

localparam DW = $bits (t_data32);

logic [3:0] cnt;
t_ipv6_header r_head;

always @ (posedge clk, posedge rst)
if (rst)  cnt <= 4'd0;
else      cnt <= (cnt == 4'd9) ? 4'd0 : cnt + 4'd1;

always @ (posedge clk, posedge rst)
if (rst)  r_head              <= '{6,0,0,0,0,0,0,0};
else      r_head [DW*cnt+:DW] <= i_data;

always @ (*)
o_head = r_head;

endmodule : test_package
