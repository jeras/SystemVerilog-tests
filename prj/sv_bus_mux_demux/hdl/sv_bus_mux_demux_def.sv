////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty. //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

// definition of data bus structure
package package_bus;
  typedef struct packed {
    logic [3:0] [7:0] adr;  // address
    logic [3:0] [7:0] dat;  // data
  } t_bus;
endpackage : package_bus

// definition of streaming bus packet as an array
package package_str;
  typedef logic [7:0][7:0] t_str;
endpackage : package_str
