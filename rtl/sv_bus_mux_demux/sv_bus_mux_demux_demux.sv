////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty, //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import package_bus::*;
import package_str::*;

module systemverilog_bus_demux (
  // system signals
  input  logic        clk,
  input  logic        rst,
  // output stream
  input  logic        str_vld,
  input  logic  [7:0] str_bus,
  output logic        str_rdy,
  // input bus
  output logic        bus_vld,  // valid (chip select)
  output logic [31:0] bus_adr,  // address
  output logic [31:0] bus_dat,  // data
  input  logic        bus_rdy   // ready (acknowledge)
);

logic       bus_trn;
logic       str_trn;

logic [2:0] pkt_cnt;
logic       pkt_end;

t_str       pkt_str;
t_bus       pkt_bus;

assign str_trn = str_vld & str_rdy;

assign str_rdy = ~bus_vld | bus_rdy;

always @ (posedge clk, posedge rst)
if (rst)           pkt_cnt <= 3'd0;
else if (str_trn)  pkt_cnt <= pkt_cnt + 3'd1;

assign pkt_end = (&pkt_cnt);

always @ (posedge clk)
if (str_trn)  pkt_str [pkt_cnt] <= str_bus;

assign pkt_bus = pkt_str;
assign bus_adr = pkt_bus.adr;
assign bus_dat = pkt_bus.dat;

always @ (posedge clk, posedge rst)
if (rst)  bus_vld <= 1'b0;
else      bus_vld <= str_trn & pkt_end | bus_vld & ~bus_rdy;

assign bus_trn = bus_vld & bus_rdy;

endmodule : systemverilog_bus_demux
