# This file is a general .xdc for the Basys3 rev B board
# To use it in a project:
# - uncomment the lines corresponding to used pins
# - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]

# Switches
set_property PACKAGE_PIN V17 [get_ports Reset]					
	set_property IOSTANDARD LVCMOS33 [get_ports Reset]
set_property PACKAGE_PIN T1 [get_ports {SW[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]
set_property PACKAGE_PIN R2 [get_ports {SW[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]
set_property PACKAGE_PIN U1 [get_ports {SW[2]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}] 
	
#7 segment display
set_property PACKAGE_PIN W7 [get_ports {Out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[6]}]
set_property PACKAGE_PIN W6 [get_ports {Out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[5]}]
set_property PACKAGE_PIN U8 [get_ports {Out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[4]}]
set_property PACKAGE_PIN V8 [get_ports {Out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[3]}]
set_property PACKAGE_PIN U5 [get_ports {Out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[2]}]
set_property PACKAGE_PIN V5 [get_ports {Out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[1]}]
set_property PACKAGE_PIN U7 [get_ports {Out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Out[0]}]


set_property PACKAGE_PIN U2 [get_ports {AN[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[0]}]
set_property PACKAGE_PIN U4 [get_ports {AN[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[1]}]
set_property PACKAGE_PIN V4 [get_ports {AN[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[2]}]
set_property PACKAGE_PIN W4 [get_ports {AN[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[3]}]


#Buttons
set_property PACKAGE_PIN T17 [get_ports Button]						
	set_property IOSTANDARD LVCMOS33 [get_ports Button]
 
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets Button_IBUF]
