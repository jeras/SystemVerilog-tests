#!/bin/sh

irun -64bit -access +r -input sv_bus_mux_demux_ncsim.tcl \
sv_bus_mux_demux_def.sv \
sv_bus_mux_demux_tb.sv \
sv_bus_mux_demux_wrap.sv \
sv_bus_mux_demux_mux.sv \
sv_bus_mux_demux_demux.sv

#irun -64bit -access +r -input sv_bus_mux_demux_ncsim.tcl \
#sv_bus_mux_demux_tb.sv \
#altera_primitives.v \
#stratixiv_atoms.v \
#-v stratix4/stratix4.vqm
