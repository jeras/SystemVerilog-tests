module array_packed #(
  parameter WA = 8,
  parameter WB = 8
)();

logic        [WA-1:0] [WB-1:0] array_bg;  // big endian array
logic        [0:WA-1] [0:WB-1] array_lt;  // little endian array
logic                [WA*WB:0] array_1d;  // 1D array
logic signed [WA-1:0] [WB-1:0] array_sg;  // signed big endian array

initial begin
  $display("test write to array LHS=RHS");
  array_bg = {WA*WB{1'bx}};                                          $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = {WA*WB+0{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  0]      = { 1*WB+0{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [3:2]      = { 2*WB+0{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  5][  4] = { 1* 1+0{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  6][7:4] = { 1* 4+0{1'b1}};  $display("%064b", array_bg);
  $display("");

  $display("test write to array LHS<RHS");
  array_bg = {WA*WB{1'bx}};                                          $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = {WA*WB+1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  0]      = { 1*WB+1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [3:2]      = { 2*WB+1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  5][  4] = { 1* 1+1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  6][7:4] = { 1* 4+1{1'b1}};  $display("%064b", array_bg);
  $display("");

  $display("test write to array LHS>RHS");
  array_bg = {WA*WB{1'bx}};                                          $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg            = {WA*WB-1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  0]      = { 1*WB-1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [3:2]      = { 2*WB-1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  5][  4] = { 1* 1-1{1'b1}};  $display("%064b", array_bg);
  array_bg = {WA*WB{1'bx}};  array_bg [  6][7:4] = { 1* 4-1{1'b1}};  $display("%064b", array_bg);
  $display("");


  $display("test read from array LHS=RHS");
  array_bg = {WA*WB  {1'b1}};                                                $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1+0:0] = array_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1+0:0] = array_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1+0:0] = array_bg [3:2]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1+0:0] = array_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1+0:0] = array_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");

  $display("test read from array LHS>RHS");
  array_bg = {WA*WB  {1'b1}};                                                $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1+1:0] = array_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1+1:0] = array_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1+1:0] = array_bg [3:2]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1+1:0] = array_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1+1:0] = array_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");

  $display("test read from array LHS<RHS");
  array_bg = {WA*WB  {1'b1}};                                                $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[WA*WB-1-1:0] = array_bg           ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1*WB-1-1:0] = array_bg [  0]     ;  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 2*WB-1-1:0] = array_bg [3:2]     ;  $display("%065b", array_1d);
//array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 1-1-1:0] = array_bg [  5][  4];  $display("%065b", array_1d);
  array_1d = {WA*WB+1{1'bx}};  array_1d[ 1* 4-1-1:0] = array_bg [  6][7:4];  $display("%065b", array_1d);
  $display("");


//  $display("test read from array LHS<RHS");
//  array_sg
end

endmodule
