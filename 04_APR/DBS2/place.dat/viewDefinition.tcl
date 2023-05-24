if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name lib_max\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fsa0m_a_generic_core_ss1p62v125c.lib\
    ${::IMEX::libVar}/mmmc/fsa0m_a_t33_generic_io_ss1p62v125c.lib]\
   -si\
    [list ${::IMEX::libVar}/mmmc/u18_ss.cdb]
create_rc_corner -name RC_corner\
   -cap_table ${::IMEX::libVar}/mmmc/u18_Faraday.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC_corner/icecaps.tch
create_delay_corner -name Celay_Corner_max\
   -library_set lib_max\
   -rc_corner RC_corner
create_constraint_mode -name func_mode\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/func_mode/func_mode.sdc]
create_analysis_view -name av_func_mode_max -constraint_mode func_mode -delay_corner Celay_Corner_max -latency_file ${::IMEX::dataVar}/mmmc/views/av_func_mode_max/latency.sdc
set_analysis_view -setup [list av_func_mode_max] -hold [list av_func_mode_max]
