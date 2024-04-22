# dk_include_guard()

##################################################################################
# dk_validateMsys2()
#
#
#dk_validateMsys2 () {
#	dk_verbose "dk_validateMsys2($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2"
#	dk_debug MSYS2
#}