////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module enumeration #(
)();

// anonymous type variable declaration
enum {zero, one, two, three, four, five, six, seven}    numbers;
enum {red, orange, yellow, green, blue, indigo, violet} rainbow7;

// named type
typedef enum bit {OFF, ON} t_switch;
t_switch switch;

// numbering examples
enum int {father, mother, son[2], daughter, gerbil, dog[3]=10, cat[3:5]=20, car[3:1]=30} family;

`ifdef ENUMERATION_SYNTAX_ERROR
`endif


initial begin
  test_methods;
end


task test_methods;
  int i;
begin
  $write ("numbers.num   = %d\n", numbers.num  ());
  $write ("numbers.first = %d\n", numbers.first());
  $write ("numbers.last  = %d\n", numbers.last ());
  numbers = numbers.first();
  for (i=0; i<=numbers.num(); i=i+1) begin
    $write ("  %s = %0d\n",  numbers.name(),  numbers);
    numbers = numbers.next();
  end
  numbers = numbers.last();
  for (i=0; i<=numbers.num(); i=i+1) begin
    $write ("  %s = %0d\n",  numbers.name(),  numbers);
    numbers = numbers.prev();
  end

  $write ("rainbow7.num   = %d\n", rainbow7.num  ());
  $write ("rainbow7.first = %d\n", rainbow7.first());
  $write ("rainbow7.last  = %d\n", rainbow7.last ());
  rainbow7 = rainbow7.first();
  for (i=0; i<=rainbow7.num(); i=i+1) begin
    $write ("  %s = %0d\n",  rainbow7.name(),  rainbow7);
    rainbow7 = rainbow7.next();
  end
  rainbow7 = rainbow7.last();
  for (i=0; i<=rainbow7.num(); i=i+1) begin
    $write ("  %s = %0d\n",  rainbow7.name(),  rainbow7);
    rainbow7 = rainbow7.prev();
  end

  $write ("switch.num   = %d\n", switch.num  ());
  $write ("switch.first = %d\n", switch.first());
  $write ("switch.last  = %d\n", switch.last ());
  switch = switch.first();
  for (i=0; i<=switch.num(); i=i+1) begin
    $write ("  %s = %0d\n",  switch.name(),  switch);
    switch = switch.next();
  end
  switch = switch.last();
  for (i=0; i<=switch.num(); i=i+1) begin
    $write ("  %s = %0d\n",  switch.name(),  switch);
    switch = switch.prev();
  end

  $write ("family.num   = %d\n", family.num  ());
  $write ("family.first = %d\n", family.first());
  $write ("family.last  = %d\n", family.last ());
  family = family.first();
  for (i=0; i<=family.num(); i=i+1) begin
    $write ("  %s = %0d\n",  family.name(),  family);
    family = family.next();
  end
  family = family.last();
  for (i=0; i<=family.num(); i=i+1) begin
    $write ("  %s = %0d\n",  family.name(),  family);
    family = family.prev();
  end
end
endtask

endmodule : enumeration
