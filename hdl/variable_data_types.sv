////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module variable_data_types #(
  // parameters for vector sizes
  parameter WD = 8  // data width
)();

// variables
reg       var_reg;
logic     var_logic;
bit       var_bit;

byte      var_byte;
shortint  var_shortint;
int       var_int;
longint   var_longint;
integer   var_integer;
time      var_time;

//shortreal var_shortreal;
real      var_real;
realtime  var_realtime;


initial begin
//  test_typeof;
//  test_typename;
  test_bits;
end

task test_typeof;
begin
//  $write ("%d", $typeof(var_byte));
end
endtask

// task test_typename;
// begin
//   $write ("$typename(var_reg      ) = %s", $typename(var_reg      ));
//   $write ("$typename(var_logic    ) = %s", $typename(var_logic    ));
//   $write ("$typename(var_bit      ) = %s", $typename(var_bit      ));
//   $write ("$typename(var_byte     ) = %s", $typename(var_byte     ));
//   $write ("$typename(var_shortint ) = %s", $typename(var_shortint ));
//   $write ("$typename(var_int      ) = %s", $typename(var_int      ));
//   $write ("$typename(var_longint  ) = %s", $typename(var_longint  ));
//   $write ("$typename(var_integer  ) = %s", $typename(var_integer  ));
//   $write ("$typename(var_time     ) = %s", $typename(var_time     ));
//   $write ("$typename(var_shortreal) = %s", $typename(var_shortreal));
//   $write ("$typename(var_real     ) = %s", $typename(var_real     ));
//   $write ("$typename(var_realtime ) = %s", $typename(var_realtime ));
// end
// endtask

task test_bits;
begin
  $write ("$bits(var_reg      ) = %d\n", $bits(var_reg      ));
  $write ("$bits(var_logic    ) = %d\n", $bits(var_logic    ));
  $write ("$bits(var_bit      ) = %d\n", $bits(var_bit      ));
  $write ("$bits(var_byte     ) = %d\n", $bits(var_byte     ));
  $write ("$bits(var_shortint ) = %d\n", $bits(var_shortint ));
  $write ("$bits(var_int      ) = %d\n", $bits(var_int      ));
  $write ("$bits(var_longint  ) = %d\n", $bits(var_longint  ));
  $write ("$bits(var_integer  ) = %d\n", $bits(var_integer  ));
  $write ("$bits(var_time     ) = %d\n", $bits(var_time     ));
//  $write ("$bits(var_shortreal) = %d\n", $bits(var_shortreal));
//  $write ("$bits(var_real     ) = %d\n", $bits(var_real     ));
//  $write ("$bits(var_realtime ) = %d\n", $bits(var_realtime ));
end
endtask

// Examples Size Sign
// 10 unsized signed
// 'o7
// unsized unsigned
// unsigned
// Radix
// Binary Equivalent
// decimal 0...01010 (32-bits)
// octal
// 0...00111 (32-bits)
// 1'b1 1 bit 
// binary 1
// 8'sHc5 8 bits signed hex 11000101
// 6'hF0 6 bits unsigned hex 110000 (truncated)
// 6'hA 6 bits unsigned hex 001010 (zero filled)
// 6'shA 6 bits signed hex 001010 (zero filled)
// 6'bZ 6 bits unsigned 
// binary ZZZZZZ (Z filled)



endmodule
