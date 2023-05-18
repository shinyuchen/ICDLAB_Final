###############################################################
#  Generated by:      Cadence Innovus 17.11-s080_1
#  OS:                Linux x86_64(Host ID cad21)
#  Generated on:      Thu May 18 18:31:41 2023
#  Design:            CPU
#  Command:           saveDesign DBS/place
###############################################################
current_design CPU
create_clock [get_ports {clk_i}]  -name clk_i -period 15.000000 -waveform {0.000000 7.500000}
set_drive 0.1  [get_ports {clk_i}]
set_max_fanout 10  [get_ports {clk_i}]
set_drive 0.1  [get_ports {DataOrReg}]
set_max_fanout 10  [get_ports {DataOrReg}]
set_drive 0.1  [get_ports {address[4]}]
set_max_fanout 10  [get_ports {address[4]}]
set_drive 0.1  [get_ports {address[3]}]
set_max_fanout 10  [get_ports {address[3]}]
set_drive 0.1  [get_ports {address[2]}]
set_max_fanout 10  [get_ports {address[2]}]
set_drive 0.1  [get_ports {address[1]}]
set_max_fanout 10  [get_ports {address[1]}]
set_drive 0.1  [get_ports {address[0]}]
set_max_fanout 10  [get_ports {address[0]}]
set_drive 0.1  [get_ports {instr_i[7]}]
set_max_fanout 10  [get_ports {instr_i[7]}]
set_drive 0.1  [get_ports {instr_i[6]}]
set_max_fanout 10  [get_ports {instr_i[6]}]
set_drive 0.1  [get_ports {instr_i[5]}]
set_max_fanout 10  [get_ports {instr_i[5]}]
set_drive 0.1  [get_ports {instr_i[4]}]
set_max_fanout 10  [get_ports {instr_i[4]}]
set_drive 0.1  [get_ports {instr_i[3]}]
set_max_fanout 10  [get_ports {instr_i[3]}]
set_drive 0.1  [get_ports {instr_i[2]}]
set_max_fanout 10  [get_ports {instr_i[2]}]
set_drive 0.1  [get_ports {instr_i[1]}]
set_max_fanout 10  [get_ports {instr_i[1]}]
set_drive 0.1  [get_ports {instr_i[0]}]
set_max_fanout 10  [get_ports {instr_i[0]}]
set_drive 0.1  [get_ports {reset}]
set_max_fanout 10  [get_ports {reset}]
set_drive 0.1  [get_ports {vout_addr[1]}]
set_max_fanout 10  [get_ports {vout_addr[1]}]
set_drive 0.1  [get_ports {vout_addr[0]}]
set_max_fanout 10  [get_ports {vout_addr[0]}]
set_load -pin_load -max  0.01  [get_ports {value_o[7]}]
set_load -pin_load -min  0.01  [get_ports {value_o[7]}]
set_load -pin_load -max  0.01  [get_ports {value_o[6]}]
set_load -pin_load -min  0.01  [get_ports {value_o[6]}]
set_load -pin_load -max  0.01  [get_ports {value_o[5]}]
set_load -pin_load -min  0.01  [get_ports {value_o[5]}]
set_load -pin_load -max  0.01  [get_ports {value_o[4]}]
set_load -pin_load -min  0.01  [get_ports {value_o[4]}]
set_load -pin_load -max  0.01  [get_ports {value_o[3]}]
set_load -pin_load -min  0.01  [get_ports {value_o[3]}]
set_load -pin_load -max  0.01  [get_ports {value_o[2]}]
set_load -pin_load -min  0.01  [get_ports {value_o[2]}]
set_load -pin_load -max  0.01  [get_ports {value_o[1]}]
set_load -pin_load -min  0.01  [get_ports {value_o[1]}]
set_load -pin_load -max  0.01  [get_ports {value_o[0]}]
set_load -pin_load -min  0.01  [get_ports {value_o[0]}]
set_load -pin_load -max  0.01  [get_ports {is_positive}]
set_load -pin_load -min  0.01  [get_ports {is_positive}]
set_load -pin_load -max  0.01  [get_ports {easter_egg[2]}]
set_load -pin_load -min  0.01  [get_ports {easter_egg[2]}]
set_load -pin_load -max  0.01  [get_ports {easter_egg[1]}]
set_load -pin_load -min  0.01  [get_ports {easter_egg[1]}]
set_load -pin_load -max  0.01  [get_ports {easter_egg[0]}]
set_load -pin_load -min  0.01  [get_ports {easter_egg[0]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {vout_addr[1]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {vout_addr[1]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[6]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[6]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[4]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[4]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {address[3]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {address[3]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[2]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[2]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {address[1]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {address[1]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[0]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[0]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[7]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[7]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {vout_addr[0]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {vout_addr[0]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[5]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[5]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {address[4]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {address[4]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[3]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[3]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {address[2]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {address[2]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {instr_i[1]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {instr_i[1]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {address[0]}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {address[0]}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {DataOrReg}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {DataOrReg}]
set_input_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {reset}]
set_input_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {reset}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[3]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[3]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {easter_egg[1]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {easter_egg[1]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[1]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[1]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[6]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[6]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[4]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[4]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {easter_egg[2]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {easter_egg[2]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[2]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[2]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {easter_egg[0]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {easter_egg[0]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[0]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[0]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {is_positive}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {is_positive}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[7]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[7]}]
set_output_delay -add_delay 0 -min -clock [get_clocks {clk_i}] [get_ports {value_o[5]}]
set_output_delay -add_delay 1 -max -clock [get_clocks {clk_i}] [get_ports {value_o[5]}]
set_clock_uncertainty 0.1 [get_clocks {clk_i}]
set_ideal_network  [get_ports {clk_i}]
