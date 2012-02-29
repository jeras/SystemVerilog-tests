////////////////////////////////////////////////////////////////////////////////
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module structure_packed ();

typedef struct packed {
  logic [0:  3] Version;
  logic [0:  7] TrafficClass;
  logic [0: 19] FlowLabel;
  logic [0: 15] PayloadLength;
  logic [0:  7] NextHeader;
  logic [0:  7] HopLimit;
  logic [0:127] SourceAddress;
  logic [0:127] DestinationAddress;
} t_ipv6_header_little;

t_ipv6_header_little ipv6_header;


initial begin
  test_structure_querying;
  test_structure_access;
end


task test_structure_print;
begin
  $write ("ipv6_header                   ) = 320'%h\n", ipv6_header                   );
  $write ("ipv6_header.Version           ) =   4'%h\n", ipv6_header.Version           );
  $write ("ipv6_header.TrafficClass      ) =   8'%h\n", ipv6_header.TrafficClass      );
  $write ("ipv6_header.FlowLabel         ) =  20'%h\n", ipv6_header.FlowLabel         );
  $write ("ipv6_header.PayloadLength     ) =  16'%h\n", ipv6_header.PayloadLength     );
  $write ("ipv6_header.NextHeader        ) =   8'%h\n", ipv6_header.NextHeader        );
  $write ("ipv6_header.HopLimit          ) =   8'%h\n", ipv6_header.HopLimit          );
  $write ("ipv6_header.SourceAddress     ) = 128'%h\n", ipv6_header.SourceAddress     );
  $write ("ipv6_header.DestinationAddress) = 128'%h\n", ipv6_header.DestinationAddress);
end
endtask


task test_structure_querying;
begin
  $write ("$bits (ipv6_header                   ) = %d\n", $bits(ipv6_header                   ));
  $write ("$bits (ipv6_header.Version           ) = %d\n", $bits(ipv6_header.Version           ));
  $write ("$bits (ipv6_header.TrafficClass      ) = %d\n", $bits(ipv6_header.TrafficClass      ));
  $write ("$bits (ipv6_header.FlowLabel         ) = %d\n", $bits(ipv6_header.FlowLabel         ));
  $write ("$bits (ipv6_header.PayloadLength     ) = %d\n", $bits(ipv6_header.PayloadLength     ));
  $write ("$bits (ipv6_header.NextHeader        ) = %d\n", $bits(ipv6_header.NextHeader        ));
  $write ("$bits (ipv6_header.HopLimit          ) = %d\n", $bits(ipv6_header.HopLimit          ));
  $write ("$bits (ipv6_header.SourceAddress     ) = %d\n", $bits(ipv6_header.SourceAddress     ));
  $write ("$bits (ipv6_header.DestinationAddress) = %d\n", $bits(ipv6_header.DestinationAddress));
  $write ("\n");
end
endtask


task test_structure_access;
begin
  // accessing whole structure
  ipv6_header = {320{1'bx}};                                test_structure_print;
  ipv6_header = {320{1'bx}};  ipv6_header = {320+0{1'b1}};  test_structure_print;
  ipv6_header = {320{1'bx}};  ipv6_header = {320+1{1'b1}};  test_structure_print;
  ipv6_header = {320{1'bx}};  ipv6_header = {320-1{1'b1}};  test_structure_print;
  // accessing structure elements
  ipv6_header = {320{1'bx}};
  ipv6_header                    = {320+0{1'b1}};
  ipv6_header.Version            = {  4+0{1'b1}};
  ipv6_header.TrafficClass       = {  8+0{1'b1}};
  ipv6_header.FlowLabel          = { 20+0{1'b1}};
  ipv6_header.PayloadLength      = { 16+0{1'b1}};
  ipv6_header.NextHeader         = {  8+0{1'b1}};
  ipv6_header.HopLimit           = {  8+0{1'b1}};
  ipv6_header.SourceAddress      = {128+0{1'b1}};
  ipv6_header.DestinationAddress = {128+0{1'b1}};
  test_structure_print;
  ipv6_header = {320{1'bx}};
  ipv6_header                    = {320+1{1'b1}};
  ipv6_header.Version            = {  4+1{1'b1}};
  ipv6_header.TrafficClass       = {  8+1{1'b1}};
  ipv6_header.FlowLabel          = { 20+1{1'b1}};
  ipv6_header.PayloadLength      = { 16+1{1'b1}};
  ipv6_header.NextHeader         = {  8+1{1'b1}};
  ipv6_header.HopLimit           = {  8+1{1'b1}};
  ipv6_header.SourceAddress      = {128+1{1'b1}};
  ipv6_header.DestinationAddress = {128+1{1'b1}};
  test_structure_print;
  ipv6_header = {320{1'bx}};
  ipv6_header                    = {320-1{1'b1}};
  ipv6_header.Version            = {  4-1{1'b1}};
  ipv6_header.TrafficClass       = {  8-1{1'b1}};
  ipv6_header.FlowLabel          = { 20-1{1'b1}};
  ipv6_header.PayloadLength      = { 16-1{1'b1}};
  ipv6_header.NextHeader         = {  8-1{1'b1}};
  ipv6_header.HopLimit           = {  8-1{1'b1}};
  ipv6_header.SourceAddress      = {128-1{1'b1}};
  ipv6_header.DestinationAddress = {128-1{1'b1}};
  test_structure_print;
end
endtask

endmodule
