set_global_assignment -entity "av_config" -library "lib_av_config" -name IP_TOOL_NAME "altera_up_avalon_audio_and_video_config"
set_global_assignment -entity "av_config" -library "lib_av_config" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "av_config" -library "lib_av_config" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_av_config" -name SPD_FILE [file join $::quartus(sip_path) "av_config.spd"]

set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_serial_bus_controller.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_slow_clock_generator.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_dc2.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_d5m.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_lcm.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ltm.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ob_de2_35.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ob_adv7181.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ob_de2_70.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ob_de2_115.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ob_audio.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/altera_up_av_config_auto_init_ob_adv7180.v"]
set_global_assignment -library "lib_av_config" -name MISC_FILE [file join $::quartus(sip_path) "av_config_sim/av_config.v"]
