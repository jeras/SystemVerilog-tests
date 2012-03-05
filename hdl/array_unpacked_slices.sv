module test;
logic [0:0][3:0][2:0][1:0] a;
logic [3:0][3:0][2:0][1:0] b;
initial
begin
  $display ("T1. Dimensions of a      are %0d", $dimensions(a     ));
  $display ("T2. Dimensions of a[0]   are %0d", $dimensions(a[0]  ));
  $display ("T3. Dimensions of b      are %0d", $dimensions(b     ));
  $display ("T4. Dimensions of b[0]   are %0d", $dimensions(b[0]  ));
  $display ("T5. Dimensions of b[0:0] are %0d", $dimensions(b[0:0]));
  $display ("T6. Dimensions of b[1:0] are %0d", $dimensions(b[1:0]));
end
endmodule
