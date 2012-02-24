module array_unpacked #(
  // parameters for array sizes
  parameter WA = 8,  // address dimension size
  parameter WB = 8   // bit     dimension size
)();

// 2D unpacked array parameters
//localparam [WB-1:0] param_bg [WA-1:0] = `{0,1,2,3,4,5,6,7};
//localparam [0:WB-1] param_lt [0:WA-1] = `{0,1,2,3,4,5,6,7};

// 2D unpacked arrays (test and reference)
logic [WB-1:0] array_bg [WA-1:0], rfrnc_bg [WA-1:0];  // big endian array
logic [0:WB-1] array_lt [0:WA-1], rfrnc_lt [0:WA-1];  // little endian array


initial begin
  test_array_readmemb(WA+1, WB  );
  test_array_readmemb(WA-1, WB  );
  test_array_readmemb(WA  , WB  );
  test_array_readmemb(WA  , WB-1);
  test_array_readmemb(WA  , WB+1);
end

task test_array_readmemb (
  input integer wa, wb
);
  integer a, b;
  integer txt_file;
  logic [64*8-1:0] filename;
begin
  // create reference file
  $swrite (filename, "array_unpacked_%03d_x_%03d.txt", wa, wb);
  txt_file = $fopen(filename, "w");
  for (a=0; a<wa; a=a+1) begin
    for (b=0; b<wb; b=b+1)  $fwrite(txt_file, "%b", a[wb-b-1]);
    $fwrite(txt_file, "\n");
  end
  $fclose(txt_file);
  
  // big endian
  $display("test readmemb (%03d x %03d) into array (%03d x %03d) big    endian", wa, wb, WA, WB);
  // clear and polulate reference array
  for (a=0; a<WA; a=a+1)  array_bg [a] = {WB{1'bx}};
  for (a=0; a<WA; a=a+1)  rfrnc_bg [a] = {WB{1'bx}};
  for (a=0; a<wa; a=a+1)  rfrnc_bg [a] = a;
  // access file
  $readmemb  ({filename       }, array_bg);
  $writememb ({filename, ".bg"}, array_bg);
  // compare array against reference
  if (array_bg === rfrnc_bg)  $display ("PASSED");
  else                        $display ("FAILED");

  // big endian
  $display("test readmemb (%03d x %03d) into array (%03d x %03d) little endian", wa, wb, WA, WB);
  // clear and polulate reference array
  for (a=0; a<WA; a=a+1)  array_lt [a] = {WB{1'bx}};
  for (a=0; a<WA; a=a+1)  rfrnc_lt [a] = {WB{1'bx}};
  for (a=0; a<wa; a=a+1)  rfrnc_lt [a] = a;
  // access file
  $readmemb  ({filename       }, array_lt);
  $writememb ({filename, ".lt"}, array_lt);
  // compare array against reference
  if (array_lt === rfrnc_lt)  $display ("PASSED");
  else                        $display ("FAILED");
end
endtask

endmodule
