set_global_assignment -entity "audio_clock_gen" -library "lib_audio_clock_gen" -name IP_TOOL_NAME "altera_up_clocks"
set_global_assignment -entity "audio_clock_gen" -library "lib_audio_clock_gen" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "audio_clock_gen" -library "lib_audio_clock_gen" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_audio_clock_gen" -name SPD_FILE [file join $::quartus(sip_path) "audio_clock_gen.spd"]

set_global_assignment -library "lib_audio_clock_gen" -name MISC_FILE [file join $::quartus(sip_path) "audio_clock_gen_sim/audio_clock_gen.v"]
