package package_ipv6;
  typedef struct packed {
    logic [0:  3] Version;
    logic [0:  7] TrafficClass;
    logic [0: 19] FlowLabel;
    logic [0: 15] PayloadLength;
    logic [0:  7] NextHeader;
    logic [0:  7] HopLimit;
    logic [0:127] SourceAddress;
    logic [0:127] DestinationAddress;
  } type_ipv6_header_little
endpackage : package_ipv6

import package_ipv6::*;

////////////////////////////////////////////////////////////////////////////////
// ipv6 serializer
////////////////////////////////////////////////////////////////////////////////

module #(
  // width of serialized port
  parameter WD = 32;
) ipv6_serializer (
  // system signals
  logic                   clk, rst,
  // input port
  logic                   packet_vld,
  type_ipv6_header_little packet_bus,
  logic                   packet_rdy,
  // output port
  logic                   stream_vld,
  logic [WD-1:0]          stream_bus,
  logic                   stream_rdy
);

// 
localparam LENGTH = $bits(packet_bus/DW);

logic [LENGTH

always_ff @ (posedge clk, posedge rst)
if (rst) begin
  
end else begin
end

endmodule

////////////////////////////////////////////////////////////////////////////////
// ipv6 deserializer
////////////////////////////////////////////////////////////////////////////////

module #(
  // width of serialized port
  parameter DW = 32;
) ipv6_deserializer (
  // system signals
  logic                   clk, rst,
  // output port
  logic                   stream_vld,
  logic [DW-1:0]          stream_bus,
  logic                   stream_rdy,
  // input port
  logic                   packet_vld,
  type_ipv6_header_little packet_bus,
  logic                   packet_rdy,
);

