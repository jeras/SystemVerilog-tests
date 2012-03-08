////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

import package_bus::*;
import package_str::*;

module systemverilog_bus_tb ();

parameter SIZ = 10;

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
logic        sto_vld;
logic  [7:0] sto_bus;
logic        sto_rdy;

// input stream
logic        sti_vld;
logic  [7:0] sti_bus;
logic        sti_rdy;
// output bus
logic        bso_vld;  // valid (chip select)
logic [31:0] bso_adr;  // address
logic [31:0] bso_dat;  // data
logic        bso_rdy;  // ready (acknowledge)
logic        bso_trn;  // data transfer
logic [31:0] bso_mem [SIZ];

integer cnt = 0;

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
  wait (cnt == SIZ);
  repeat (4) @ (posedge clk);
  if (bsi_mem === bso_mem)  $display ("PASSED");
  else                      $display ("FAILED");
  for (cnt=0; cnt<SIZ; cnt=cnt+1)
    $display ("@%08h i:%08h o:%08h", cnt, bsi_mem [cnt], bso_mem [cnt]);
  $stop();
end

////////////////////////////////////////////////////////////////////////////////
// input data generator
////////////////////////////////////////////////////////////////////////////////

assign bsi_trn = bsi_vld & bsi_rdy;

always @ (posedge clk, posedge rst)
if (rst)          bsi_vld = 1'b0;
else              bsi_vld = (bsi_adr < SIZ);

always @ (posedge clk, posedge rst)
if (rst)          bsi_adr <= 32'h00000000;
else if (bsi_trn) bsi_adr <= bsi_adr + 'd1;

always @ (posedge clk, posedge rst)
if (rst)          bsi_dat <= 32'h00000000;
else if (bsi_trn) bsi_dat <= $random();

always @ (posedge clk)
if (bsi_trn) bsi_mem [bsi_adr] <= bsi_dat;

////////////////////////////////////////////////////////////////////////////////
// RTL instance
////////////////////////////////////////////////////////////////////////////////

systemverilog_bus_wrap wrap (
  // system signals
  .clk      (clk),
  .rst      (rst),
  // input bus
  .bsi_vld  (bsi_vld),
  .bsi_adr  (bsi_adr),
  .bsi_dat  (bsi_dat),
  .bsi_rdy  (bsi_rdy),
  // output stream
  .sto_vld  (sto_vld),
  .sto_bus  (sto_bus),
  .sto_rdy  (sto_rdy),
  // input stream
  .sti_vld  (sti_vld),
  .sti_bus  (sti_bus),
  .sti_rdy  (sti_rdy),
  // output bus
  .bso_vld  (bso_vld),
  .bso_adr  (bso_adr),
  .bso_dat  (bso_dat),
  .bso_rdy  (bso_rdy)
);

assign sti_vld = sto_vld;
assign sti_bus = sto_bus;
assign sto_rdy = sti_rdy;

////////////////////////////////////////////////////////////////////////////////
// output data monitor
////////////////////////////////////////////////////////////////////////////////

assign bso_trn = bso_vld & bso_rdy;

always @ (posedge clk, posedge rst)
if (rst)          cnt <= 0;
else if (bso_trn) cnt <= cnt + 1;

always @ (posedge clk)
if (bso_trn) bso_mem [bso_adr] <= bso_dat;

always @ (posedge clk, posedge rst)
if (rst)  bso_rdy = 1'b0;
else      bso_rdy = 1'b1;

endmodule : systemverilog_bus_tb
