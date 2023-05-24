set_clock_latency 1  [get_clocks {clk_i}]
set_clock_latency -source -early -max -rise  -0.592362 [get_ports {clk_i}] -clock clk_i 
set_clock_latency -source -early -max -fall  -0.28707 [get_ports {clk_i}] -clock clk_i 
set_clock_latency -source -late -max -rise  -0.592362 [get_ports {clk_i}] -clock clk_i 
set_clock_latency -source -late -max -fall  -0.28707 [get_ports {clk_i}] -clock clk_i 
