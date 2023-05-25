set_clock_latency 1  [get_clocks {clk_i}]
set_clock_latency -source -early -max -rise  -0.670061 [get_ports {clk_i}] -clock clk_i 
set_clock_latency -source -early -max -fall  -0.360673 [get_ports {clk_i}] -clock clk_i 
set_clock_latency -source -late -max -rise  -0.670061 [get_ports {clk_i}] -clock clk_i 
set_clock_latency -source -late -max -fall  -0.360673 [get_ports {clk_i}] -clock clk_i 
