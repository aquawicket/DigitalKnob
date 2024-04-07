# dk_include_guard()

##################################################################################
# dk_cmake_eval()
#
#
dk_cmake_eval() {
	dk_debug "dk_cmake_eval($@)"
	if [ -z "$1" ]; then
		echo "ERROR: cmake_eval() parameter 1 is invalid"
		return $false
	fi
	
	commands="$1"
	variables="$2"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	dk_print_var DKCOMMAND
	
	if [[ -n "$variables" ]]; then
		dk_call $CMAKE_EXE "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" $3 -P $DKCMAKE_DIR/dev/cmake_eval.cmake
		if dk_file_exists $DKCMAKE_DIR/cmake_vars.sh; then
	    	echo "executing cmake_vars.sh"
			source $DKCMAKE_DIR/cmake_vars.sh
			#rm $DKCMAKE_DIR/cmake_vars.sh
		fi
	else
		dk_call $CMAKE_EXE "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" -P $DKCMAKE_DIR/dev/cmake_eval.cmake
	fi
	#echo return code: $?
}