database -open waves_shm -shm -into wav
probe -create -database waves_shm structure_packed_wave_tb -all -depth all -memories -tasks
database -open waves_vcd -vcd -into wav.vcd
probe -create -database waves_vcd structure_packed_wave_tb -all -depth all -tasks
run
