////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import package_bus::*;
import package_str::*;

module systemverilog_bus_tb ();

parameter SIZ = 256;

// system signals
logic        clk = 1'b1;
logic        rst = 1'b1;

// input bus
logic        bsi_vld;  // valid (chip select)
logic [31:0] bsi_adr;  // address
logic [31:0] bsi_dat;  // data
logic        bsi_rdy;  // ready (acknowledge)
logic        bsi_trn;  // data transfer
logic [31:0] bsi_mem [SIZ];

// output stream
logic        str_vld;
logic  [7:0] str_bus;
logic        str_rdy;
logic        str_trn;  // data transfer

// input bus
logic        bso_vld;  // valid (chip select)
logic [31:0] bso_adr;  // address
logic [31:0] bso_dat;  // data
logic        bso_rdy;  // ready (acknowledge)
logic        bso_trn;  // data transfer
logic [31:0] bso_mem [SIZ];

////////////////////////////////////////////////////////////////////////////////
// clock and reset
////////////////////////////////////////////////////////////////////////////////

// clock togling
always #5  clk = ~clk;

// reset is removed after a delay
initial begin
  repeat (4) @ (posedge clk);
  rst = 0;
end

// reset is removed after a delay
initial begin
  repeat (16) @ (posedge clk);
  $finish();
end

////////////////////////////////////////////////////////////////////////////////
// input data generator
////////////////////////////////////////////////////////////////////////////////

assign bsi_trn = bsi_vld & bsi_rdy;

always @ (posedge clk, posedge clk)
if (rst)          bsi_adr <= 32'h00000000;
else if (bsi_trn) bsi_adr <= bsi_adr + 'd1;

always @ (posedge clk, posedge clk)
if (rst)          bsi_dat <= 32'h00000000;
else if (bsi_trn) bsi_dat <= $random(bsi_dat);

always @ (posedge clk)
if (bsi_trn) bsi_mem [bsi_adr] <= bsi_dat;

////////////////////////////////////////////////////////////////////////////////
// RTL instance
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// output data monitor
////////////////////////////////////////////////////////////////////////////////

assign bso_trn = bso_vld & bso_rdy;

always @ (posedge clk, posedge clk)
if (rst)          bso_adr <= 32'h00000000;
else if (bso_trn) bso_adr <= bso_adr + 'd1;

always @ (posedge clk, posedge clk)
if (rst)          bso_dat <= 32'h00000000;
else if (bso_trn) bso_dat <= $random(bsi_dat);

always @ (posedge clk)
if (bso_trn) bso_mem [bso_adr] <= bso_dat;

endmodule : systemverilog_bus_tb
