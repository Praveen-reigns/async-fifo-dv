
# Compilation
#vlib work
#vmap work work

vlog -cover bcst list.svh \
+incdir+C:/questasim64_10.7c/verilog_src/uvm-1.2/src

# Elaboration + Simulation
vsim -coverage work.top \
-novopt -suppress 12110 \
-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
+UVM_TESTNAME=fifo_wr_rd_top_test

# Waves
add wave -r sim:/top/*

# Run
run -all

# Save coverage
coverage save -onexit fifo_wr_rd_top_test.ucdb
