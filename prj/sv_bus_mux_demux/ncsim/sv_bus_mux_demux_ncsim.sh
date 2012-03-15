#!/bin/sh

irun -64bit -access +r -input sv_bus_mux_demux_ncsim.tcl \
../hdl/sv_bus_mux_demux_def.sv \
../hdl/sv_bus_mux_demux_tb.sv \
../hdl/sv_bus_mux_demux_wrap.sv \
../hdl/sv_bus_mux_demux_mux.sv \
../hdl/sv_bus_mux_demux_demux.sv

irun -64bit -access +r -input sv_bus_mux_demux_ncsim.tcl \
../hdl/sv_bus_mux_demux_tb.sv \
../hdl/altera_primitives.v \
../hdl/stratixiv_atoms.v \
-v ../synplify/stratix4/stratix4.vqm
