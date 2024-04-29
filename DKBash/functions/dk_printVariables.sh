#!/bin/sh
#. ./DK.sh
dk_includeGuard
#[ -z "$BASH_VERSION" ] || shopt -s expand_aliases # work around for bash

##################################################################################
# dk_printVariables()
#
#
alias dk_printVariables='{
	dk_debugFunc
	
	# https://mywiki.wooledge.org/BashSheet
	# https://www.adminschoice.com/bash-positional-parameters
	
	echo "\$FUNCNAME = $FUNCNAME"
	echo "\${FUNCNAME[0]} = ${FUNCNAME[0]}"
	echo "\${FUNCNAME[1]} = ${FUNCNAME[1]}"
	echo "\$0 = $0" # Expands to bash script file name or bash shell.
	echo "\$@ = $@"	# Lists all command line parameters in a array format.
	echo "\$* = $*"	# Lists all the command line parameters in a single string format.
	echo "\$# = $#" # Numeric count of the command line argument.
	echo "\$? = $?" # Returns the exit status of last executed process.
	echo "\$! = $!" # Gives the process ID of the last job placed into the background
	echo "\$$ = $$" # Expands to the process ID of the shell or invoking shell in case of subshell.
	echo "\$_ = $_" # last argument of the last command that was executed.
	echo "\$- = $-" # List special parameters set for bash.
}'