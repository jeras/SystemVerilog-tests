////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// This file is placed into the Public Domain, for any use, without warranty. //
// 2012 by Iztok Jeras                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import package_bus::*;
import package_str::*;

module sv_bus_mux_demux_mux (
  // system signals
  input  logic        clk,
  input  logic        rst,
  // input bus
  input  logic        bus_vld,  // valid (chip select)
  input  logic [31:0] bus_adr,  // address
  input  logic [31:0] bus_dat,  // data
  output logic        bus_rdy,  // ready (acknowledge)
  // output stream
  output logic        str_vld,
  output logic  [7:0] str_bus,
  input  logic        str_rdy
);

logic       bus_trn;
logic       str_trn;

logic [2:0] pkt_cnt;
logic       pkt_end;

t_bus       pkt_bus;
t_str       pkt_str;

assign bus_trn = bus_vld & bus_rdy;

assign bus_rdy = ~str_vld | pkt_end;

always @ (posedge clk)
if (bus_trn) begin
  pkt_bus.adr <= bus_adr;
  pkt_bus.dat <= bus_dat;
end

assign pkt_str = pkt_bus;

always @ (posedge clk, posedge rst)
if (rst)           str_vld <= 1'b0;
else               str_vld <= bus_trn | (str_vld & ~pkt_end);

always @ (posedge clk, posedge rst)
if (rst)           pkt_cnt <= 4'd0;
else if (str_trn)  pkt_cnt <= pkt_cnt + 3'd1;

assign pkt_end = str_rdy & (&pkt_cnt);

assign str_bus = pkt_str [pkt_cnt];

assign str_trn = str_vld & str_rdy;

endmodule : sv_bus_mux_demux_mux
