# operating conditions and boundary conditions #


create_clock -name clk_i  -period 50.0   [get_ports  clk_i]      ;#Modify period by yourself

set_dont_touch_network      [all_clocks]
set_fix_hold                [all_clocks]
set_clock_uncertainty  0.1  [all_clocks]
set_clock_latency      1.0  [all_clocks]
set_ideal_network           [get_ports clk_i]


#Don't touch the basic env setting as below
set_input_delay  -max 1.0   -clock clk_i [remove_from_collection [all_inputs]  {clk_i}]  
set_input_delay  -min 0.0   -clock clk_i [remove_from_collection [all_inputs]  {clk_i}] 

set_output_delay -max 1.0   -clock clk_i [all_outputs]
set_output_delay -min 0.0   -clock clk_i [all_outputs] 

set_load         0.01  [all_outputs]
set_drive        0.1   [all_inputs]

set_operating_conditions -max_library fsa0m_a_generic_core_ss1p62v125c -max WCCOM

set_max_fanout 10 [all_inputs]

