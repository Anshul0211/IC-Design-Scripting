open_project [pwd]/Automation/Project_1.xpr 
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1 
##open the created vivado project
 

#looping over all the top modules and running the synthesis and implementation
 
set_property top [string trimright [lindex $argv 0] ".v"] [current_fileset]
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1

# reset and launch the synthesis and implementation. THe process waits till next command is executed

reset_run synth_1  
launch_runs synth_1 -jobs 20
wait_on_run synth_1

# logs the synthesis status of current module
set synth_fp [open "synth_status" w]
puts $synth_fp [get_property STATUS [get_runs synth_1]]
close $synth_fp

reset_run impl_1
launch_runs impl_1 -jobs 20
wait_on_run impl_1

# logs the implementation status of the current module
set impl_fp [open "impl_status" w]
puts $impl_fp [get_property STATUS [get_runs impl_1]]
close $impl_fp

open_run impl_1
report_power > results/[string trimright [lindex $argv 0] ".v"]/power.txt
report_timing > results/[string trimright [lindex $argv 0] ".v"]/timing.txt
report_utilization > results/[string trimright [lindex $argv 0] ".v"]/utilization.txt
update_compile_order -fileset sources_1

close_project
