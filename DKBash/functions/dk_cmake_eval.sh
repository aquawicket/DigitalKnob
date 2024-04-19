# dk_include_guard()

##################################################################################
# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
#
#			
dk_cmake_eval () {
	dk_verbose "dk_cmake_eval($*)"
	
	[ -z "$1" ] && dk_error "dk_cmake_eval() parameter 1 is invalid"
	[ -z "$CMAKE_EXE" ] && dk_validate_cmake
	[ -z "$DKCMAKE_DIR"] && dk_validate_branch
	
	commands="$1"
	variables="$2"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	dk_debug DKCOMMAND
	
	if [ -n "$variables" ]; then
		#dk_call "$CMAKE_EXE" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" "$3" "-P" "$DKCMAKE_DIR"/DKEval.cmake
		dk_call "$CMAKE_EXE" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" "-P" "$DKCMAKE_DIR"/DKEval.cmake
		if dk_file_exists "$DKCMAKE_DIR"/cmake_vars.sh; then
	    	dk_info "executing cmake_vars.sh"
			. "$DKCMAKE_DIR"/cmake_vars.sh
			#rm $DKCMAKE_DIR/cmake_vars.sh
		fi
	else
		dk_call "$CMAKE_EXE" "-DDKCOMMAND=$DKCOMMAND" "-P" "$DKCMAKE_DIR"/DKEval.cmake
	fi
	#dk_debug return code: $?
}