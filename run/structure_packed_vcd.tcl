database -open waves -vcd -into wav.vcd
probe -create -database waves structure_packed_wave_tb -all -depth all -memories -tasks
run
