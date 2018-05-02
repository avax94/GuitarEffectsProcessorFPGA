set_global_assignment -entity "sram" -library "lib_sram" -name IP_TOOL_NAME "altera_up_avalon_sram"
set_global_assignment -entity "sram" -library "lib_sram" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "sram" -library "lib_sram" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_sram" -name SPD_FILE [file join $::quartus(sip_path) "sram.spd"]

set_global_assignment -library "lib_sram" -name MISC_FILE [file join $::quartus(sip_path) "sram_sim/sram.v"]
