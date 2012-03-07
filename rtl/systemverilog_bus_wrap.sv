////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module systemverilog_bus_wrap (
  // system signals
  input  logic        clk,
  input  logic        rst,
  // input bus
  input  logic        bsi_vld,  // valid (chip select)
  input  logic [31:0] bsi_adr,  // address
  input  logic [31:0] bsi_dat,  // data
  output logic        bsi_rdy,  // ready (acknowledge)
  // stream
  output logic        str_vld,
  output logic  [7:0] str_bus,
  output logic        str_rdy,
  // output bus
  output logic        bso_vld,  // valid (chip select)
  output logic [31:0] bso_adr,  // address
  output logic [31:0] bso_dat,  // data
  input  logic        bso_rdy   // ready (acknowledge)
);

systemverilog_bus_mux mux (
  // system signals
  .clk      (clk),
  .rst      (rst),
  // input bus
  .bus_vld  (bsi_vld),
  .bus_adr  (bsi_adr),
  .bus_dat  (bsi_dat),
  .bus_rdy  (bsi_rdy),
  // output stream
  .str_vld  (str_vld),
  .str_bus  (str_bus),
  .str_rdy  (str_rdy)
);

systemverilog_bus_demux demux (
  // system signals
  .clk      (clk),
  .rst      (rst),
  // input stream
  .str_vld  (str_vld),
  .str_bus  (str_bus),
  .str_rdy  (str_rdy),
  // output bus
  .bus_vld  (bso_vld),
  .bus_adr  (bso_adr),
  .bus_dat  (bso_dat),
  .bus_rdy  (bso_rdy)
);

endmodule : systemverilog_bus_wrap
