module array_string #(
  // parameters for array sizes
  parameter WS = 8  // string length
)();

localparam string ARRAY_S0 = "Janez Novak";

// ASCII text strings
string string_s1;
string string_s2 = "Hello, world!";

// arrays
bit   [0:WS-1][7:0] array_bit;
logic [0:WS-1][7:0] array_logic;

initial begin
  test_string_array;
  test_string_compare;
  test_string_methods;
end

task test_string_array;
  integer i;
begin
  // assigning a value to a string and display it
  string_s1 = "Test of strings as arrays.";
  $write ("test string is: \"%s\"\n", string_s1);
  // print to a string and display it
  $swrite (string_s1, "integer=%d, hex=%h, binary=%b", 13, 13, 13);
  $write ("test string is: \"%s\"\n", string_s1);
  // implicit cast of bit into string (same 2-level type)
  array_bit = 64'h3031323334353637;
  string_s1 = array_bit;
  $write ("test string is: \"%s\"\n", string_s1);
  // implicit cast of bit into string (different 4-level type)
  array_logic = 64'h3031323334353637;
  string_s1 = array_logic;
  $write ("test string is: \"%s\"\n", string_s1);
  // explicit cast of bit into string (different 4-level type)
  array_logic = 64'h3031323334353637;
  string_s1 = string'(array_logic);
  $write ("test string is: \"%s\"\n", string_s1);
  // concatenation
  string_s1 = {ARRAY_S0, " ", string_s2, " ", 64'h3031323334353637};
  $write ("test string is: \"%s\"\n", string_s1);
  // replication
  string_s1 = {3{string_s2, " "}};
  $write ("test string is: \"%s\"\n", string_s1);
  // index putc
  string_s1 = string_s2;
  string_s1[12] = "?.";
  $write ("test string is: \"%s\"\n", string_s1);
  string_s1 = string_s2;
  string_s1[12] = 16'h3f2e;
  $write ("test string is: \"%s\"\n", string_s1);
  // index getc
  $write ("test string is: \"%s\" \"%s\"\n", ARRAY_S0[0], ARRAY_S0[10]);
  $write ("test string is: \"%s\" \"%s\"\n", string_s2[0], string_s2[12]);
end
endtask

task test_string_compare;
begin
  $write ("equality:          \"%s\" == \"%s\" => %b\n", ARRAY_S0, string_s2, ARRAY_S0 == string_s2);
  $write ("inequality:        \"%s\" != \"%s\" => %b\n", ARRAY_S0, string_s2, ARRAY_S0 != string_s2);
  $write ("smaller:           \"%s\" <  \"%s\" => %b\n", ARRAY_S0, string_s2, ARRAY_S0 <  string_s2);
  $write ("smaller or equal:  \"%s\" <= \"%s\" => %b\n", ARRAY_S0, string_s2, ARRAY_S0 <= string_s2);
  $write ("greater:           \"%s\" >  \"%s\" => %b\n", ARRAY_S0, string_s2, ARRAY_S0 >  string_s2);
  $write ("greater or equal:  \"%s\" >= \"%s\" => %b\n", ARRAY_S0, string_s2, ARRAY_S0 >= string_s2);
end
endtask

task test_string_methods;
begin
  // len
  $write ("len:        %0d\n", ARRAY_S0.len());
  // putc
  string_s1 = string_s2;
  string_s1.putc(12,"?.");
  $write ("putc:       \"%s\"\n", string_s1);
  string_s1 = string_s2;
  string_s1.putc(12, 16'h3f2e);
  $write ("putc:       \"%s\"\n", string_s1);
  // getc
  $write ("getc(0,12): \"%s\" \"%s\"\n", ARRAY_S0[0], ARRAY_S0[10]);
  $write ("getc(0,12): \"%s\" \"%s\"\n", string_s2[0], string_s2[12]);
  // toupper
  $write ("toupper:    \"%s\"\n", ARRAY_S0.toupper());
  // tolower
  $write ("tolower:    \"%s\"\n", ARRAY_S0.tolower());
  // compare
  $write ("compare:    %0d\n", ARRAY_S0.compare("Janez Novak"));
  $write ("compare:    %0d\n", ARRAY_S0.compare("janez novak"));
  $write ("icompare:   %0d\n", ARRAY_S0.icompare("janez novak"));
end
endtask

endmodule
