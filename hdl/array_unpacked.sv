module array_unpacked #(
  // parameters for array sizes
  parameter WA = 8,  // address dimension size
  parameter WB = 8   // bit     dimension size
)();

// 2D unpacked array parameters
//localparam [WB-1:0] param_bg [WA-1:0] = `{0,1,2,3,4,5,6,7};
//localparam [0:WB-1] param_lt [0:WA-1] = `{0,1,2,3,4,5,6,7};

// 2D unpacked arrays
logic        [WB-1:0] array_bg [WA-1:0];  // big endian array
logic        [0:WB-1] array_lt [0:WA-1];  // little endian array
logic signed [WB-1:0] array_sg [WA-1:0];  // signed big endian array

integer txt_file;
integer i;

initial begin
  test_create_txt_files;
  test_array_readmemb;
//  test_signed_array;
end


task test_create_txt_files();
  integer a, b;
begin
  // LHS=RHS
  txt_file = $fopen("array_packed.wb_p0.txt", "w");
  for (a=0; a<WA; a=a+1) begin
    for (b=0; b<WB  ; b=b+1)  $fwrite(txt_file, "%b", a[WB  -b-1]);
    if  (a != WA-1)           $fwrite(txt_file, "\n");
  end
  $fclose(txt_file);
  // LHS<RHS
  txt_file = $fopen("array_packed.wb_p1.txt", "w");
  for (a=0; a<WA; a=a+1) begin
    for (b=0; b<WB+1; b=b+1)  $fwrite(txt_file, "%b", a[WB+1-b-1]);
    if  (a != WA-1)           $fwrite(txt_file, "\n");
  end
  $fclose(txt_file);
  // LHS=RHS
  txt_file = $fopen("array_packed.wb_m1.txt", "w");
  for (a=0; a<WA; a=a+1) begin
    for (b=0; b<WB-1; b=b+1)  $fwrite(txt_file, "%b", a[WB-1-b-1]);
    if  (a != WA-1)           $fwrite(txt_file, "\n");
  end
  $fclose(txt_file);
end
endtask


task test_array_readmemb;
  integer a, b;
begin
  // LHS=RHS
  $display("test readmemb into big endian array LHS=RHS");
  $readmemb  ("array_packed.wb_p0.txt"   , array_bg);
  $writememb ("array_packed.wb_p0.rw.txt", array_bg);
end
endtask


endmodule
