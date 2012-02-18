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
  test_write_to_array;
  test_read_from_array;
  test_read_from_parameter_array;
//  test_signed_array;
end


task print_array (
  input logic [WA*WB:0] vector_data,
  input integer         vector_size
);
  integer i;
begin
  $write ("%0d'b", vector_size);
  for (i=vector_size; i>0; i=i-1)
    $write ("%b", vector_data[i-1]);
  $write ("\n");
end
endtask


task test_write_to_array;
begin
  $display("test write to array LHS=RHS");
  array_bg = {WA*WB{1'bx}};                                                              print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg                            = {WA  *WB  +0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0   ]              = {WA/2*WB  +0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1:WA/2]              = {WA/2*WB  +0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ]              = {1   *WB  +0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ]              = {1   *WB  +0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][WB/2-1:0   ] = {1   *WB/2+0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1:WB/2] = {1   *WB/2+0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][       0   ] = {1   *1   +0{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1     ] = {1   *1   +0{1'b1}};  print_array(array_bg, WA*WB);
  $display("");

  $display("test write to array LHS<RHS");
  array_bg = {WA*WB{1'bx}};                                                              print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg                            = {WA  *WB  +1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0   ]              = {WA/2*WB  +1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1:WA/2]              = {WA/2*WB  +1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ]              = {1   *WB  +1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ]              = {1   *WB  +1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][WB/2-1:0   ] = {1   *WB/2+1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1:WB/2] = {1   *WB/2+1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][       0   ] = {1   *1   +1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1     ] = {1   *1   +1{1'b1}};  print_array(array_bg, WA*WB);
  $display("");

  $display("test write to array LHS>RHS");
  array_bg = {WA*WB{1'bx}};                                                              print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg                            = {WA  *WB  -1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA/2-1:0   ]              = {WA/2*WB  -1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1:WA/2]              = {WA/2*WB  -1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ]              = {1   *WB  -1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ]              = {1   *WB  -1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [       0   ][WB/2-1:0   ] = {1   *WB/2-1{1'b1}};  print_array(array_bg, WA*WB);
  array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1:WB/2] = {1   *WB/2-1{1'b1}};  print_array(array_bg, WA*WB);
//array_bg = {WA*WB{1'bx}};  array_bg [       0   ][       0   ] = {1   *1   -1{1'b1}};  print_array(array_bg, WA*WB);
//array_bg = {WA*WB{1'bx}};  array_bg [WA  -1     ][WB  -1     ] = {1   *1   -1{1'b1}};  print_array(array_bg, WA*WB);
  $display("");
end
endtask


task test_read_from_array ();
begin
  // assign a constant value to the array
  array_bg = param_bg;

  $display("test read from array LHS=RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1+0:0] = array_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1+0:0] = array_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1+0:0] = array_bg [3:2]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1+0:0] = array_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1+0:0] = array_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");

  $display("test read from array LHS>RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1+1:0] = array_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1+1:0] = array_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1+1:0] = array_bg [3:2]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1+1:0] = array_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1+1:0] = array_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");

  $display("test read from array LHS<RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1-1:0] = array_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1-1:0] = array_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1-1:0] = array_bg [3:2]     ;  $display("%065b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1-1:0] = array_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1-1:0] = array_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");
end
endtask


task test_read_from_parameter_array ();
begin
  $display("test read from parameter array LHS=RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1+0:0] = param_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1+0:0] = param_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1+0:0] = param_bg [3:2]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1+0:0] = param_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1+0:0] = param_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");

  $display("test read from parameter array LHS>RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1+1:0] = param_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1+1:0] = param_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1+1:0] = param_bg [3:2]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1+1:0] = param_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1+1:0] = param_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");

  $display("test read from parameter array LHS<RHS");
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1-1:0] = param_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1-1:0] = param_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1-1:0] = param_bg [3:2]     ;  $display("%065b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1-1:0] = param_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1-1:0] = param_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");
end
endtask

endmodule
