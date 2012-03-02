////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

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
logic [0:WB-1] array_im     [WA], rfrnc_im     [WA];  // implicit endian array (little)


initial begin
  test_array_querying;
  test_array_readmemb(WA+1, WB  );
  test_array_readmemb(WA-1, WB  );
  test_array_readmemb(WA  , WB  );
  test_array_readmemb(WA  , WB-1);
  test_array_readmemb(WA  , WB+1);
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
  n = $dimensions (array_im);
  $write ("$bits      (array_im) = %d\n", $bits(array_im));
  $write ("$dimensions(array_im) = %d\n", n);
  $write ("$left      (array_im) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $left      (array_im, i));  $write ("\n");
  $write ("$right     (array_im) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $right     (array_im, i));  $write ("\n");
  $write ("$low       (array_im) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $low       (array_im, i));  $write ("\n");
  $write ("$high      (array_im) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $high      (array_im, i));  $write ("\n");
  $write ("$increment (array_im) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $increment (array_im, i));  $write ("\n");
  $write ("$size      (array_im) =");  for (i=1; i<=n; i=i+1)  $write (" %d", $size      (array_im, i));  $write ("\n");
  $write ("\n");
end
endtask


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
  $display("NOTE: test readmemb (%03d x %03d) into array (%03d x %03d) big    endian", wa, wb, WA, WB);
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

  // little endian
  $display("NOTE: test readmemb (%03d x %03d) into array (%03d x %03d) little endian", wa, wb, WA, WB);
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

  // implicit endian
  $display("NOTE: test readmemb (%03d x %03d) into array (%03d x %03d) implicit endian", wa, wb, WA, WB);
  // clear and polulate reference array
  for (a=0; a<WA; a=a+1)  array_im [a] = {WB{1'bx}};
  for (a=0; a<WA; a=a+1)  rfrnc_im [a] = {WB{1'bx}};
  for (a=0; a<wa; a=a+1)  rfrnc_im [a] = a;
  // access file
  $readmemb  ({filename       }, array_im);
  $writememb ({filename, ".lt"}, array_im);
  // compare array against reference
  if (array_im === rfrnc_im)  $display ("PASSED");
  else                        $display ("FAILED");
end
endtask

endmodule
