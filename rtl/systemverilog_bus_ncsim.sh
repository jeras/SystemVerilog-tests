#!/bin/sh

irun -64bit -access +r -input systemverilog_bus_ncsim.tcl \
systemverilog_bus_def.sv \
systemverilog_bus_tb.sv \
systemverilog_bus_wrap.sv \
systemverilog_bus_mux.sv \
systemverilog_bus_demux.sv

irun -64bit -access +r -input systemverilog_bus_ncsim.tcl \
systemverilog_bus_tb.sv \
altera_primitives.v \
stratixiv_atoms.v \
-v stratix4/stratix4.vqm
