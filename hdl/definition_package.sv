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


package package_arrays;
  typedef [3:0][7:0] t_data32;
endpackage : package_arrays


import package_ipv6::*;
import package_arrays::*;


module test_package (
  input t_ipv6_header_little ipv6_header;
);

endmodule : test_package
