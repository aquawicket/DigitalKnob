#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
#
#			
dk_cmakeEval () {
	dk_debugFunc
	[ -z "$1" ]           && dk_error "dk_cmakeEval() parameter 1 is invalid"
	
	[ -z "$CMAKE_EXE" ]   && dk_validateCmake
	[ -z "$DKCMAKE_DIR" ] && dk_validateBranch
	
	DKCOMMAND="$1"
	DKRETURN="$2"
	DKVARS="$3"
	#set DKCOMMAND=$DKCOMMAND:"=%"  #TODO: remove double quotes
	
	### build cmake command ###
	set -- #clear the positional parameters
	[ -n "$DKCOMMAND" ] && set -- "$@" "-DDKCOMMAND=$DKCOMMAND" || dk_error "DKCOMMAND is invalid"
	[ -n "$DKRETURN" ]  && set -- "$@" "-DDKRETURN=$DKRETURN"
	[ -n "$DKVARS" ]    && set -- "$@" "$DKVARS"
	set -- "$@" "-P"
	set -- "$@" "$DKCMAKE_DIR/DKEval.cmake"
	
	### call the cmake command 
	dk_call "$CMAKE_EXE" "$@"
	
	### get the return variables
	if [ -n "$DKRETURN" ]; then 
		if dk_fileExists "$DKCMAKE_DIR"/cmake_vars.sh; then
			. "$DKCMAKE_DIR"/cmake_vars.sh
			rm $DKCMAKE_DIR/cmake_vars.sh
		fi
	fi

	#dk_debug return code: $?
}