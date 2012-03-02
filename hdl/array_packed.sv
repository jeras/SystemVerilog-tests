////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module array_packed #(
  // parameters for array sizes
  parameter WA = 8,  // address dimension size
  parameter WB = 8   // bit     dimension size
)();

// 2D packed array parameters
localparam [WA-1:0] [WB-1:0] param_bg = {WA*WB  {1'b1}};

// 2D packed arrays
logic        [WA-1:0] [WB-1:0] array_bg;  // big endian array
logic        [0:WA-1] [0:WB-1] array_lt;  // little endian array
logic                [WA*WB:0] array_1d;  // 1D array
logic signed [WA-1:0] [WB-1:0] array_sg;  // signed big endian array

integer txt_file;
integer i;


initial begin
  test_array_querying;
  test_array_literals;
  test_write_to_array;
  test_read_from_array;
  test_read_from_parameter_array;
//  test_signed_array;
end


task test_array_querying;
  integer n;
  integer i;
begin
  $write ("\n");
  n = $dimensions (array_bg);
  $write ("$bits      (array_bg) = %d\n", $bits(array_bg));
  $write ("$dimensions(array_bg) = %d\n", n);
  $write ("$left      (array_bg) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $left      (array_bg, i));  $write ("\n");
  $write ("$right     (array_bg) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $right     (array_bg, i));  $write ("\n");
  $write ("$low       (array_bg) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $low       (array_bg, i));  $write ("\n");
  $write ("$high      (array_bg) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $high      (array_bg, i));  $write ("\n");
  $write ("$increment (array_bg) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $increment (array_bg, i));  $write ("\n");
  $write ("$size      (array_bg) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $size      (array_bg, i));  $write ("\n");
  $write ("\n");
  n = $dimensions (array_lt);
  $write ("$bits      (array_lt) = %d\n", $bits(array_lt));
  $write ("$dimensions(array_lt) = %d\n", n);
  $write ("$left      (array_lt) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $left      (array_lt, i));  $write ("\n");
  $write ("$right     (array_lt) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $right     (array_lt, i));  $write ("\n");
  $write ("$low       (array_lt) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $low       (array_lt, i));  $write ("\n");
  $write ("$high      (array_lt) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $high      (array_lt, i));  $write ("\n");
  $write ("$increment (array_lt) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $increment (array_lt, i));  $write ("\n");
  $write ("$size      (array_lt) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $size      (array_lt, i));  $write ("\n");
  $write ("\n");
  n = $dimensions (array_1d);
  $write ("$bits      (array_1d) = %d\n", $bits(array_1d));
  $write ("$dimensions(array_1d) = %d\n", n);
  $write ("$left      (array_1d) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $left      (array_1d, i));  $write ("\n");
  $write ("$right     (array_1d) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $right     (array_1d, i));  $write ("\n");
  $write ("$low       (array_1d) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $low       (array_1d, i));  $write ("\n");
  $write ("$high      (array_1d) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $high      (array_1d, i));  $write ("\n");
  $write ("$increment (array_1d) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $increment (array_1d, i));  $write ("\n");
  $write ("$size      (array_1d) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $size      (array_1d, i));  $write ("\n");
  $write ("\n");
  n = $dimensions (array_bg[WA/2-1:0]);
  $write ("$bits      (array_bg[WA/2-1:0]) = %d\n", $bits(array_bg[WA/2-1:0]));
  $write ("$dimensions(array_bg[WA/2-1:0]) = %d\n", n);
  $write ("$left      (array_bg[WA/2-1:0]) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $left      (array_bg[WA/2-1:0], i));  $write ("\n");
  $write ("$right     (array_bg[WA/2-1:0]) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $right     (array_bg[WA/2-1:0], i));  $write ("\n");
  $write ("$low       (array_bg[WA/2-1:0]) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $low       (array_bg[WA/2-1:0], i));  $write ("\n");
  $write ("$high      (array_bg[WA/2-1:0]) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $high      (array_bg[WA/2-1:0], i));  $write ("\n");
  $write ("$increment (array_bg[WA/2-1:0]) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $increment (array_bg[WA/2-1:0], i));  $write ("\n");
  $write ("$size      (array_bg[WA/2-1:0]) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $size      (array_bg[WA/2-1:0], i));  $write ("\n");
  $write ("\n");
end
endtask


task test_array_literals;
begin
  array_bg = {WA*WB{1'bx}};  array_bg            =  {WA     *WB  {1'b1}   };  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            =  {WA  {  {WB  {1'b1}} }};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = '{WA  { '{WB  {1'b1}} }};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = '{WA  {  {WB+0{1'b1}} }};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = '{WA  {  {WB+1{1'b1}} }};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = '{WA  {  {WB-1{1'b1}} }};  $display("%b", array_bg);
//  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0] = '{WA/2{  {WB  {1'b1}} }};  $display("%b", array_bg);
  $write ("\n");
end
endtask


task test_write_to_array;
begin
  $display("test write to array LHS=RHS");
  array_bg = {WA*WB{1'bx}};                                                              $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg                            = {WA  *WB  +0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0   ]              = {WA/2*WB  +0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1:WA/2]              = {WA/2*WB  +0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ]              = {1   *WB  +0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ]              = {1   *WB  +0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][WB/2-1:0   ] = {1   *WB/2+0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1:WB/2] = {1   *WB/2+0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][       0   ] = {1   *1   +0{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1     ] = {1   *1   +0{1'b1}};  $display("%b", array_bg);
  $display("");

  $display("test write to array LHS<RHS");
  array_bg = {WA*WB{1'bx}};                                                              $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg                            = {WA  *WB  +1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0   ]              = {WA/2*WB  +1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1:WA/2]              = {WA/2*WB  +1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ]              = {1   *WB  +1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ]              = {1   *WB  +1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][WB/2-1:0   ] = {1   *WB/2+1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1:WB/2] = {1   *WB/2+1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][       0   ] = {1   *1   +1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1     ] = {1   *1   +1{1'b1}};  $display("%b", array_bg);
  $display("");

  $display("test write to array LHS>RHS");
  array_bg = {WA*WB{1'bx}};                                                              $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg                            = {WA  *WB  -1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0   ]              = {WA/2*WB  -1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1:WA/2]              = {WA/2*WB  -1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ]              = {1   *WB  -1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ]              = {1   *WB  -1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][WB/2-1:0   ] = {1   *WB/2-1{1'b1}};  $display("%b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1:WB/2] = {1   *WB/2-1{1'b1}};  $display("%b", array_bg);
//array_bg = {WA*WB{1'bx}};  array_bg [       0   ][       0   ] = {1   *1   -1{1'b1}};  $display("%b", array_bg);
//array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1     ] = {1   *1   -1{1'b1}};  $display("%b", array_bg);
  $display("");
end
endtask


task test_read_from_array ();
begin
  // assign a constant value to the array
  array_bg = param_bg;

  $display("test read from array LHS=RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA  *WB  -1+0:0] = array_bg                           ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+0:0] = array_bg [WA/2-1:0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+0:0] = array_bg [WA  -1:WA/2]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+0:0] = array_bg [       0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+0:0] = array_bg [WA  -1     ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+0:0] = array_bg [       0   ][WB/2-1:0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+0:0] = array_bg [WA  -1     ][WB  -1:WB/2];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+0:0] = array_bg [       0   ][       0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+0:0] = array_bg [WA  -1     ][WB  -1     ];  $display("%b", array_1d);
  $display("");

  $display("test read from array LHS>RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA  *WB  -1+1:0] = array_bg                           ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+1:0] = array_bg [WA/2-1:0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+1:0] = array_bg [WA  -1:WA/2]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+1:0] = array_bg [       0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+1:0] = array_bg [WA  -1     ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+1:0] = array_bg [       0   ][WB/2-1:0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+1:0] = array_bg [WA  -1     ][WB  -1:WB/2];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+1:0] = array_bg [       0   ][       0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+1:0] = array_bg [WA  -1     ][WB  -1     ];  $display("%b", array_1d);
  $display("");

  $display("test read from array LHS<RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA  *WB  -1-1:0] = array_bg                           ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1-1:0] = array_bg [WA/2-1:0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1-1:0] = array_bg [WA  -1:WA/2]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1-1:0] = array_bg [       0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1-1:0] = array_bg [WA  -1     ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1-1:0] = array_bg [       0   ][WB/2-1:0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1-1:0] = array_bg [WA  -1     ][WB  -1:WB/2];  $display("%b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1-1:0] = array_bg [       0   ][       0   ];  $display("%b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1-1:0] = array_bg [WA  -1     ][WB  -1     ];  $display("%b", array_1d);
  $display("");
end
endtask


task test_read_from_parameter_array ();
begin
  $display("test read from parameter array LHS=RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA  *WB  -1+0:0] = param_bg                           ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+0:0] = param_bg [WA/2-1:0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+0:0] = param_bg [WA  -1:WA/2]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+0:0] = param_bg [       0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+0:0] = param_bg [WA  -1     ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+0:0] = param_bg [       0   ][WB/2-1:0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+0:0] = param_bg [WA  -1     ][WB  -1:WB/2];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+0:0] = param_bg [       0   ][       0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+0:0] = param_bg [WA  -1     ][WB  -1     ];  $display("%b", array_1d);
  $display("");

  $display("test read from parameter array LHS>RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA  *WB  -1+1:0] = param_bg                           ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+1:0] = param_bg [WA/2-1:0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1+1:0] = param_bg [WA  -1:WA/2]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+1:0] = param_bg [       0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1+1:0] = param_bg [WA  -1     ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+1:0] = param_bg [       0   ][WB/2-1:0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1+1:0] = param_bg [WA  -1     ][WB  -1:WB/2];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+1:0] = param_bg [       0   ][       0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1+1:0] = param_bg [WA  -1     ][WB  -1     ];  $display("%b", array_1d);
  $display("");

  $display("test read from parameter array LHS<RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA  *WB  -1-1:0] = param_bg                           ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1-1:0] = param_bg [WA/2-1:0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA/2*WB  -1-1:0] = param_bg [WA  -1:WA/2]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1-1:0] = param_bg [       0   ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB  -1-1:0] = param_bg [WA  -1     ]             ;  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1-1:0] = param_bg [       0   ][WB/2-1:0   ];  $display("%b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[1   *WB/2-1-1:0] = param_bg [WA  -1     ][WB  -1:WB/2];  $display("%b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1-1:0] = param_bg [       0   ][       0   ];  $display("%b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[1   *1   -1-1:0] = param_bg [WA  -1     ][WB  -1     ];  $display("%b", array_1d);
  $display("");
end
endtask

endmodule
