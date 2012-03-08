database -open waves -shm -into wav
probe -create -database waves systemverilog_bus_tb -all -depth all -memories -tasks
run
