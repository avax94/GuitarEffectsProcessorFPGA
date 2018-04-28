set_global_assignment -entity "audio_core" -library "lib_audio_core" -name IP_TOOL_NAME "altera_up_avalon_audio"
set_global_assignment -entity "audio_core" -library "lib_audio_core" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "audio_core" -library "lib_audio_core" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_audio_core" -name SPD_FILE [file join $::quartus(sip_path) "audio_core.spd"]

set_global_assignment -library "lib_audio_core" -name MISC_FILE [file join $::quartus(sip_path) "audio_core_sim/altera_up_audio_bit_counter.v"]
set_global_assignment -library "lib_audio_core" -name MISC_FILE [file join $::quartus(sip_path) "audio_core_sim/altera_up_audio_in_deserializer.v"]
set_global_assignment -library "lib_audio_core" -name MISC_FILE [file join $::quartus(sip_path) "audio_core_sim/altera_up_audio_out_serializer.v"]
set_global_assignment -library "lib_audio_core" -name MISC_FILE [file join $::quartus(sip_path) "audio_core_sim/altera_up_clock_edge.v"]
set_global_assignment -library "lib_audio_core" -name MISC_FILE [file join $::quartus(sip_path) "audio_core_sim/altera_up_sync_fifo.v"]
set_global_assignment -library "lib_audio_core" -name MISC_FILE [file join $::quartus(sip_path) "audio_core_sim/audio_core.v"]
