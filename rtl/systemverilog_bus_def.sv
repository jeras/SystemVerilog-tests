////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

package package_bus;
  typedef struct packed {
//    logic [3:0] [7:0] adr;  // address
//    logic [3:0] [7:0] dat;  // data
    logic [31:0] dat;  // data
    logic [31:0] adr;  // address
  } t_bus;
endpackage : package_bus


package package_str;
  typedef logic [7:0][7:0] t_str;
endpackage : package_str
