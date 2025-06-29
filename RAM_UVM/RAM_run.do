vlib work
vlog  project_ram.v RAM_Golden.v RAM_assertions.sv Top_module.sv RAM_test.sv RAM_agent.sv RAM_config_obj.sv RAM_coverage.sv RAM_driver.sv RAM_env.sv RAM_interface.sv RAM_monitor.sv RAM_scoreboard.sv RAM_seq_item.sv RAM_sequence.sv RAM_sequencer.sv   +cover -covercells
vsim -voptargs=+acc work.Top_module -classdebug -uvmcontrol=all -cover
add wave /uvm_pkg::uvm_reg_map::do_write/#ublk#215181159#1731/immed__1735 /uvm_pkg::uvm_reg_map::do_read/#ublk#215181159#1771/immed__1775 /RAM_seq_pkg::RAM_seq::body/#ublk#160499319#20/immed__24 /Top_module/DUT/SPI_AS/reset_assertion /Top_module/DUT/SPI_AS/a_tx_check_high /Top_module/DUT/SPI_AS/a_tx_check_low
add wave Top_module/RAM_intf0/*
add wave Top_module/RAM_golden_intf/*
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/sb/correct_counter \
sim:/uvm_root/uvm_test_top/env/sb/error_counter
coverage save ram.ucdb -onexit
run -all
//quit -sim
//vcover report ram.ucdb -details -annotate -all -output ram_coverage_rpt.txt 

