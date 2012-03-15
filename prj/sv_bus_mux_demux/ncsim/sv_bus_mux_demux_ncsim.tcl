database -open waves -shm -into wav
probe -create -database waves sv_bus_mux_demux_tb -all -depth all -memories -tasks
run
