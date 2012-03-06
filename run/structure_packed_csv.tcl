database -open waves -vcd -into wav.csv
probe -create -database waves structure_packed_csv_tb -all -depth all -memories -tasks
run
