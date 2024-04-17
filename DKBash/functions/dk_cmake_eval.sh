# dk_include_guard()

##################################################################################
# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
#
#			
dk_cmake_eval () {
	dk_verbose "dk_cmake_eval($*)"
	
	if [ -z "$1" ]; then
		dk_error "dk_cmake_eval() parameter 1 is invalid"
	fi
	
	commands="$1"
	variables="$2"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	dk_debug DKCOMMAND
	
	if [ -n "$variables" ]; then
		dk_call "$CMAKE_EXE" "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" "$3" -P "$DKCMAKE_DIR"/dev/dk_cmake_eval.cmake
		if dk_file_exists "$DKCMAKE_DIR"/cmake_vars.sh; then
	    	dk_info "executing cmake_vars.sh"
			. "$DKCMAKE_DIR"/cmake_vars.sh
			#rm $DKCMAKE_DIR/cmake_vars.sh
		fi
	else
		dk_call "$CMAKE_EXE" "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" -P "$DKCMAKE_DIR"/dev/dk_cmake_eval.cmake
	fi
	#dk_debug return code: $?
}