# dk_include_guard()

##################################################################################
# dk_validateMake()
#
#
#dk_validateMake () {
#	dk_verbose "dk_validateMake($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('$DKIMPORTS_DIR/make/DKMAKE.cmake')" "MAKE_PROGRAM"
#	dk_debug MAKE_PROGRAM
#}