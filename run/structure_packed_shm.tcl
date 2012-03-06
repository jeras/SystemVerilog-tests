database -open waves -shm -into wav
probe -create -database waves structure_packed_csv_tb -all -depth all -memories -tasks
run
